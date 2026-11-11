// F5 korak 1b (TASK-6072): tipka iz HID izvjestaja kroz f5_hid_buttons (dekoder + CDC) u f4_nes_sys.
// Isto kao sim/f4/tb_f4_frame.v uz BUTTONS (Start u kadrovima [BTN_FROM, BTN_TO)), ali tipku sada daje izvjestaj
// koji tb salje u USB domeni (5,952 MHz) na pocetku kadra BTN_FROM (pritisak) i BTN_TO (otpustanje), kao
// usbh_host_hid (impuls hid_valid jedan USB takt). Ocekivanje: isti slijed CRC-ova kadrova kao tb_f4_frame s BUTTONS.
`timescale 1ns/1ps
module tb_f5_frame;
  parameter integer NFRAMES = 200;
  parameter integer DECODER = 0;
  parameter [63:0] REP_ON  = 64'h0000_0000_0028_0000;   // tipkovnica: Enter = Start
  parameter [63:0] REP_OFF = 64'h0;
  parameter integer BTN_FROM = 60, BTN_TO = 70;
  reg clk = 0, cu = 0, rst = 1;
  always #46.667 clk = ~clk;            // 10,714 MHz
  always #84 cu = ~cu;                  // 5,952 MHz
  wire [5:0] color; wire [8:0] cycle, scanline; wire [7:0] btns, bu;
  f4_nes_sys dut (
    .clk(clk), .reset(rst), .buttons(btns), .color(color), .cycle(cycle), .scanline(scanline),
    .cpu_ce(), .cpu_laddr(), .cpu_wr(), .cpu_wdata(), .cpu_pc(cpc), .cpu_nmi());
  wire [15:0] cpc;
  wire pv, fd; wire [7:0] px, py; wire [5:0] pc; wire [31:0] fcrc; wire [16:0] fpix;
  f4_frame_crc u_crc (.clk(clk), .color(color), .cycle(cycle), .scanline(scanline),
    .pix_valid(pv), .pix_x(px), .pix_y(py), .pix_c(pc), .frame_done(fd), .frame_crc(fcrc), .frame_pix(fpix));
  reg [63:0] rep = 0; reg val = 0;
  f5_hid_buttons #(.DECODER(DECODER)) u_hid (.clk_usb(cu), .report(rep), .report_valid(val), .active(1'b1), .btn_usb(bu),
    .clk_nes(clk), .btn_nes(btns));
  integer nf = 0;
  initial begin
    dut.nes.cpu.n768 = 0; dut.nes.cpu.n773 = 0; dut.nes.cpu.n778 = 0;
    repeat (20) @(posedge clk); rst = 0;
  end
  // izvjestaj u USB domeni kad zavrsi kadar BTN_FROM-1 / BTN_TO-1 (tb_f4_frame: nf >= BTN_FROM odmah nakon fd)
  reg want_on = 0, want_off = 0;
  always @(posedge clk) if (fd) begin
    if (nf + 1 == BTN_FROM) want_on <= 1;
    if (nf + 1 == BTN_TO) want_off <= 1;
  end
  always @(posedge cu) begin
    val <= 0;
    if (want_on)  begin rep <= REP_ON;  val <= 1; want_on = 0; end
    if (want_off) begin rep <= REP_OFF; val <= 1; want_off = 0; end
  end
  integer t_fd = 0, clks = 0;
  always @(posedge clk) if (!rst) begin
    clks = clks + 1;
    if (fd) begin nf = nf + 1; t_fd = clks;
      $display("KADAR %0d CRC %08X pikseli %0d tipke %02x PC %04X", nf, fcrc, fpix, btns, cpc);
      if (nf == NFRAMES) $finish;
    end
  end
  // kasnjenje fd -> tipka u clk_nes (mjera CDC-a)
  reg [7:0] bprev = 0;
  always @(posedge clk) begin bprev <= btns; if (btns != bprev) $display("TIPKE %02x -> %02x, %0d taktova clk_nes nakon kraja kadra %0d", bprev, btns, clks - t_fd, nf); end
endmodule
