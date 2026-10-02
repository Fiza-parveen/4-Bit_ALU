
`timescale 1ns/1ps

module tb_ALU;

    // DUT inputs
    reg [3:0] A;
    reg [3:0] B;
    reg [2:0] op;

    // DUT outputs
    wire [3:0] result;
    wire carry;
    wire zero;
    wire overflow;

    // Expected values
    reg [3:0] expected_result;
    reg expected_carry;
    reg expected_zero;
    reg expected_overflow;

    integer total_tests;
    integer passed_tests;
    integer failed_tests;

    // DUT instantiation
    ALU DUT (
        .A(A),
        .B(B),
        .op(op),
        .result(result),
        .carry(carry),
        .zero(zero),
        .overflow(overflow)
    );

    // Task to calculate expected outputs
    task calculate_expected;
        begin
            expected_result = 4'b0000;
            expected_carry = 1'b0;
            expected_overflow = 1'b0;

            case (op)

                // ADD
                3'b000: begin
                    expected_result = A + B;
                    expected_carry = ({1'b0,A} + {1'b0,B}) > 5'd15;
                    expected_overflow =
                        (~(A[3] ^ B[3])) &
                        (expected_result[3] ^ A[3]);
                end

                // SUB
                3'b001: begin
                    expected_result = A - B;
                    expected_carry = (A >= B);
                    expected_overflow =
                        (A[3] ^ B[3]) &
                        (expected_result[3] ^ A[3]);
                end

                // AND
                3'b010:
                    expected_result = A & B;

                // OR
                3'b011:
                    expected_result = A | B;

                // XOR
                3'b100:
                    expected_result = A ^ B;

                // NOT
                3'b101:
                    expected_result = ~A;

                // Shift left
                3'b110: begin
                    expected_result = {A[2:0],1'b0};
                    expected_carry = A[3];
                end

                // Shift right
                3'b111: begin
                    expected_result = {1'b0,A[3:1]};
                    expected_carry = A[0];
                end

            endcase

            expected_zero = (expected_result == 4'b0000);
        end
    endtask

    // Task to check DUT output
    task check_result;
        begin
            total_tests = total_tests + 1;

            if ((result === expected_result) &&
                (carry === expected_carry) &&
                (zero === expected_zero) &&
                (overflow === expected_overflow)) begin

                passed_tests = passed_tests + 1;

                $display("PASS | A=%b B=%b OP=%b | OUT=%b C=%b Z=%b V=%b",
                    A, B, op, result, carry, zero, overflow);
            end
            else begin
                failed_tests = failed_tests + 1;

                $display("FAIL | A=%b B=%b OP=%b", A, B, op);

                $display("Expected: OUT=%b C=%b Z=%b V=%b",
                    expected_result, expected_carry,
                    expected_zero, expected_overflow);

                $display("Actual  : OUT=%b C=%b Z=%b V=%b",
                    result, carry, zero, overflow);
            end
        end
    endtask

    // Task to apply inputs and test
    task run_test;
        input [3:0] test_A;
        input [3:0] test_B;
        input [2:0] test_op;

        begin
            A = test_A;
            B = test_B;
            op = test_op;

            #10;

            calculate_expected();
            check_result();
        end
    endtask

    // Main test sequence
    initial begin

        total_tests = 0;
        passed_tests = 0;
        failed_tests = 0;

        $display("==================================");
        $display("      4-BIT ALU TESTING");
        $display("==================================");

        // ADD
        run_test(4'd3, 4'd2, 3'b000);

        // ADD with carry
        run_test(4'd15, 4'd1, 3'b000);

        // ADD with signed overflow
        run_test(4'd7, 4'd1, 3'b000);

        // SUB
        run_test(4'd7, 4'd3, 3'b001);

        // SUB resulting in zero
        run_test(4'd5, 4'd5, 3'b001);

        // SUB with signed overflow
        run_test(4'd7, 4'b1111, 3'b001);

        // AND
        run_test(4'b1010, 4'b1100, 3'b010);

        // OR
        run_test(4'b1010, 4'b1100, 3'b011);

        // XOR
        run_test(4'b1010, 4'b1100, 3'b100);

        // NOT
        run_test(4'b1010, 4'b0000, 3'b101);

        // Shift left
        run_test(4'b1001, 4'b0000, 3'b110);

        // Shift right
        run_test(4'b1001, 4'b0000, 3'b111);

        // Zero result
        run_test(4'b0000, 4'b0000, 3'b010);

        // Final summary
        $display("");
        $display("==================================");
        $display("         TEST SUMMARY");
        $display("==================================");

        $display("Total Tests  : %0d", total_tests);
        $display("Passed Tests : %0d", passed_tests);
        $display("Failed Tests : %0d", failed_tests);

        if (failed_tests == 0)
            $display("ALL TESTS PASSED");
        else
            $display("SOME TESTS FAILED");

        $display("==================================");

        $finish;
    end

endmodule