// Testbench para o módulo LFSR
module tb_LFSR;
    reg clk;                          // Sinal de clock para o teste
    reg rst_n;                        // Sinal de reset ativo em nível baixo
    wire [3:0] lfsr;                  // Saída do LFSR a ser monitorada

    // Instância do módulo LFSR
    LFSR uut (
        .clk(clk),
        .rst_n(rst_n),
        .lfsr(lfsr)
    );

    // Gera o clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock com período de 10 unidades de tempo
    end

    // Testa o LFSR
    initial begin
        // Configura o arquivo VCD para dumping
        $dumpfile("lfsr_dump.vcd");  // Nome do arquivo VCD
        $dumpvars(0, tb_LFSR);       // Salva todas as variáveis do testbench

        // Inicializa o sinal de reset
        rst_n = 0;                   // Ativa o reset (ativo em nível baixo)
        #10;                         // Aguarda para garantir que o LFSR esteja inicializado

        // Desativa o reset e aguarda para observar o comportamento
        rst_n = 1;
        #100;                        // Tempo para observar o comportamento do LFSR

        // Finaliza a simulação
        $finish;
    end

    // Monitoramento
    initial begin
        $monitor("Tempo = %0t | LFSR = %b", $time, lfsr);
    end
endmodule
