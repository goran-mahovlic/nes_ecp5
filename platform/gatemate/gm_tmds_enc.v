// Protocni TMDS koder (DVI 1.0, 3.2.2) za GateMate: 3 registrirana stupnja u domeni piksela
// (F2, TASK-6069). Kodira isto kao NES-ov tmds_encoder.v (Mike Field), ali razlomljeno:
//   1: q_m (minimiziranje prijelaza)   2: broj jedinica q_m   3: DC uravnotezenje (puni cnt)
// Latencija 3 takta; d/c/de moraju dolaziti iz registara (gm_dvi ih registrira).
// c = {vsync, hsync} samo za plavi kanal.
module gm_tmds_enc (
  input            clk,
  input      [7:0] d,
  input      [1:0] c,
  input            de,     // 1 = podatkovno razdoblje, 0 = kontrolni simbol
  output reg [9:0] q = 10'b1101010100
);
  // ---- stupanj 1: q_m ----
  wire [3:0] n1d = d[0] + d[1] + d[2] + d[3] + d[4] + d[5] + d[6] + d[7];
  wire       use_xnor = (n1d > 4'd4) || (n1d == 4'd4 && !d[0]);
  wire [8:0] qm;
  assign qm[0] = d[0];
  genvar i;
  generate for (i = 1; i < 8; i = i + 1) begin : g_qm
    assign qm[i] = use_xnor ? ~(qm[i-1] ^ d[i]) : (qm[i-1] ^ d[i]);
  end endgenerate
  assign qm[8] = ~use_xnor;

  reg [8:0] qm0 = 9'd0;
  reg       de0 = 1'b0;
  reg [1:0] c0 = 2'b00;
  always @(posedge clk) begin
    qm0 <= qm; de0 <= de; c0 <= c;
  end

  // ---- stupanj 2: broj jedinica q_m[7:0] ----
  reg [8:0] qm1 = 9'd0;
  reg [3:0] n1q1 = 4'd0;
  reg       de1 = 1'b0;
  reg [1:0] c1 = 2'b00;
  always @(posedge clk) begin
    qm1  <= qm0;
    n1q1 <= qm0[0] + qm0[1] + qm0[2] + qm0[3] + qm0[4] + qm0[5] + qm0[6] + qm0[7];
    de1  <= de0; c1 <= c0;
  end

  // ---- stupanj 3: DC uravnotezenje (cnt = N1 - N0 odaslanih, puni opseg) ----
  reg  signed [5:0] cnt = 6'sd0;
  wire signed [5:0] diff = $signed({1'b0, n1q1, 1'b0}) - 6'sd8;   // N1 - N0 = 2*N1 - 8
  always @(posedge clk) begin
    if (!de1) begin
      case (c1)
        2'b00:   q <= 10'b1101010100;
        2'b01:   q <= 10'b0010101011;
        2'b10:   q <= 10'b0101010100;
        default: q <= 10'b1010101011;
      endcase
      cnt <= 6'sd0;
    end else if (cnt == 0 || n1q1 == 4'd4) begin
      q   <= {~qm1[8], qm1[8], qm1[8] ? qm1[7:0] : ~qm1[7:0]};
      cnt <= qm1[8] ? cnt + diff : cnt - diff;
    end else if ((cnt > 0 && n1q1 > 4'd4) || (cnt < 0 && n1q1 < 4'd4)) begin
      q   <= {1'b1, qm1[8], ~qm1[7:0]};
      cnt <= cnt + $signed({4'd0, qm1[8], 1'b0}) - diff;
    end else begin
      q   <= {1'b0, qm1[8], qm1[7:0]};
      cnt <= cnt - $signed({4'd0, ~qm1[8], 1'b0}) + diff;
    end
  end
endmodule
