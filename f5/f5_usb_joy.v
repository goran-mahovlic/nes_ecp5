// F5 (TASK-6072): USB 1.1 low-speed HID host (Emard usbh_host_hid, kao top.v i litex-eth-ulx5m-gs-1g-sbc usb_hid.py)
// na clk_usb = 125/21 = 5,952 MHz (gm_clocks, lokalno rutanje, -0,79 %, LS dopusta +-1,5 %) -> tipke NES-a u clk_nes.
// Host: pull-down 15k na D+ i D- (pu_* = 0, kao usb_hid.py). Ulaz usb_dif = D+ (low speed cita D+).
// Dijagnostika (za UART, clk_nes, prihvat kad su dva uzorka jednaka): broj izvjestaja, zadnji izvjestaj, LED hosta
//   led = {reset_pending, txover, setup_acked[3], LINESTATE[1:0], R_state[1:0]};  R_state 2 = REPORT (enumeriran).
module f5_usb_joy #(
  parameter integer DECODER  = 0,     // 0 tipkovnica, 1 NES USB dzojstik
  parameter integer REP_LEN  = 8
) (
  input         clk_usb,
  input         rst_usb,
  inout         usb_dp,
  inout         usb_dn,
  output        pu_dp,
  output        pu_dn,
  input         clk_nes,
  output  [7:0] btn_nes,
  output reg [15:0] dbg_count = 0,    // clk_nes
  output reg [63:0] dbg_report = 0,
  output reg  [7:0] dbg_led = 0
);
  assign pu_dp = 1'b0;
  assign pu_dn = 1'b0;

  wire [8*REP_LEN-1:0] rep; wire valid; wire [7:0] led;
  usbh_host_hid #(
    .C_usb_speed(0), .C_report_length(REP_LEN), .C_report_length_strict(0),
    .C_setup_rom_file("usb/usbhost/usbh_setup_rom.mem")
  ) u_host (
    .clk(clk_usb), .bus_reset(rst_usb), .usb_dif(usb_dp), .usb_dp(usb_dp), .usb_dn(usb_dn),
    .led(led), .rx_count(), .rx_done(), .hid_report(rep), .hid_valid(valid));

  // Nalaz 1: izvjestaj vrijedi samo u stanju REPORT (led[1:0] = R_state = 2) i izvan reseta
  wire active = (led[1:0] == 2'b10) & ~rst_usb;
  wire ok = valid & active;
  f5_hid_buttons #(.DECODER(DECODER)) u_btn (
    .clk_usb(clk_usb), .report(rep[63:0]), .report_valid(valid), .active(active), .btn_usb(),
    .clk_nes(clk_nes), .btn_nes(btn_nes));

  // ---- dijagnostika: hvatanje u USB domeni (kao usb_hid.py), CDC kao f5_hid_buttons ----
  reg valid_d = 1'b0; reg [63:0] r_rep = 0; reg [15:0] r_cnt = 0;
  always @(posedge clk_usb) begin
    valid_d <= ok;
    if (ok && !valid_d) begin r_rep <= rep[63:0]; r_cnt <= r_cnt + 1'b1; end
  end
  (* async_reg = "true" *) reg [87:0] d1 = 0, d2 = 0;
  reg [87:0] d3 = 0;
  always @(posedge clk_nes) begin
    d1 <= {r_cnt, r_rep, led}; d2 <= d1; d3 <= d2;
    if (d2 == d3) {dbg_count, dbg_report, dbg_led} <= d3;
  end
endmodule
