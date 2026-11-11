// F1 (TASK-6068): mjeri sve taktove sloja platforme brojacima prema clk25 (1 s = 25 000 000
// taktova clk25) i ispisuje Hz na UART 115200 8N1 jednom u sekundi:
//   F1 T=<s> S=<Hz 125> P=<Hz 25> U=<Hz 5,95> N=<Hz 10,71> L=<lock1><lock2> R=<reset bitovi>
// LED (aktivne u 0): 0 = clk25 (ref), 1 = clk_shift, 2 = clk_pixel, 3 = clk_usb, 4 = clk_nes,
//   5 = locked_video, 6 = locked_nes, 7 = UART redak (bljesak).
// SDRAM pin dobiva takt iz gm_sdram_clk (CC_ODDR, INV) -- ovdje radi samo kao izlaz.
module f1_clkmeter #(
  parameter integer GATE = 25000000,   // taktova clk25 po mjerenju
  parameter integer BAUD_DIV = 217
) (
  input        clk_25mhz,
  input  [2:0] btn,
  output [7:0] led,
  output       uart_tx,
  output       uart_tx2,
  output       sdram_clk
);
  localparam integer NF = 4;           // S P U N
  localparam integer W  = 28;

  wire clk_shift, clk_pixel, clk_usb, clk_nes;
  wire rst_shift, rst_pixel, rst_usb, rst_nes, locked_video, locked_nes;
  gm_clocks u_clk (
    .clk25(clk_25mhz), .rst_i(1'b0),
    .clk_shift(clk_shift), .rst_shift(rst_shift),
    .clk_pixel(clk_pixel), .rst_pixel(rst_pixel),
    .clk_usb(clk_usb),     .rst_usb(rst_usb),
    .clk_nes(clk_nes),     .rst_nes(rst_nes),
    .locked_video(locked_video), .locked_nes(locked_nes),
    .sdram_clk(sdram_clk));

  // ---- brojaci u mjerenim domenama ----
  wire [W-1:0] g [0:NF-1];
  wire [NF-1:0] dled;
  f1_cnt_gray #(.W(W), .LEDBIT(26)) c_s (.clk(clk_shift), .rst(rst_shift), .gray(g[0]), .led(dled[0]));
  f1_cnt_gray #(.W(W), .LEDBIT(24)) c_p (.clk(clk_pixel), .rst(rst_pixel), .gray(g[1]), .led(dled[1]));
  f1_cnt_gray #(.W(W), .LEDBIT(22)) c_u (.clk(clk_usb),   .rst(rst_usb),   .gray(g[2]), .led(dled[2]));
  f1_cnt_gray #(.W(W), .LEDBIT(23)) c_n (.clk(clk_nes),   .rst(rst_nes),   .gray(g[3]), .led(dled[3]));

  // ---- referentna domena clk25 ----
  reg [W-1:0] s1 [0:NF-1], s2 [0:NF-1], prev [0:NF-1], val [0:NF-1];
  reg [24:0] gate = 25'd0;
  reg [24:0] refled = 25'd0;
  reg [27:0] secs = 28'd0;
  reg tick = 1'b0;
  reg [3:0] rsync1 = 4'hf, rsync2 = 4'hf;
  reg [1:0] lsync1 = 2'b00, lsync2 = 2'b00;
  reg [3:0] rsnap = 4'hf;
  reg [1:0] lsnap = 2'b00;

  function [W-1:0] g2b(input [W-1:0] x);
    integer k;
    begin
      g2b[W-1] = x[W-1];
      for (k = W-2; k >= 0; k = k - 1) g2b[k] = g2b[k+1] ^ x[k];
    end
  endfunction

  integer i, j;
  always @(posedge clk_25mhz) begin
    refled <= refled + 1'b1;
    rsync1 <= {rst_nes, rst_usb, rst_pixel, rst_shift}; rsync2 <= rsync1;
    lsync1 <= {locked_nes, locked_video};               lsync2 <= lsync1;
    for (i = 0; i < NF; i = i + 1) begin s1[i] <= g[i]; s2[i] <= s1[i]; end
    tick <= 1'b0;
    if (gate == GATE - 1) begin
      gate <= 0; tick <= 1'b1; secs <= secs + 1'b1;
      rsnap <= rsync2; lsnap <= lsync2;
      for (i = 0; i < NF; i = i + 1) begin
        val[i]  <= g2b(s2[i]) - prev[i];
        prev[i] <= g2b(s2[i]);
      end
    end else gate <= gate + 1'b1;
  end

  // ---- ispis retka ----
  // predlozak: obicni znak ili 8'h80+k = decimalni ispis polja k (k=0..3), 8'h90 = sekunde,
  // 8'hA0/8'hA1 = lock1/lock2, 8'hB0..B3 = reset bitovi, 8'hFF = kraj.
  function [7:0] tpl(input [6:0] p);
    case (p)
      0: tpl="F"; 1: tpl="1"; 2: tpl=" "; 3: tpl="T"; 4: tpl="="; 5: tpl=8'h90;
      6: tpl=" "; 7: tpl="S"; 8: tpl="="; 9: tpl=8'h80;
      10: tpl=" "; 11: tpl="P"; 12: tpl="="; 13: tpl=8'h81;
      14: tpl=" "; 15: tpl="U"; 16: tpl="="; 17: tpl=8'h82;
      18: tpl=" "; 19: tpl="N"; 20: tpl="="; 21: tpl=8'h83;
      22: tpl=" "; 23: tpl="L"; 24: tpl="="; 25: tpl=8'hA0; 26: tpl=8'hA1;
      27: tpl=" "; 28: tpl="R"; 29: tpl="="; 30: tpl=8'hB0; 31: tpl=8'hB1; 32: tpl=8'hB2; 33: tpl=8'hB3;
      34: tpl=8'h0d; 35: tpl=8'h0a;
      default: tpl=8'hff;
    endcase
  endfunction

  function [W-1:0] p10(input [3:0] d);
    case (d)
      0: p10=1; 1: p10=10; 2: p10=100; 3: p10=1000; 4: p10=10000; 5: p10=100000;
      6: p10=1000000; 7: p10=10000000; default: p10=100000000;
    endcase
  endfunction

  reg [6:0]   pos = 7'd0;
  reg         busy = 1'b0, indec = 1'b0, started = 1'b0;
  reg [W-1:0] v = 0;
  reg [3:0]   dig = 4'd0, cnt10 = 4'd0;
  reg [W-1:0] lval [0:NF-1];
  reg [27:0]  lsecs = 0;
  reg [3:0]   lr = 0;
  reg [1:0]   ll = 0;
  reg         ustart = 1'b0;
  reg  [7:0]  ubyte = 8'd0;
  wire        uready;
  reg [22:0]  blink = 0;

  wire [7:0] t = tpl(pos);
  always @(posedge clk_25mhz) begin
    ustart <= 1'b0;
    if (blink != 0) blink <= blink - 1'b1;
    if (!busy) begin
      if (tick) begin
        busy <= 1'b1; pos <= 0; blink <= 23'h7fffff;
        for (j = 0; j < NF; j = j + 1) lval[j] <= val[j];
        lsecs <= secs; lr <= rsnap; ll <= lsnap;
      end
    end else if (indec) begin
      // decimalno: oduzimanje 10^dig, vodece nule se ne ispisuju
      if (v >= p10(dig)) begin v <= v - p10(dig); cnt10 <= cnt10 + 1'b1; end
      else if (uready && !ustart) begin
        if (cnt10 != 0 || started || dig == 0) begin
          ubyte <= "0" + cnt10; ustart <= 1'b1; started <= 1'b1;
        end
        cnt10 <= 0;
        if (dig == 0) begin indec <= 1'b0; pos <= pos + 1'b1; end
        else dig <= dig - 1'b1;
      end
    end else if (uready && !ustart) begin
      if (t == 8'hff) busy <= 1'b0;
      else if (t[7:4] == 4'h8 || t == 8'h90) begin
        indec <= 1'b1; started <= 1'b0; cnt10 <= 0; dig <= 4'd8;
        v <= (t == 8'h90) ? lsecs : lval[t[1:0]];
      end else if (t[7:4] == 4'hA) begin
        ubyte <= "0" + ll[t[0]]; ustart <= 1'b1; pos <= pos + 1'b1;
      end else if (t[7:4] == 4'hB) begin
        ubyte <= "0" + lr[t[1:0]]; ustart <= 1'b1; pos <= pos + 1'b1;
      end else begin
        ubyte <= t; ustart <= 1'b1; pos <= pos + 1'b1;
      end
    end
  end

  wire txw;
  f1_uart_tx #(.DIV(BAUD_DIV)) u_tx (.clk(clk_25mhz), .start(ustart), .data(ubyte), .ready(uready), .tx(txw));
  assign uart_tx  = txw;
  assign uart_tx2 = txw;

  assign led = ~{blink != 0, locked_nes, locked_video, dled[3], dled[2], dled[1], dled[0], refled[24]};
endmodule
