// tb.v
// Self-checking testbench for the 4-bit ALU.

module tb;

  reg [3:0] t_a;
  reg [3:0] t_b;
  reg       t_op;

  wire [3:0] t_result;

  reg [3:0] expected;

  integer a_i;
  integer b_i;
  integer errors;
  integer total;

  alu DUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  initial begin
    errors = 0;
    total = 0;

    // Test every possible pair of 4-bit operands
    // for both addition and subtraction.
    for (a_i = 0; a_i < 16; a_i = a_i + 1) begin

      for (b_i = 0; b_i < 16; b_i = b_i + 1) begin

        t_a = a_i;
        t_b = b_i;

        // Addition
        t_op = 1'b0;
        #1;

        expected = a_i + b_i;
        total = total + 1;

        if (t_result !== expected) begin
          $display("FAIL: ADD A=%0d B=%0d got=%0d expected=%0d",
                   a_i, b_i, t_result, expected);
          errors = errors + 1;
        end

        // Subtraction
        // op changes while A and B stay fixed.
        // This specifically tests the sensitivity list.
        t_op = 1'b1;
        #1;

        expected = a_i - b_i;
        total = total + 1;

        if (t_result !== expected) begin
          $display("FAIL: SUB A=%0d B=%0d got=%0d expected=%0d",
                   a_i, b_i, t_result, expected);
          errors = errors + 1;
        end

      end
    end

    $display("SUMMARY: %0d/%0d tests passed, %0d failed",
             total - errors, total, errors);

    $finish;
  end

endmodule