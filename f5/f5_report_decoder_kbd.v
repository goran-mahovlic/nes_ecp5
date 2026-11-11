// F5 (TASK-6072): USB boot tipkovnica (HID izvjestaj 8 B) -> 8 tipki NES-a, u USB domeni (kao usbh_report_decoder).
// Izvjestaj (usbh_host_hid.hid_report): bajt 0 = bitovi 7:0 = modifikatori, bajt 1 rezerviran, bajtovi 2..7 = kodovi tipki.
// Izlaz (aktivan u 1): {Right, Left, Down, Up, Start, Select, B, A} = redoslijed citanja $4016.
//   strelice -> kriz;  Enter (0x28, keypad 0x58) -> Start;  Space (0x2C), Tab (0x2B), desni Shift -> Select;
//   X (0x1B), lijevi Ctrl -> A;  Z (0x1D), lijevi Alt -> B.   Kod 0x01 (rollover) se ne broji ni kao koja tipka.
module f5_report_decoder_kbd (
  input  wire        i_clk,
  input  wire [63:0] i_report,
  input  wire        i_report_valid,
  output reg   [7:0] o_btn = 8'h00
);
  function has(input [63:0] r, input [7:0] code);
    integer i;
    begin has = 1'b0; for (i = 2; i < 8; i = i + 1) if (r[8*i +: 8] == code) has = 1'b1; end
  endfunction
  wire [7:0] m = i_report[7:0];
  always @(posedge i_clk)
    if (i_report_valid)
      o_btn <= {has(i_report, 8'h4F), has(i_report, 8'h50), has(i_report, 8'h51), has(i_report, 8'h52),
                has(i_report, 8'h28) | has(i_report, 8'h58),
                has(i_report, 8'h2C) | has(i_report, 8'h2B) | m[5],
                has(i_report, 8'h1D) | m[2],
                has(i_report, 8'h1B) | m[0]};
endmodule
