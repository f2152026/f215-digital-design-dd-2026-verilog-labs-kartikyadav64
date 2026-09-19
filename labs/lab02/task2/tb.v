// tb.v
// Testbench for parameterized LUT

module tb;

  reg  [2:0] t_sel;
  wire [7:0] t_dout;

  // Parameter override: WIDTH = 8, DEPTH = 8
  lut #(.WIDTH(8), .DEPTH(8)) U1 (
    .sel  (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, U1);
    end
  end

  integer i;
  integer errors;

  initial begin
    errors = 0;

    // Test every valid address
    for (i = 0; i < 8; i = i + 1) begin
      t_sel = i;
      #1;

      if (t_dout !== i * i) begin
        $display("FAIL: sel=%0d, got=%0d, expected=%0d",
                 i, t_dout, i * i);
        errors = errors + 1;
      end
      else begin
        $display("PASS: sel=%0d, dout=%0d",
                 i, t_dout);
      end
    end

    if (errors == 0)
      $display("ALL 8 TESTS PASSED");
    else
      $display("%0d TESTS FAILED", errors);

    $finish;
  end

endmodule