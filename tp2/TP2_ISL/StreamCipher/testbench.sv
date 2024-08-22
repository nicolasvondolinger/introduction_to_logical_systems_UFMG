// Testbench para o módulo StreamCipher
module tb_StreamCipher;

    // Declaração dos sinais de teste
    reg clk;                          // Sinal de clock para o teste
    reg reset;                        // Sinal de reset para o teste
    reg [7:0] message;                // Mensagem de 8 bits a ser criptografada/descriptografada
    wire [7:0] encrypted_message;    // Mensagem criptografada (8 bits)
    wire [7:0] decrypted_message;    // Mensagem descriptografada (8 bits)
    wire [3:0] key_stream;            // Chave OTP gerada (4 bits)

    // Instância do módulo StreamCipher
    StreamCipher uut (
        .clk(clk),
        .reset(reset),
        .message(message),
        .encrypted_message(encrypted_message),
        .decrypted_message(decrypted_message),
        .key_stream(key_stream)
    );

    // Gerador de clock: alterna o sinal de clock a cada 10 unidades de tempo
    always begin
        #10 clk = ~clk; // Frequência de clock de 10 unidades de tempo (período de 20 unidades de tempo)
    end

    // Processo de teste
    initial begin
        // Inicialização dos sinais
        clk = 0;                        // Inicializa o sinal de clock
        reset = 1;                      // Ativa o reset
        message = 8'b00000000;          // Inicializa a mensagem com 0

        // Aplicar reset e aguardar para estabilização
        #10;
        reset = 0;                      // Desativa o reset

        // Teste 1: Criptografar e descriptografar uma mensagem
        message = 8'b10101010;          // Define uma mensagem de teste
        #10;                           // Aguarda uma borda de clock para atualização

        // Exibir resultados após criptografia e descriptografia
        $display("Teste 1:");
        $display("Mensagem Original: %b", message);
        $display("Chave: %b", key_stream);
        $display("Mensagem Criptografada: %b", encrypted_message);

        #10;                           // Aguarda uma borda de clock

        // Verificar a descriptografia
        $display("Mensagem Descriptografada: %b", decrypted_message);

        // Teste 2: Verificar o comportamento com uma mensagem diferente
        message = 8'b11110000;          // Define uma nova mensagem de teste
        #10;                           // Aguarda uma borda de clock

        // Exibir resultados
        $display("Teste 2:");
        $display("Mensagem Original: %b", message);
        $display("Chave: %b", key_stream);
        $display("Mensagem Criptografada: %b", encrypted_message);

        #10;                           // Aguarda uma borda de clock

        // Verificar a descriptografia
        $display("Mensagem Descriptografada: %b", decrypted_message);

        // Teste 3: Mensagem com todos os bits iguais
        message = 8'b00000000;          // Define uma mensagem de todos os bits iguais
        #10;                           // Aguarda uma borda de clock

        // Exibir resultados
        $display("Teste 3:");
        $display("Mensagem Original: %b", message);
        $display("Chave: %b", key_stream);
        $display("Mensagem Criptografada: %b", encrypted_message);

        #10;                           // Aguarda uma borda de clock

        // Verificar a descriptografia
        $display("Mensagem Descriptografada: %b", decrypted_message);

        // Teste 4: Mensagem com todos os bits alternados
        message = 8'b01010101;          // Define uma mensagem com bits alternados
        #10;                           // Aguarda uma borda de clock

        // Exibir resultados
        $display("Teste 4:");
        $display("Mensagem Original: %b", message);
        $display("Chave: %b", key_stream);
        $display("Mensagem Criptografada: %b", encrypted_message);

        #10;                           // Aguarda uma borda de clock

        // Verificar a descriptografia
        $display("Mensagem Descriptografada: %b", decrypted_message);

        // Teste 5: Sequência de mensagens para verificar a continuidade
        message = 8'b00001111;          // Define uma nova mensagem de teste
        #10;                           // Aguarda uma borda de clock

        $display("Teste 5 - Mensagem 1:");
        $display("Mensagem Original: %b", message);
        $display("Chave: %b", key_stream);
        $display("Mensagem Criptografada: %b", encrypted_message);

        #10;                           // Aguarda uma borda de clock

        // Verificar a descriptografia
        $display("Mensagem Descriptografada: %b", decrypted_message);

        // Testa outra mensagem na sequência
        message = 8'b11110000;          // Define uma nova mensagem de teste
        #10;                           // Aguarda uma borda de clock

        $display("Teste 5 - Mensagem 2:");
        $display("Mensagem Original: %b", message);
        $display("Chave: %b", key_stream);
        $display("Mensagem Criptografada: %b", encrypted_message);

        #10;                           // Aguarda uma borda de clock

        // Verificar a descriptografia
        $display("Mensagem Descriptografada: %b", decrypted_message);

        // Finaliza a simulação
        $finish;
    end
endmodule