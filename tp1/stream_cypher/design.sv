// Design
// Stream Cipher using One-Time Pad (OTP)

// Module for the OTP and message registers and XOR operation for encryption and decryption
module stream_cipher (
    input wire [7:0] otp,      // One-Time Pad (8 bits)
    input wire [7:0] message,  // Message to be encrypted/decrypted (8 bits)
    output wire [7:0] encrypted_message, // Encrypted message output (8 bits)
    output wire [7:0] decrypted_message  // Decrypted message output (8 bits)
);

    // Encryption: XOR OTP with the message
    assign encrypted_message = otp ^ message;

    // Decryption: XOR OTP with the encrypted message to get the original message
    assign decrypted_message = otp ^ encrypted_message;

endmodule
