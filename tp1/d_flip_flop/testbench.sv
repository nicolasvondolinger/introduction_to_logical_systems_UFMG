// Testbench
module dff_asynch_reset_tb;

    reg clk_tb;            // Sinal de clock para o testbench
    reg reset_tb;          // Sinal de reset para o testbench
    reg d_tb;              // Entrada de dados para o testbench
    wire q_tb;             // Saída de dados do DUT
    wire qb_tb;            // Saída invertida de dados do DUT

    // Instanciar o design sob teste (DUT)
    dff_asynch_reset DUT (
        .clk_signal(clk_tb), 
        .reset_signal(reset_tb), 
        .d_input(d_tb), 
        .q_output(q_tb),
        .qb_output(qb_tb)
    );

    initial begin
        // Inicializar o sinal de clock
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb; // Alternar clock a cada 5 unidades de tempo
    end

    initial begin
        // Gerar waveform
        $dumpfile("dff_asynch_reset.vcd");
        $dumpvars(1);

        // Caso de teste 1: Aplicar reset
        $display("Aplicar reset.");
        reset_tb = 1;
        d_tb = 1'bx; // Indiferente durante o reset
        #10 display_signals;

        // Caso de teste 2: Liberar reset e definir d para 1
        $display("Liberar reset e definir d para 1.");
        reset_tb = 0;
        d_tb = 1;
        #10 display_signals;

        // Caso de teste 3: Alternar clock e observar saídas
        $display("Alternar clock.");
        #10 display_signals;
        #10 display_signals;

        // Caso de teste 4: Definir d para 0 e observar saídas
        $display("Definir d para 0 e observar.");
        d_tb = 0;
        #10 display_signals;

        // Caso de teste 5: Aplicar reset novamente
        $display("Aplicar reset novamente.");
        reset_tb = 1;
        #10 display_signals;

        // Caso de teste 6: Liberar reset e definir d para 1 novamente
        $display("Liberar reset e definir d para 1 novamente.");
        reset_tb = 0;
        d_tb = 1;
        #10 display_signals;

        // Encerrar simulação
        $finish;
    end

    // Tarefa para exibir os sinais
    task display_signals;
      #1 $display("Tempo=%0t | d=%b | q=%b | qb=%b", $time, d_tb, q_tb, qb_tb);
    endtask

endmodule
