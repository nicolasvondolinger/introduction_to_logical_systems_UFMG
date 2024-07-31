// Testbench
module stream_cipher_tb;

    reg [7:0] otp_tb;          // Testbench OTP register
    reg [7:0] message_tb;      // Testbench message register
    wire [7:0] encrypted_message_tb; // Encrypted message output from DUT
    wire [7:0] decrypted_message_tb; // Decrypted message output from DUT

    // Instantiate the design under test (DUT)
    stream_cipher DUT (
        .otp(otp_tb),
        .message(message_tb),
        .encrypted_message(encrypted_message_tb),
        .decrypted_message(decrypted_message_tb)
    );

    initial begin
        // Dump waveform
        $dumpfile("stream_cipher.vcd");
        $dumpvars(1);

        // Test case 1: Encrypt and decrypt a message
        $display("Test case 1: Encrypt and decrypt a message.");
        otp_tb = 8'b10101010;         // Example OTP
        message_tb = 8'b11001100;     // Example message
        #10 display_signals;

        // Test case 2: Encrypt and decrypt another message
        $display("Test case 2: Encrypt and decrypt another message.");
        otp_tb = 8'b11110000;         // Another example OTP
        message_tb = 8'b00110011;     // Another example message
        #10 display_signals;

        // Test case 3: Different OTP same message
        $display("Test case 3: Different OTP same message.");
        otp_tb = 8'b00001111;         // Different OTP
        message_tb = 8'b11001100;     // Same message as test case 1
        #10 display_signals;

        // Test case 4: Same OTP different message
        $display("Test case 4: Same OTP different message.");
        otp_tb = 8'b10101010;         // Same OTP as test case 1
        message_tb = 8'b00110011;     // Different message
        #10 display_signals;

        // End simulation
        $finish;
    end

    // Task to display the signals
    task display_signals;
        #1 $display("Time=%0t | OTP=%b | Message=%b | Encrypted=%b | Decrypted=%b", $time, otp_tb, message_tb, encrypted_message_tb, decrypted_message_tb);
    endtask

endmodule
