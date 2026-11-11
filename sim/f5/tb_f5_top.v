// F5 vrata 1d (TASK-6072): cijeli f5_top (gm_clocks s modelom CC_PLL + NES + vga/gm_dvi + CRC + UART + USB host)
// sa skracenom sekundom (SEC) i brzim UART-om (BAUD_DIV=4), REF_FRAME 8, kao tb_f4_top.
// DEV=0: na J5 nista (pull-down hosta -> SE0): host ostaje DETACHED (L[1:0]=0), U=0000, J=00; F4 polja kao tb_f4_top.
// DEV=1: LS uredaj prikljucen (pull-up 1k5 na D-, kao low-speed tipkovnica/dzojstik): host mora vidjeti J
//        (LINESTATE != 0) i krenuti u SETUP (R_state != 0) -- dokaz da host na clk_usb (125/21) radi.
`timescale 1ps/1fs
module tb_f5_top;
  parameter integer DEV = 0;
  parameter [31:0] H8 = 32'hCC4831F3;
  reg clk = 1'b0;
  always #20000 clk = ~clk;
  wire [7:0] led; wire tx, tx2; wire [3:0] dp, dn; wire udp, udn, pdp, pdn;
  pulldown (udp);
  generate if (DEV) begin : g_dev pullup (udn); end else begin : g_nodev pulldown (udn); end endgenerate
  f5_top #(.SEC(1200000), .BAUD_DIV(4), .REF_FRAME(8), .H_REF(H8)) dut (.clk_25mhz(clk), .btn(3'b111),
    .led(led), .uart_tx(tx), .uart_tx2(tx2), .usb_fpga_bd_dp(udp), .usb_fpga_bd_dn(udn),
    .usb_fpga_pu_dp(pdp), .usb_fpga_pu_dn(pdn), .gpdi_dp(dp), .gpdi_dn(dn));
  initial begin dut.u_nes.nes.cpu.n768 = 8'h00; dut.u_nes.nes.cpu.n773 = 8'h00; dut.u_nes.nes.cpu.n778 = 8'h00; end

  integer pass = 0, fail = 0, nl = 0, k, nch = 0;
  reg [7:0] b; reg [8*110-1:0] line = 0; reg [8*4-1:0] f_prev = 0; reg [7:0] lv;
  task chk(input ok, input [8*64-1:0] what);
    begin if (ok) begin pass = pass + 1; $display("  ok   %0s", what); end
          else begin fail = fail + 1; $display("  FAIL %0s", what); end end
  endtask
  function [8*16-1:0] fld(input integer i, input integer w);
    integer j; begin fld = 0; for (j = 0; j < w; j = j + 1) fld = {fld[8*15-1:0], line[8*(nch-1-i-j) +: 8]}; end
  endfunction
  function [3:0] hx(input [7:0] c); hx = (c >= "A") ? c - "A" + 10 : c - "0"; endfunction
  always begin
    @(negedge tx);
    repeat (6) @(posedge dut.clk_nes);
    for (k = 0; k < 8; k = k + 1) begin b[k] = tx; repeat (4) @(posedge dut.clk_nes); end
    if (b == 8'h0a) begin
      nl = nl + 1;
      $display("UART: %0s", line);
      lv = {hx(fld(102, 2) >> 8), hx(fld(102, 2))};
      chk(nch == 105, "duljina retka 104 + CR");
      chk(fld(0, 2) == "F5", "redak F5");
      chk(fld(41, 5) == "0F000", "N=0F000 (61440 piksela u kadru)");
      chk(fld(67, 1) == "7", "K=7 (tipke GS-a otpustene)");
      chk(fld(71, 2) == "00", "J=00 (nema pritisnute tipke ni s USB-a)");
      chk(fld(76, 4) == "0000", "U=0000 (nema HID izvjestaja)");
      chk(pdp === 1'b0 && pdn === 1'b0, "pull D+/D- = 0 (host pull-down)");
      if (DEV == 0) chk(lv[1:0] == 2'b00 && lv[3:2] == 2'b00, "L: DETACHED, LINESTATE SE0 (nema uredaja)");
      if (fld(12, 4) >= "0008") begin
        chk(fld(19, 8) == "CC4831F3", "H = CRC kadra 8 iz tb_f4_frame (CC4831F3)");
        chk(fld(57, 2) == "01", "V=01 ($0701: igra je prepoznala NTSC)");
        chk(fld(62, 2) != "00", "I>0 (NMI tece)");
        chk(fld(12, 4) > f_prev, "F raste");
        if (DEV == 1) begin
          chk(lv[3:2] != 2'b00, "L: LINESTATE != SE0 (host vidi LS uredaj)");
          chk(lv[1:0] != 2'b00, "L: R_state != DETACHED (host je krenuo u reset/SETUP)");
        end
        $display("PASS %0d FAIL %0d", pass, fail); $finish;
      end
      f_prev = fld(12, 4);
      line = 0; nch = 0;
    end else begin line = {line[8*109-1:0], b}; nch = nch + 1; end
  end
  initial begin #(64'd600_000_000_000); $display("TIMEOUT PASS %0d FAIL %0d", pass, fail + 1); $finish; end
endmodule
