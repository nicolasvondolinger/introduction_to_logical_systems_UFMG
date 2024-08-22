module LFSR (
    input clk,        // Clock
    input rst_n,      // Reset (ativo em nível baixo)
    output reg [3:0] lfsr // LFSR de 4 bits
);

    // Inicializa o LFSR
    initial begin
        lfsr = 4'b0001; // Valor inicial
    end

    // Desloca o LFSR a cada borda positiva do clock
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            lfsr <= 4'b0001; // Reseta o LFSR
        else
          	lfsr <= {lfsr[2:0], lfsr[3] ^ lfsr[0]}; // Desloca e aplica feedback
    end
endmodule
