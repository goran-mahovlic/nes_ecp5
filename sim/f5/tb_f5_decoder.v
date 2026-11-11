// F5 korak 1a (TASK-6072): HID izvjestaj -> stanje tipki (f5_hid_buttons: dekoder u USB domeni + CDC u clk_nes).
// DECODER 0 (tipkovnica) i 1 (Emardov NES USB dzojstik, usbh_report_decoder_nes.v). Svaki slucaj: izvjestaj ->
// impuls valid (1 USB takt, kao usbh_host_hid) -> pricekaj 20 taktova clk_nes -> usporedi btn_nes s ocekivanim.
`timescale 1ns/1ps
module tb_f5_decoder;
  reg cu = 0, cn = 0;
  always #84   cu = ~cu;    // 5,952 MHz
  always #46.667 cn = ~cn;  // 10,714 MHz
  reg [63:0] rep = 0; reg val = 0; reg act = 1;
  wire [7:0] bk, bj; wire [7:0] uk, uj;
  f5_hid_buttons #(.DECODER(0)) dk (.clk_usb(cu), .report(rep), .report_valid(val), .active(act), .btn_usb(uk), .clk_nes(cn), .btn_nes(bk));
  f5_hid_buttons #(.DECODER(1)) dj (.clk_usb(cu), .report(rep), .report_valid(val), .active(1'b1), .btn_usb(uj), .clk_nes(cn), .btn_nes(bj));
  integer pass = 0, fail = 0;
  task send(input [63:0] r);
    begin @(posedge cu); rep <= r; val <= 1; @(posedge cu); val <= 0; repeat (20) @(posedge cn); end
  endtask
  task kbd(input [63:0] r, input [7:0] exp, input [8*40-1:0] what);
    begin send(r);
      if (bk === exp) begin pass = pass + 1; $display("  ok   tipkovnica %0s -> %02x", what, bk); end
      else begin fail = fail + 1; $display("  FAIL tipkovnica %0s -> %02x (treba %02x)", what, bk, exp); end end
  endtask
  task joy(input [63:0] r, input [7:0] exp, input [8*40-1:0] what);
    begin send(r);
      if (bj === exp) begin pass = pass + 1; $display("  ok   dzojstik %0s -> %02x", what, bj); end
      else begin fail = fail + 1; $display("  FAIL dzojstik %0s -> %02x (treba %02x)", what, bj, exp); end end
  endtask
  // izvjestaj tipkovnice: kodovi u bajtovima 2..7, modifikatori u bajtu 0
  function [63:0] k(input [7:0] m, input [7:0] c2, input [7:0] c3);
    k = {32'h0, c3, c2, 8'h00, m};
  endfunction
  // izvjestaj NES USB dzojstika (usbh_report_decoder_nes.v): bajt3[7:6] X, bajt4[7:6] Y (00 / 01 mirno / 11),
  // bajt5 bit4 B, bit5 A; bajt6 bit4 Select, bit5 Start
  function [63:0] j(input [1:0] x, input [1:0] y, input a, input b, input st, input se);
    j = {8'h00, {2'b00, st, se, 4'h0}, {2'b00, a, b, 4'h0}, {y, 6'h0}, {x, 6'h0}, 24'h0};
  endfunction
  initial begin
    repeat (5) @(posedge cn);
    kbd(k(8'h00, 8'h28, 8'h00), 8'h08, "Enter = Start");
    kbd(k(8'h00, 8'h00, 8'h00), 8'h00, "otpusteno");
    kbd(k(8'h00, 8'h52, 8'h1B), 8'h11, "Up + X = Up|A");
    kbd(k(8'h00, 8'h4F, 8'h50), 8'hC0, "Right + Left");
    kbd(k(8'h00, 8'h51, 8'h1D), 8'h22, "Down + Z = Down|B");
    kbd(k(8'h20, 8'h2C, 8'h00), 8'h04, "Space + desni Shift = Select");
    kbd(k(8'h05, 8'h00, 8'h00), 8'h03, "LCtrl + LAlt = A|B");
    kbd(k(8'h00, 8'h01, 8'h01), 8'h00, "rollover 0x01 = nista");
    kbd(k(8'h00, 8'h04, 8'h00), 8'h00, "tipka 'a' = nista");
    kbd(k(8'h00, 8'h58, 8'h2B), 8'h0C, "keypad Enter + Tab = Start|Select");
    joy(j(2'b01, 2'b01, 0, 0, 0, 0), 8'h00, "mirno");
    joy(j(2'b01, 2'b01, 0, 0, 1, 0), 8'h08, "Start");
    joy(j(2'b11, 2'b00, 1, 0, 0, 0), 8'h91, "Right + Up + A");
    joy(j(2'b00, 2'b11, 0, 1, 0, 1), 8'h66, "Left + Down + B + Select");
    // valid = 0: novi izvjestaj bez valid ne smije promijeniti tipke
    @(posedge cu); rep <= k(8'h00, 8'h28, 8'h00); repeat (40) @(posedge cn);
    if (bk === 8'h00) begin pass = pass + 1; $display("  ok   bez valid -> tipke ostaju 00"); end
    else begin fail = fail + 1; $display("  FAIL bez valid -> %02x", bk); end
    // active = 0 (host nije u REPORT, Nalaz 1): tipke 0 i lazni izvjestaj FF..FF se ne uzima
    kbd(k(8'h00, 8'h28, 8'h00), 8'h08, "Enter (prije odspajanja)");
    @(posedge cu); act <= 0; repeat (20) @(posedge cn);
    if (bk === 8'h00) begin pass = pass + 1; $display("  ok   active=0 -> tipke otpustene"); end
    else begin fail = fail + 1; $display("  FAIL active=0 -> %02x", bk); end
    kbd(64'hFFFF_FFFF_FFFF_FFFF, 8'h00, "lazni FF..FF uz active=0");
    @(posedge cu); act <= 1; repeat (20) @(posedge cn);
    if (bk === 8'h00) begin pass = pass + 1; $display("  ok   active=1 bez izvjestaja -> 00 (ne stari dekoder)"); end
    else begin fail = fail + 1; $display("  FAIL active=1 bez izvjestaja -> %02x", bk); end
    kbd(k(8'h00, 8'h52, 8'h00), 8'h10, "Up nakon ponovne enumeracije");
    $display("PASS %0d FAIL %0d", pass, fail); $finish;
  end
endmodule
