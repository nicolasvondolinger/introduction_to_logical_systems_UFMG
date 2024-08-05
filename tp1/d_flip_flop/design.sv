// Design: D Flip-Flop com reset assíncrono e saída invertida
module d_flip_flop_custom (
    input wire clk_signal,      // Sinal de clock
    input wire rst_signal,      // Reset assíncrono, ativo alto
    input wire din,             // Entrada de dados
    output wire dout,           // Saída de dados
    output wire dout_inv        // Saída de dados invertida
);

    reg state;                  // Registro interno para armazenar o estado

    // Atribuição da saída invertida
    assign dout_inv = ~state;

    always @(posedge clk_signal or posedge rst_signal) begin
        if (rst_signal) begin
            // Reset assíncrono para 0 quando reset está alto
            state <= 1'b0;
        end else begin
            // Captura a entrada de dados na borda de subida do clock
            state <= din;
        end
    end

    // Atribuição do valor do registro à saída
    assign dout = state;

endmodule
