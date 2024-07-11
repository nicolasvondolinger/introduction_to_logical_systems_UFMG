module d_flip_flop (
    input wire clk,
    input wire rst_n,   // Active low reset
    input wire [31:0] d,
    output reg [31:0] q
);

always @(posedge clk) begin
    if (!rst_n)
      	q <= 32'b0;  // Reset to 0 (Síncrono)
    else
        q <= d;
end

endmodule
