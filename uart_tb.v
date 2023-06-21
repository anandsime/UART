module uart_tb;
  
  reg clk;
  reg reset;
  reg rx;
  wire tx;
  
  uart uut (
    .clk(clk),
    .reset(reset),
    .rx(rx),
    .tx(tx)
  );
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
    reset = 1;
    rx = 1;
    #10 reset = 0;
    #100 $finish;
  end
  
  initial begin
    $dumpfile("uart_tb.vcd");
    $dumpvars;
    
    #20 rx = 0;  // Simulate receiving a start bit
    #30 rx = 1;  // Simulate receiving 8 data bits
    #40 rx = 1;  // Simulate receiving a stop bit
    
    #50 $display("Simulation complete.");
    #51 if (tx === 1'b0)
      $display("Simulation failed: Incorrect transmission.");
    else
      $display("Simulation passed: Transmission successful.");
    #52 $finish;
  end

endmodule

