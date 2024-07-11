module tb_d_flip_flop;

// Inputs
reg clk;
reg rst_n;
reg [31:0] d;

// Outputs
wire [31:0] q;

// Instantiate the Unit Under Test (UUT)
d_flip_flop uut (
    .clk(clk), 
    .rst_n(rst_n), 
    .d(d), 
    .q(q)
);

initial begin
    // Initialize Inputs
    clk = 0;
    rst_n = 1;
    d = 32'h00000000;

    // Dump file setup for waveform viewing
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_d_flip_flop);

    // Apply reset
    #10 rst_n = 0;
    #10 rst_n = 1;

    // Apply test vectors
    #10 d = 32'hAAAAAAAA;
    #20 d = 32'h55555555;
    #20 d = 32'hFFFFFFFF;

    // Apply reset again
    #10 rst_n = 0;
    #10 rst_n = 1;

    // Continue with test vectors
    #10 d = 32'h12345678;
    #20 d = 32'h87654321;
    #20 d = 32'h00000000;

    // Finish simulation
    #50 $finish;
end

// Clock generation
always #5 clk = ~clk;

endmodule
