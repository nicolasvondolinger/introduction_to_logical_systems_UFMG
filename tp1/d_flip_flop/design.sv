// Design
// D Flip-Flop
module d_flip_flop (
    input wire clk,         // Clock signal
    input wire rst,         // Asynchronous reset, active high
    input wire data_in,     // Data input 
    output wire q_out,      // Data output
  	output wire q_bar       // Inverted data output
);

    reg q_reg;              // Internal register to hold the state

    // Assign the inverted output
    assign q_bar = ~q_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Asynchronous reset to 0 when reset is high
            q_reg <= 1'b0;
        end else begin
            // Capture data_in on the rising edge of the clock
            q_reg <= data_in;
        end
    end

    // Assign the register value to the output
    assign q_out = q_reg;

endmodule
