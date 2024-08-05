// Testbench
module d_flip_flop_custom_tb;

    reg clk_tb;            // Clock signal for testbench
    reg rst_tb;            // Reset signal for testbench
    reg din_tb;            // Data input for testbench
    wire dout_tb;          // Data output from DUT
    wire dout_inv_tb;      // Inverted data output from DUT

    // Instantiate the design under test (DUT)
    d_flip_flop_custom DUT (
        .clk_signal(clk_tb), 
        .rst_signal(rst_tb), 
        .din(din_tb), 
        .dout(dout_tb),
        .dout_inv(dout_inv_tb)
    );

    initial begin
        // Initialize the clock signal
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb; // Toggle clock every 5 time units
    end

    initial begin
        // Dump waveform
        $dumpfile("d_flip_flop_custom.vcd");
        $dumpvars(1);

        // Test case 1: Apply reset
        $display("Apply reset.");
        rst_tb = 1;
        din_tb = 1'bx; // Don't care during reset
        #10 display_signals;

        // Test case 2: Release reset and set din to 1
        $display("Release reset and set din to 1.");
        rst_tb = 0;
        din_tb = 1;
        #10 display_signals;

        // Test case 3: Toggle clock and observe outputs
        $display("Toggle clock.");
        #10 display_signals;
        #10 display_signals;

        // Test case 4: Set din to 0 and observe outputs
        $display("Set din to 0 and observe.");
        din_tb = 0;
        #10 display_signals;

        // Test case 5: Apply reset again
        $display("Apply reset again.");
        rst_tb = 1;
        #10 display_signals;

        // Test case 6: Release reset and set din to 1 again
        $display("Release reset and set din to 1 again.");
        rst_tb = 0;
        din_tb = 1;
        #10 display_signals;

        // End simulation
        $finish;
    end

    // Task to display the signals
    task display_signals;
      #1 $display("Time=%0t | din=%b | dout=%b | dout_inv=%b", $time, din_tb, dout_tb, dout_inv_tb);
    endtask

endmodule
