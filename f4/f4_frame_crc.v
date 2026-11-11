// F4 (TASK-6071): uzorkovac kadra PPU-a -- isti za simulaciju i plocicu.
// vga.v (framebuffer) pise boju svaki takt na {scanline, cycle}; u memoriji ostane zadnja vrijednost
// prije promjene polozaja. Ovaj modul uzme upravo tu vrijednost: kad se {cycle, scanline} promijeni,
// prethodni polozaj (ako je vidljiv, 256 x 240) daje piksel. CRC-32 (zlib) po pikselu (bajt = boja 0..63)
// redom kako PPU crta; nakon piksela (255, 239) frame_done, frame_crc i broj piksela kadra.
module f4_frame_crc (
  input             clk,
  input       [5:0] color,
  input       [8:0] cycle,
  input       [8:0] scanline,
  output reg        pix_valid = 1'b0,
  output reg  [7:0] pix_x = 0,
  output reg  [7:0] pix_y = 0,
  output reg  [5:0] pix_c = 0,
  output reg        frame_done = 1'b0,
  output reg [31:0] frame_crc = 0,
  output reg [16:0] frame_pix = 0
);
  reg [5:0] c_d = 0; reg [8:0] x_d = 9'h1FF, y_d = 9'h1FF;
  reg [31:0] crc = 32'hFFFFFFFF;
  reg [16:0] npix = 0;
  function [31:0] crc8(input [31:0] c, input [7:0] d);
    integer i; reg [31:0] r;
    begin
      r = c ^ {24'd0, d};
      for (i = 0; i < 8; i = i + 1) r = r[0] ? (r >> 1) ^ 32'hEDB88320 : (r >> 1);
      crc8 = r;
    end
  endfunction
  wire moved = (cycle != x_d) || (scanline != y_d);
  wire vis   = (x_d < 9'd256) && (y_d < 9'd240);
  always @(posedge clk) begin
    c_d <= color; x_d <= cycle; y_d <= scanline;
    pix_valid <= 1'b0; frame_done <= 1'b0;
    if (moved && vis) begin
      pix_valid <= 1'b1; pix_x <= x_d[7:0]; pix_y <= y_d[7:0]; pix_c <= c_d;
      if (x_d == 9'd255 && y_d == 9'd239) begin
        frame_done <= 1'b1; frame_crc <= ~crc8(crc, {2'b00, c_d}); frame_pix <= npix + 1'b1;
        crc <= 32'hFFFFFFFF; npix <= 0;
      end else begin
        crc <= crc8(crc, {2'b00, c_d}); npix <= npix + 1'b1;
      end
    end
  end
endmodule
