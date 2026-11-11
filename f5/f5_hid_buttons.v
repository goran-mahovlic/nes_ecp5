// F5 (TASK-6072): HID izvjestaj (USB domena) -> dekoder -> CDC -> tipke NES-a u clk_nes.
// Isti modul u simulaciji (sim/f5/tb_f5_frame.v, izvjestaji iz tb-a) i u bitu (f5_usb_joy, izvjestaji iz usbh_host_hid).
//   DECODER 0 = USB boot tipkovnica (f5_report_decoder_kbd), 1 = Emardov NES USB dzojstik (usb/report_decoder/
//   usbh_report_decoder_nes.v, kao top.v).
// active = 0 (host nije u stanju REPORT: nema uredaja, enumeracija, reset) -> izvjestaj se ne uzima i tipke su 0.
//   Nalaz 1 (F5): usbh_host_hid ima registre bez pocetne vrijednosti (R_hid_valid, R_report_buf); na plocici je nakon
//   konfiguracije bez uredaja na J5 stigao jedan lazni izvjestaj R=FF..FF -> tipkovnica A+B+Select stalno pritisnute.
// CDC: 8 bitova se mijenja najvise jednom po izvjestaju (>= 1 ms), pa je dovoljno 2 FF + prihvat tek kad su dva
// uzastopna uzorka jednaka (nikad poderana kombinacija bitova).  Kasnjenje: <= 2 USB takta + 3 takta clk_nes.
module f5_hid_buttons #(
  parameter integer DECODER = 0
) (
  input         clk_usb,
  input  [63:0] report,
  input         report_valid,     // impuls/razina iz usbh_host_hid (dekoder uzima na svaki takt s valid=1)
  input         active,           // 1 = host u stanju REPORT (uredaj enumeriran), USB domena
  output  [7:0] btn_usb,          // dekodirano i maskirano s active, USB domena
  input         clk_nes,
  output reg [7:0] btn_nes = 8'h00
);
  wire [7:0] dec; wire v = report_valid & active;
  generate if (DECODER == 1) begin : g_nes
    usbh_report_decoder #(.c_clk_hz(5952381)) u_dec (.i_clk(clk_usb), .i_report(report), .i_report_valid(v), .o_btn(dec));
  end else begin : g_kbd
    f5_report_decoder_kbd u_dec (.i_clk(clk_usb), .i_report(report), .i_report_valid(v), .o_btn(dec));
  end endgenerate
  // got: od prvog valjanog izvjestaja u ovom REPORT razdoblju; registar dekodera bez inita (Emardov o_btn) se tako
  // ne vidi prije prvog izvjestaja. got i dekoder se upisuju u istom taktu (nakon v).
  reg got = 1'b0;
  always @(posedge clk_usb) got <= active & (got | v);
  assign btn_usb = got ? dec : 8'h00;

  (* async_reg = "true" *) reg [7:0] s1 = 8'h00, s2 = 8'h00;
  reg [7:0] s3 = 8'h00;
  always @(posedge clk_nes) begin
    s1 <= btn_usb; s2 <= s1; s3 <= s2;
    if (s2 == s3) btn_nes <= s3;
  end
endmodule
