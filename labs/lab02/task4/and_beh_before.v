// and_beh_before.v
// AND gate using behavioral modeling.
// Delay occurs before the assignment.

module and_beh_before (
  input a,
  input b,
  output reg y
);

  always @(*) begin
    #1 y = a & b;
  end

endmodule