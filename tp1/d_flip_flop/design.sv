// Design
// D Flip-Flop com Reset Assíncrono
module dff_asynch_reset (
    input wire clk_signal,         // Sinal de clock
    input wire reset_signal,       // Reset assíncrono, ativo alto
    input wire d_input,            // Entrada de dados
    output wire q_output,          // Saída de dados
    output wire qb_output          // Saída invertida de dados
);

    reg q_state;                   // Registro interno para manter o estado

    // Atribuir a saída invertida
    assign qb_output = ~q_state;

    always @(posedge clk_signal or posedge reset_signal) begin
        if (reset_signal) begin
            // Reset assíncrono para 0 quando o reset está alto
            q_state <= 1'b0;
        end else begin
            // Capturar d_input na borda de subida do clock
            q_state <= d_input;
        end
    end

    // Atribuir o valor do registro à saída
    assign q_output = q_state;

endmodule
