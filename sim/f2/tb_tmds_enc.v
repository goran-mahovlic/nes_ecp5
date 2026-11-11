// F2 vrata 1a (TASK-6069): gm_tmds_enc (protocni) prema referentnom vektoru =
// NES-ov tmds_encoder.v (Mike Field), + DVI dekodiranje natrag + DC ravnoteza.
`timescale 1ns/1ps
module tb_tmds_enc;
  reg clk = 0; always #20 clk = ~clk;
  reg [7:0] d = 0; reg [1:0] c = 0; reg de = 0;
  wire [9:0] q_ref, q_dut;
  tmds_encoder u_ref (.clk(clk), .data(d), .c(c), .blank(~de), .encoded(q_ref));
  gm_tmds_enc  u_dut (.clk(clk), .d(d), .c(c), .de(de), .q(q_dut));

  integer pass = 0, fail = 0, n, mism = 0, decerr = 0, rd = 0, rdmax = 0, k;
  reg [9:0] ref_d1, ref_d2;  // q_ref zakasnjen 2 takta (latencija 1 vs 3)
  reg [7:0] d_h1, d_h2, d_h3;  reg de_h1, de_h2, de_h3;
  reg [7:0] qm, dec;

  function [7:0] tmds_dec(input [9:0] w);
    integer j; reg [7:0] m;
    begin
      m = w[9] ? ~w[7:0] : w[7:0];
      tmds_dec[0] = m[0];
      for (j = 1; j < 8; j = j + 1) tmds_dec[j] = w[8] ? (m[j] ^ m[j-1]) : ~(m[j] ^ m[j-1]);
    end
  endfunction

  task check(input cond, input [8*64-1:0] msg);
    begin if (cond) pass = pass + 1; else begin fail = fail + 1; $display("FAIL: %0s", msg); end end
  endtask

  // poznati vektori: crno (0x00) u podatkovnom razdoblju od cnt=0 -> 0x100, 0x3FF, 0x100, ...
  reg [9:0] black_seq [0:3];
  initial begin
    black_seq[0] = 10'h100; black_seq[1] = 10'h3FF; black_seq[2] = 10'h100; black_seq[3] = 10'h3FF;
    // kontrolni simboli
    de = 0;
    for (k = 0; k < 4; k = k + 1) begin
      c = k; repeat (3) @(posedge clk); #1;
      check(q_dut == (k==0 ? 10'b1101010100 : k==1 ? 10'b0010101011 : k==2 ? 10'b0101010100 : 10'b1010101011),
            "kontrolni simbol");
    end
    // crno od cnt=0
    c = 0; d = 8'h00; de = 1;
    @(posedge clk); @(posedge clk); @(posedge clk); #1;    // latencija 3
    for (k = 0; k < 4; k = k + 1) begin
      check(q_dut == black_seq[k], "crno 0x00 slijed 100/3FF"); @(posedge clk); #1;
    end
    // nasumicno: 200000 rijeci, de u naletima
    de = 0; repeat (4) @(posedge clk);
    for (n = 0; n < 200000; n = n + 1) begin
      @(negedge clk);
      d  = $random;
      c  = $random;
      if (($random & 63) == 0) de = ~de;
      @(posedge clk); #1;
      // usporedba s referencom (pomak 2 takta)
      if (n > 4 && q_dut !== ref_d2) begin
        mism = mism + 1;
        if (mism < 5) $display("razlika n=%0d dut=%b ref=%b", n, q_dut, ref_d2);
      end
      // dekodiranje: podatak ulaza od prije 3 takta
      if (n > 4 && de_h3) begin
        if (tmds_dec(q_dut) !== d_h3) decerr = decerr + 1;
        rd = rd + $countones(q_dut) - 5;   // N1 - 5 po rijeci (10 bita)
      end else rd = 0;
      if (rd > rdmax) rdmax = rd; if (-rd > rdmax) rdmax = -rd;
    end
    check(mism == 0, "gm_tmds_enc == tmds_encoder (200000 rijeci)");
    check(decerr == 0, "dekodiranje vraca ulazni bajt");
    check(rdmax <= 10, "tekuca disparitet ogranicena (|sum(N1-5)| <= 10)");
    $display("tmds: razlika=%0d dekod_greske=%0d max|disparitet|=%0d", mism, decerr, rdmax);
    $display("tb_tmds_enc: PASS %0d FAIL %0d", pass, fail);
    $finish;
  end
  always @(posedge clk) begin
    ref_d1 <= q_ref; ref_d2 <= ref_d1;
    d_h1 <= d; d_h2 <= d_h1; d_h3 <= d_h2; de_h1 <= de; de_h2 <= de_h1; de_h3 <= de_h2;
  end
endmodule
