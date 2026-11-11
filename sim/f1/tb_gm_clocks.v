// Vrata 1 za F1 (TASK-6068): gm_clocks s modelom CC_PLL.
// Provjerava: omjere djelitelja (/5, /21), frekvenciju PLL izlaza, ispunu clk_pixel,
// SDRAM pin = ~clk_nes (CC_ODDR, INV), redoslijed reseta (lock -> sinkrono otpustanje po
// domeni, asinkrono postavljanje na rst_i). Ispis "PASS n / FAIL n".
`timescale 1ps/1fs
module tb_gm_clocks;
  reg clk25 = 1'b0;
  always #20000 clk25 = ~clk25;           // 25 MHz
  reg rst_i = 1'b0;

  wire clk_shift, clk_pixel, clk_usb, clk_nes, sdram_clk;
  wire rst_shift, rst_pixel, rst_usb, rst_nes, locked_video, locked_nes;
  gm_clocks dut (.clk25(clk25), .rst_i(rst_i),
    .clk_shift(clk_shift), .rst_shift(rst_shift), .clk_pixel(clk_pixel), .rst_pixel(rst_pixel),
    .clk_usb(clk_usb), .rst_usb(rst_usb), .clk_nes(clk_nes), .rst_nes(rst_nes),
    .locked_video(locked_video), .locked_nes(locked_nes), .sdram_clk(sdram_clk));

  integer pass = 0, fail = 0;
  task chk(input ok, input [8*64-1:0] what);
    begin
      if (ok) begin pass = pass + 1; $display("  ok   %0s", what); end
      else    begin fail = fail + 1; $display("  FAIL %0s", what); end
    end
  endtask

  // --- nadzor: reset domene nikad ne smije pasti dok lock nije gore ---
  integer viol = 0;
  always @(negedge rst_shift) if (!locked_video) viol = viol + 1;
  always @(negedge rst_pixel) if (!locked_video) viol = viol + 1;
  always @(negedge rst_usb)   if (!locked_video) viol = viol + 1;
  always @(negedge rst_nes)   if (!locked_nes)   viol = viol + 1;
  // reset se otpusta sinkrono: odmah nakon rastuceg brida vlastitog takta
  realtime t_shift = 0, t_pixel = 0, t_usb = 0, t_nes = 0;
  always @(posedge clk_shift) t_shift = $realtime;
  always @(posedge clk_pixel) t_pixel = $realtime;
  always @(posedge clk_usb)   t_usb   = $realtime;
  always @(posedge clk_nes)   t_nes   = $realtime;
  integer async_rel = 0;
  always @(negedge rst_shift) if ($realtime - t_shift > 1000) async_rel = async_rel + 1;
  always @(negedge rst_pixel) if ($realtime - t_pixel > 1000) async_rel = async_rel + 1;
  always @(negedge rst_usb)   if ($realtime - t_usb   > 1000) async_rel = async_rel + 1;
  always @(negedge rst_nes)   if ($realtime - t_nes   > 1000) async_rel = async_rel + 1;

  // --- brojaci bridova ---
  integer n_s = 0, n_p = 0, n_u = 0, n_n = 0; reg counting = 1'b0;
  always @(posedge clk_shift) if (counting) n_s = n_s + 1;
  always @(posedge clk_pixel) if (counting) n_p = n_p + 1;
  always @(posedge clk_usb)   if (counting) n_u = n_u + 1;
  always @(posedge clk_nes)   if (counting) n_n = n_n + 1;

  // ispuna clk_pixel
  realtime pr = 0, ph_min = 1e12, ph_max = 0;
  always @(posedge clk_pixel) pr = $realtime;
  always @(negedge clk_pixel) if (counting && pr > 0) begin
    if ($realtime - pr < ph_min) ph_min = $realtime - pr;
    if ($realtime - pr > ph_max) ph_max = $realtime - pr;
  end
  // SDRAM pin = ~clk_nes (provjera 1 ns nakon svakog brida clk_nes)
  integer sd_bad = 0, sd_chk = 0;
  always @(clk_nes) if (counting) begin #1000; sd_chk = sd_chk + 1; if (sdram_clk !== ~clk_nes) sd_bad = sd_bad + 1; end

  function integer near(input integer got, input real exp, input real tol);
    near = (got >= exp - tol) && (got <= exp + tol);
  endfunction

  localparam real WIN_US = 200.0;
  reg [8*64-1:0] msg;
  initial begin
    $display("F1 tb_gm_clocks: start");
    #5000000;   // 5 us: model lock je na 20 us
    chk(rst_shift && rst_pixel && rst_usb && rst_nes, "prije locka: svi reseti domena = 1");
    chk(!locked_video && !locked_nes, "prije locka: locked_* = 0");
    wait (locked_video && locked_nes);
    #2000000;
    chk(!rst_shift && !rst_pixel && !rst_usb && !rst_nes, "nakon locka (+2 us): svi reseti otpusteni");
    counting = 1'b1;
    #(WIN_US * 1000000);
    counting = 1'b0;
    $display("  bridova u %0.0f us: S=%0d P=%0d U=%0d N=%0d", WIN_US, n_s, n_p, n_u, n_n);
    $sformat(msg, "clk_shift 125 MHz (%0d/25000)", n_s);        chk(near(n_s, 25000.0, 1), msg);
    $sformat(msg, "clk_pixel = shift/5 (%0d/5000)", n_p);       chk(near(n_p, 5000.0, 1), msg);
    $sformat(msg, "clk_usb = shift/21 (%0d/1190.5)", n_u);      chk(near(n_u, 25000.0/21.0, 1), msg);
    $sformat(msg, "clk_nes 10,714 MHz (%0d/2142.9)", n_n);      chk(near(n_n, 200.0*10.714285, 1), msg);
    // divide_5 iz LiteX_DVI: 3,5 od 5 taktova visoko = 28 ns (70 %), stabilno svaki period
    $sformat(msg, "clk_pixel ispuna 70 %% kao LiteX divide_5 (vis %0.0f..%0.0f ps)", ph_min, ph_max);
    chk(ph_min > 27900 && ph_max < 28100, msg);
    $sformat(msg, "sdram_clk = ~clk_nes (%0d/%0d krivih)", sd_bad, sd_chk); chk(sd_chk > 100 && sd_bad == 0, msg);
    chk(viol == 0, "reset domene nikad otpusten bez locka");
    chk(async_rel == 0, "otpustanje reseta sinkrono s vlastitim taktom");
    // asinkrono postavljanje na rst_i
    rst_i = 1'b1; #1000;
    chk(!locked_video && !locked_nes, "rst_i=1: locked_* odmah 0");
    chk(rst_shift && rst_pixel && rst_usb && rst_nes, "rst_i=1: reseti domena odmah 1 (asinkrono)");
    #1000000; rst_i = 1'b0; #2000000;
    chk(!rst_shift && !rst_pixel && !rst_usb && !rst_nes, "rst_i=0: reseti ponovno otpusteni");
    chk(viol == 0 && async_rel == 0, "nakon rst_i: redoslijed i dalje ispravan");
    $display("F1 tb_gm_clocks: PASS %0d FAIL %0d", pass, fail);
    $finish;
  end
endmodule
