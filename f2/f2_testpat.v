// F2 testna slika u NES koordinatama (256 x 240, paleta vga.v), TASK-6069.
// Okvir 4 NES piksela (bijelo 0x30) + 8 okomitih traka po 32 piksela.
// Isti uzorak opisuje f2/check_frame.py (spec "f2"); tb provjerava da se poklapaju.
module f2_testpat (
  input  [8:0] x,   // NES cycle 0..340
  input  [8:0] y,   // NES scanline 0..261
  output reg [5:0] color
);
  always @* begin
    if (x < 4 || (x >= 252 && x < 256) || y < 4 || (y >= 236 && y < 240))
      color = 6'h30;                              // okvir: bijelo FCFCFC
    else case (x[7:5])
      3'd0: color = 6'h01;                        // plavo     0000FC
      3'd1: color = 6'h16;                        // crveno    F83800
      3'd2: color = 6'h14;                        // magenta   D800CC
      3'd3: color = 6'h19;                        // zeleno    00B800
      3'd4: color = 6'h3C;                        // cijan     00FCFC
      3'd5: color = 6'h28;                        // zuto      F8B800
      3'd6: color = 6'h00;                        // sivo      7C7C7C
      default: color = 6'h0F;                     // crno      000000
    endcase
  end
endmodule
