// Testbench
module d_flip_flop_tb;

    reg clk_tb;            // Clock signal for testbench
    reg rst_tb;            // Reset signal for testbench
    reg data_in_tb;        // Data input for testbench
    wire q_out_tb;         // Data output from DUT
    wire q_bar_tb;         // Inverted data output from DUT

    // Instantiate the design under test (DUT)
    d_flip_flop DUT (
        .clk(clk_tb), 
        .rst(rst_tb), 
        .data_in(data_in_tb), 
      	.q_out(q_out_tb),
      	.q_bar(q_bar_tb)
    );

    initial begin
        // Initialize the clock signal
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb; // Toggle clock every 5 time units
    end

    initial begin
        // Dump waveform
        $dumpfile("d_flip_flop.vcd");
        $dumpvars(1);

        // Test case 1: Apply reset
        $display("Apply reset.");
        rst_tb = 1;
        data_in_tb = 1'bx; // Don't care during reset
        #10 display_signals;

        // Test case 2: Release reset and set data_in to 1
        $display("Release reset and set data_in to 1.");
        rst_tb = 0;
        data_in_tb = 1;
        #10 display_signals;

        // Test case 3: Toggle clock and observe outputs
        $display("Toggle clock.");
        #10 display_signals;
        #10 display_signals;

        // Test case 4: Set data_in to 0 and observe outputs
        $display("Set data_in to 0 and observe.");
        data_in_tb = 0;
        #10 display_signals;

        // Test case 5: Apply reset again
        $display("Apply reset again.");
        rst_tb = 1;
        #10 display_signals;

        // Test case 6: Release reset and set data_in to 1 again
        $display("Release reset and set data_in to 1 again.");
        rst_tb = 0;
        data_in_tb = 1;
        #10 display_signals;

        // End simulation
        $finish;
    end

    // Task to display the signals
    task display_signals;
      #1 $display("Time=%0t | data_in=%b | q_out=%b | q_bar=%b", $time, data_in_tb, q_out_tb, q_bar_tb);
    endtask

endmodule
