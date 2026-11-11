// F2 vrata 1b (TASK-6069): cijeli f2_dvi_top s modelima GateMate celija (CC_PLL model,
// cells_sim CC_ODDR/CC_LVDS_OBUF). Serijski izlaz na pinovima uzorkuje se na oba brida
// clk_shift, poravna na kontrolne simbole, dekodira (DVI 1.0) i provjeri:
//   - tajming 640x480@60: H 640/16/96/48 = 800, V 480/10/2/33 = 525, DE, polaritet;
//   - dp = ~dn na sva 4 para; svi kanali isto poravnani; zeleni/crveni = kontrolni 00;
//   - takt kanala = clk_pixel (25 MHz, 5 bitova po periodu bita... 10 bitova po pikselu);
//   - kadar (nakon sto je upisivac ispunio framebuffer) -> PPM za check_frame.py --exact.
`timescale 1ps/1fs
module tb_f2_dvi;
  reg clk25 = 0; always #20000 clk25 = ~clk25;
  wire [7:0] led; wire [3:0] dp, dn;
  f2_dvi_top dut (.clk_25mhz(clk25), .led(led), .gpdi_dp(dp), .gpdi_dn(dn));
  wire clk_shift = dut.clk_shift;

  integer pass = 0, fail = 0;
  task check(input cond, input [8*72-1:0] msg);
    begin if (cond) pass = pass + 1; else begin fail = fail + 1; $display("FAIL: %0s", msg); end end
  endtask

  function [7:0] tmds_dec(input [9:0] w);
    integer j; reg [7:0] m;
    begin
      m = w[9] ? ~w[7:0] : w[7:0];
      tmds_dec[0] = m[0];
      for (j = 1; j < 8; j = j + 1) tmds_dec[j] = w[8] ? (m[j] ^ m[j-1]) : ~(m[j] ^ m[j-1]);
    end
  endfunction
  function is_ctl(input [9:0] w);
    is_ctl = (w == 10'b1101010100) || (w == 10'b0010101011) || (w == 10'b0101010100) || (w == 10'b1010101011);
  endfunction
  function [1:0] ctl_c(input [9:0] w);
    ctl_c = (w == 10'b1101010100) ? 2'b00 : (w == 10'b0010101011) ? 2'b01 : (w == 10'b0101010100) ? 2'b10 : 2'b11;
  endfunction

  // ---- deserijalizator: uzorak 2 ns nakon svakog brida clk_shift (sredina pola bita) ----
  reg [9:0] w0 = 0, w1 = 0, w2 = 0;
  integer bitn = 0, phase = -1, ctl_run = 0, ctl_phase = -1, diffpair_err = 0;
  reg     samp = 0;
  reg word_valid = 0; event word_ev;
  always @(clk_shift) begin
    #2000;
    w0 = {dp[0], w0[9:1]}; w1 = {dp[1], w1[9:1]}; w2 = {dp[2], w2[9:1]};
    if (dp !== ~dn) diffpair_err = diffpair_err + 1;
    bitn = bitn + 1;
    if (phase < 0) begin
      // poravnanje: 200 uzastopnih kontrolnih simbola na istoj fazi mod 10
      if (is_ctl(w0) && (ctl_phase == bitn % 10 || ctl_run == 0)) begin
        if (ctl_run == 0) ctl_phase = bitn % 10;
        if (ctl_phase == bitn % 10) ctl_run = ctl_run + 1;
        if (ctl_run >= 200) begin phase = ctl_phase; $display("poravnanje: faza %0d (bit %0d, t=%0t)", phase, bitn, $time); end
      end else if (bitn % 10 == ctl_phase) ctl_run = 0;
    end else if (bitn % 10 == phase) begin
      word_valid = 1; ->word_ev;
    end
  end

  // ---- dekodirani tok rijeci (1 rijec = 1 piksel) ----
  integer wc = 0;                               // brojac rijeci
  reg de = 0, hs = 1, vs = 1, de_p = 0, hs_p = 1, vs_p = 1;
  integer de_run = 0, hs_run = 0, vs_run = 0;
  integer t_de_rise = -1, t_de_rise_prev = -1, t_de_fall = -1;
  integer h_total_min = 99999, h_total_max = 0, de_len_min = 99999, de_len_max = 0;
  integer hs_len_min = 99999, hs_len_max = 0, hs_off_min = 99999, hs_off_max = 0;
  integer vs_len_min = 9999999, vs_len_max = 0, hs_after_de = 0;
  integer lines = 0, de_rows = 0, v_lines[0:7], v_rows[0:7], vfp = 0, vbp = 0, nfr = 0;
  integer hs_falls_since_vs_rise = 0, hs_falls_since_de_end = 0, vfp_min = 999, vfp_max = 0, vbp_min = 999, vbp_max = 0;
  integer v_tot_min = 99999, v_tot_max = 0, v_act_min = 99999, v_act_max = 0;
  integer ch_mismatch = 0, gr_ctl_bad = 0, hs_in_de = 0;
  integer t_vs_fall = -1, rows_since_vsf = 0, lines_since_vsf = 0, in_frame = 0;
  // snimanje kadra
  integer cap = 0, cap_row = 0, cap_col = 0, fd, cap_done = 0;
  reg [23:0] img [0:640*480-1];
  integer i;

  always @(word_ev) begin
    wc = wc + 1;
    de = !is_ctl(w0);
    if (is_ctl(w1) !== is_ctl(w0) || is_ctl(w2) !== is_ctl(w0)) ch_mismatch = ch_mismatch + 1;
    if (!de) begin
      if (ctl_c(w1) != 2'b00 || ctl_c(w2) != 2'b00) gr_ctl_bad = gr_ctl_bad + 1;
      hs = ctl_c(w0) & 1; vs = (ctl_c(w0) >> 1) & 1;
    end
    if (de && !hs) hs_in_de = hs_in_de + 1;
    // DE bridovi
    if (de && !de_p) begin
      t_de_rise_prev = t_de_rise; t_de_rise = wc;
      if (t_de_rise_prev > 0 && wc - t_de_rise_prev < 1000) begin
        if (wc - t_de_rise_prev < h_total_min) h_total_min = wc - t_de_rise_prev;
        if (wc - t_de_rise_prev > h_total_max) h_total_max = wc - t_de_rise_prev;
      end
      if (in_frame && rows_since_vsf == 0) begin
        // prvi aktivni red nakon vsync: back porch u linijama
        if (hs_falls_since_vs_rise < vbp_min) vbp_min = hs_falls_since_vs_rise;
        if (hs_falls_since_vs_rise > vbp_max) vbp_max = hs_falls_since_vs_rise;
      end
      rows_since_vsf = rows_since_vsf + 1;
      // kadar: pocni na prvom redu nakon sto je NES upisivac zavrsio 1. okvir
      if (cap == 0 && dut.nes_frames >= 1 && rows_since_vsf == 1 && in_frame) begin cap = 1; cap_row = 0; end
      cap_col = 0;
    end
    if (!de && de_p) begin
      t_de_fall = wc;
      if (wc - t_de_rise < de_len_min) de_len_min = wc - t_de_rise;
      if (wc - t_de_rise > de_len_max) de_len_max = wc - t_de_rise;
      hs_falls_since_de_end = 0;
      if (cap == 1) begin cap_row = cap_row + 1; if (cap_row == 480) begin cap = 2; cap_done = 1; end end
    end
    if (de && cap == 1 && cap_col < 640) begin
      img[cap_row*640 + cap_col] = {tmds_dec(w2), tmds_dec(w1), tmds_dec(w0)};
      cap_col = cap_col + 1;
    end
    // HSYNC (aktivan u 0)
    if (!hs && hs_p) begin
      hs_run = wc;
      if (t_de_rise > 0 && wc - t_de_rise < 1000) begin
        if (wc - t_de_rise < hs_off_min) hs_off_min = wc - t_de_rise;
        if (wc - t_de_rise > hs_off_max) hs_off_max = wc - t_de_rise;
      end
      lines_since_vsf = lines_since_vsf + 1;
      hs_falls_since_vs_rise = hs_falls_since_vs_rise + 1;
      hs_falls_since_de_end = hs_falls_since_de_end + 1;
    end
    if (hs && !hs_p) begin
      if (wc - hs_run < hs_len_min) hs_len_min = wc - hs_run;
      if (wc - hs_run > hs_len_max) hs_len_max = wc - hs_run;
    end
    // VSYNC (aktivan u 0)
    if (!vs && vs_p) begin
      if (in_frame) begin
        // linije = hsync padovi od proslog pada vsync (ukljucivo ovaj)
        if (lines_since_vsf < v_tot_min) v_tot_min = lines_since_vsf;
        if (lines_since_vsf > v_tot_max) v_tot_max = lines_since_vsf;
        if (rows_since_vsf < v_act_min) v_act_min = rows_since_vsf;
        if (rows_since_vsf > v_act_max) v_act_max = rows_since_vsf;
        // front porch: hsync padovi izmedju kraja zadnjeg DE reda i pada vsync (bez ovog)
        if (hs_falls_since_de_end - 1 < vfp_min) vfp_min = hs_falls_since_de_end - 1;
        if (hs_falls_since_de_end - 1 > vfp_max) vfp_max = hs_falls_since_de_end - 1;
        nfr = nfr + 1;
      end
      in_frame = 1; lines_since_vsf = 0; rows_since_vsf = 0; vs_run = wc;
    end
    if (vs && !vs_p) begin
      if (wc - vs_run < vs_len_min) vs_len_min = wc - vs_run;
      if (wc - vs_run > vs_len_max) vs_len_max = wc - vs_run;
      hs_falls_since_vs_rise = 0;
    end
    de_p = de; hs_p = hs; vs_p = vs;
  end

  // takt kanala: period dp[3] = 40 ns (clk_pixel), mjereno na pinu
  realtime t_ck = 0, ck_per_min = 1e12, ck_per_max = 0;
  integer ck_n = 0;
  always @(posedge dp[3]) begin
    if (t_ck > 0 && phase >= 0) begin
      if ($realtime - t_ck < ck_per_min) ck_per_min = $realtime - t_ck;
      if ($realtime - t_ck > ck_per_max) ck_per_max = $realtime - t_ck;
      ck_n = ck_n + 1;
    end
    t_ck = $realtime;
  end

  initial begin
    wait (cap_done == 1 && nfr >= 2);
    $display("H: ukupno %0d..%0d  DE %0d..%0d  hsync %0d..%0d  DE->hsync %0d..%0d",
             h_total_min, h_total_max, de_len_min, de_len_max, hs_len_min, hs_len_max, hs_off_min, hs_off_max);
    $display("V: linija %0d..%0d  aktivnih %0d..%0d  vsync %0d..%0d rijeci  fp %0d..%0d  bp %0d..%0d  okvira %0d",
             v_tot_min, v_tot_max, v_act_min, v_act_max, vs_len_min, vs_len_max, vfp_min, vfp_max, vbp_min, vbp_max, nfr);
    $display("takt kanala: period %0.1f..%0.1f ps (%0d)  dp!=~dn %0d  kanali nesuglasni %0d  G/R kontrola!=00 %0d  hsync u DE %0d",
             ck_per_min, ck_per_max, ck_n, diffpair_err, ch_mismatch, gr_ctl_bad, hs_in_de);
    check(h_total_min == 800 && h_total_max == 800, "H ukupno 800");
    check(de_len_min == 640 && de_len_max == 640, "H aktivno (DE) 640");
    check(hs_len_min == 96 && hs_len_max == 96, "hsync 96");
    check(hs_off_min == 656 && hs_off_max == 656, "DE->hsync 656 (fp 16)");
    check(v_tot_min == 525 && v_tot_max == 525, "V ukupno 525");
    check(v_act_min == 480 && v_act_max == 480, "V aktivno 480");
    check(vs_len_min == 1600 && vs_len_max == 1600, "vsync 2 linije (1600)");
    check(vfp_min == 10 && vfp_max == 10, "V front porch 10");
    check(vbp_min == 33 && vbp_max == 33, "V back porch 33");
    check(ck_per_min > 39990 && ck_per_max < 40010 && ck_n > 1000, "takt kanala 25 MHz");
    check(diffpair_err == 0, "dp = ~dn");
    check(ch_mismatch == 0, "svi kanali poravnani");
    check(gr_ctl_bad == 0, "G/R kontrola 00");
    check(hs_in_de == 0, "nema hsync u DE");
    check(led[0] == 1'b0 && led[1] == 1'b0, "LED lock aktivne");
    fd = $fopen({`OUTDIR, "/tb_f2_frame.ppm"}, "w");
    $fwrite(fd, "P3\n640 480\n255\n");
    for (i = 0; i < 640*480; i = i + 1) $fwrite(fd, "%0d %0d %0d\n", img[i][23:16], img[i][15:8], img[i][7:0]);
    $fclose(fd);
    $display("kadar: %s/tb_f2_frame.ppm  (t=%0t)", `OUTDIR, $time);
    $display("tb_f2_dvi: PASS %0d FAIL %0d", pass, fail);
    $finish;
  end
  initial begin #80_000_000_000; $display("TIMEOUT"); $display("tb_f2_dvi: PASS %0d FAIL %0d", pass, fail + 1); $finish; end
endmodule
