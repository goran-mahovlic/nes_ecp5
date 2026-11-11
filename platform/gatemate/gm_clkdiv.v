// Takt /N na lokalnom rutanju (F1, TASK-6068), kao gateware/usb_hid.py u
// litex-eth-ulx5m-gs-1g-sbc: brojac mod N u izvornoj domeni, registrirani izlaz,
// clkbuf_inhibit -> bez CC_BUFG / globalne mreze.
// 125 MHz / 21 = 5,952 MHz (USB low speed, -0,79 %, LS dopusta +-1,5 %).
// Usporedbe su registrirane jedan takt unaprijed (last, hi): na 125 MHz izravni
// put cnt -> (cnt==N-1) -> mux -> cnt pada na 117,7 MHz (P&R F1, 5,5 ns rutanja).
// Izlaz je isti kao usb_hid.py: visoko N/2 od N taktova (10/21).
module gm_clkdiv #(
  parameter integer N = 21
) (
  input  clk,
  output clk_o
);
  localparam integer W = $clog2(N);
  reg [W-1:0] cnt  = {W{1'b0}};
  reg         last = 1'b0;     // cnt == N-1 u ovom taktu
  reg         hi   = 1'b1;     // cnt <  N/2 u ovom taktu
  (* clkbuf_inhibit *) reg q = 1'b0;
  always @(posedge clk) begin
    cnt  <= last ? {W{1'b0}} : cnt + 1'b1;
    last <= (cnt == N-2);
    hi   <= last | (cnt < N/2 - 1);
    q    <= hi;
  end
  assign clk_o = q;
endmodule
