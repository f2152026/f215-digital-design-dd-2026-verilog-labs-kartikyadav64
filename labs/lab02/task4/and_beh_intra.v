// and_beh_intra.v
// AND gate using behavioral modeling.
// Intra-assignment delay.

module and_beh_intra (
  input a,
  input b,
  output reg y
);

  always @(*) begin
    y = #1 a & b;
  end

endmodule