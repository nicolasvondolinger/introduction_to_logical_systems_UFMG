// Módulo LFSR (Registrador de Deslocamento com Feedback Linear)
module LFSR (
    input  wire clk,                  // Sinal de clock
    input  wire reset,                // Sinal de reset
    output reg  [3:0] lfsr_out        // Saída do LFSR (4 bits)
);

    // O feedback é gerado pela operação XOR entre o bit menos significativo (lfsr_out[0]) e o bit mais significativo (lfsr_out[3])
    wire feedback = lfsr_out[0] ^ lfsr_out[3];

    // Sempre que ocorre uma borda de subida no clock ou um reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            lfsr_out <= 4'b0001;        // Valor inicial do LFSR quando ocorre um reset (semente do LFSR)
        else
            lfsr_out <= {lfsr_out[2:0], feedback}; // Desloca os bits para a direita e insere o feedback
    end
endmodule

// Módulo StreamCipher
module StreamCipher (
    input  wire clk,                  // Sinal de clock
    input  wire reset,                // Sinal de reset
    input  wire [7:0] message,        // Mensagem de 8 bits a ser criptografada/descriptografada
    output wire [7:0] encrypted_message, // Mensagem criptografada (8 bits)
    output wire [7:0] decrypted_message, // Mensagem descriptografada (8 bits)
    output wire [3:0] key_stream      // Chave OTP gerada (4 bits)
);

    wire [3:0] lfsr_out;              // Saída do LFSR (4 bits) para gerar o fluxo da chave
    reg [3:0] key_stream_reg;         // Registro para armazenar o fluxo da chave OTP (4 bits)

    // Instância do módulo LFSR para gerar o fluxo da chave
    LFSR lfsr (
        .clk(clk),
        .reset(reset),
        .lfsr_out(lfsr_out)
    );

    // Gerar e armazenar o fluxo da chave OTP (4 bits) com base na saída do LFSR
    always @(posedge clk or posedge reset) begin
        if (reset)
            key_stream_reg <= 4'b0;    // Inicializa o registro da chave OTP com 0 durante o reset
        else
            key_stream_reg <= lfsr_out; // Atualiza o registro da chave OTP com a saída do LFSR
    end

    // Atribuir a chave à saída
    assign key_stream = key_stream_reg;

    // Criptografia e descriptografia usando XOR em blocos de 4 bits

    // Criptografia: aplica a operação XOR entre os 4 bits menos significativos e a chave
    // e entre os 4 bits mais significativos e a chave
    assign encrypted_message[3:0] = message[3:0] ^ key_stream;  // Criptografa os 4 bits menos significativos
    assign encrypted_message[7:4] = message[7:4] ^ key_stream;  // Criptografa os 4 bits mais significativos

    // Descriptografia: aplica a operação XOR entre os 4 bits criptografados e a chave
    // Resulta na mensagem original, já que XOR é uma operação reversível
    assign decrypted_message[3:0] = encrypted_message[3:0] ^ key_stream; // Descriptografa os 4 bits menos significativos
    assign decrypted_message[7:4] = encrypted_message[7:4] ^ key_stream; // Descriptografa os 4 bits mais significativos
endmodule