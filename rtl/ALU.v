`timescale 1ns / 1ps
module ALU(
    input [3:0] A,
    input [3:0] B,
    input [2:0] op,
    output reg [3:0] result,
    output reg carry,
    output reg zero,
    output reg overflow
);

    reg [4:0] temp;

    always @(*) begin

        // Default values
        result   = 4'b0000;
        carry    = 1'b0;
        overflow = 1'b0;
        temp     = 5'b00000;

        case (op)

            // ADD
            3'b000: begin
                temp   = {1'b0, A} + {1'b0, B};
                result = temp[3:0];
                carry  = temp[4];

                // Signed overflow
                overflow = (~(A[3] ^ B[3])) & (result[3] ^ A[3]);
            end

            // SUB
            3'b001: begin
                result = A - B;

                // Carry = 1 means no borrow
                carry = (A >= B);

                // Signed overflow
                overflow = (A[3] ^ B[3]) & (result[3] ^ A[3]);
            end

            // AND
            3'b010:
                result = A & B;

            // OR
            3'b011:
                result = A | B;

            // XOR
            3'b100:
                result = A ^ B;

            // NOT A
            3'b101:
                result = ~A;

            // Shift left
            3'b110: begin
                result = {A[2:0], 1'b0};
                carry  = A[3];
            end

            // Shift right
            3'b111: begin
                result = {1'b0, A[3:1]};
                carry  = A[0];
            end

            default: begin
                result   = 4'b0000;
                carry    = 1'b0;
                overflow = 1'b0;
            end

        endcase

        // Zero flag
        zero = (result == 4'b0000);

    end

endmodule