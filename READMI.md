# 4-Bit Arithmetic Logic Unit (ALU) --- Verilog HDL

A **4-bit Arithmetic Logic Unit (ALU)** designed in Verilog HDL using combinational logic. The project focuses on RTL design, arithmetic and logical operations, status-flag generation, and functional verification through a Verilog testbench.

## Project Overview

This project implements an ALU that accepts two 4-bit operands (`A` and `B`) and a 3-bit operation selector (`op`).

The ALU:

* Performs eight arithmetic and logical operations.
* Selects an operation using the 3-bit opcode.
* Produces a 4-bit result.
* Generates Carry, Zero, and Overflow status flags.
* Uses combinational logic, so no clock or state machine is required.
* Targets the PYNQ-Z2 FPGA development board for hardware implementation.

## Main Features

* 4-bit operands
* 3-bit operation selector
* Eight ALU operations
* 4-bit result output
* Carry flag generation
* Zero flag detection
* Signed overflow detection for addition and subtraction
* Combinational RTL design
* Verilog testbench with expected-value checking
* PASS/FAIL test summary
* FPGA implementation workflow using Vivado

## ALU Operations

| Opcode (`op[2:0]`) | Operation   | Function         |
| ------------------ | ----------- | ---------------- |
| `000`              | ADD         | `A + B`          |
| `001`              | SUB         | `A - B`          |
| `010`              | AND         | `A & B`          |
| `011`              | OR          | `A \| B`         |
| `100`              | XOR         | `A ^ B`          |
| `101`              | NOT A       | `~A`             |
| `110`              | Shift Left  | `{A[2:0], 1'b0}` |
| `111`              | Shift Right | `{1'b0, A[3:1]}` |

## Architecture

```text
       A[3:0] ─────┐
                   │
       B[3:0] ─────┼──> Opcode Selection ──> Selected Operation
                   │                            │
       op[2:0] ────┘                            v
                                      +-------------------+
                                      | Arithmetic /      |
                                      | Logic Operations  |
                                      +-------------------+
                                                |
                                                v
                                      +-------------------+
                                      | Result and Flag   |
                                      | Generation        |
                                      +-------------------+
                                         |   |   |    |
                                         v   v   v    v
                                      result C   Z    V
                                      [3:0] carry zero overflow
```

## Inputs

| Signal | Width  | Description                             |
| ------ | ------ | --------------------------------------- |
| `A`    | 4 bits | First operand                           |
| `B`    | 4 bits | Second operand                          |
| `op`   | 3 bits | Selects one of the eight ALU operations |

## Outputs

| Signal     | Width  | Description                                                               |
| ---------- | ------ | ------------------------------------------------------------------------- |
| `result`   | 4 bits | Result of the selected operation                                          |
| `carry`    | 1 bit  | Carry-out, no-borrow indicator, or shifted-out bit depending on operation |
| `zero`     | 1 bit  | Asserted when `result` equals `0000`                                      |
| `overflow` | 1 bit  | Signed overflow indicator for addition and subtraction                    |

## Status Flag Behavior

### Carry Flag

* **Addition:** Carry is the fifth bit of the extended sum.
* **Subtraction:** Carry = 1 indicates no unsigned borrow (`A >= B`).
* **Shift Left:** Carry receives the original MSB, `A[3]`.
* **Shift Right:** Carry receives the original LSB, `A[0]`.
* **Logical Operations:** Carry remains 0.

### Zero Flag

The Zero flag becomes 1 when the 4-bit result is `0000`; otherwise, it remains 0.

### Overflow Flag

The Overflow flag detects signed two's-complement overflow during addition and subtraction. It remains 0 for logical and shift operations.

## Project Files

```text
4-bit-alu/
│
├── ALU.v
├── tb_ALU.v
├── alu.xdc
└── README.md
```

### `ALU.v`

Contains the synthesizable combinational ALU design, including:

* Opcode-based operation selection
* Arithmetic operations
* Bitwise logical operations
* Shift operations
* Carry, Zero, and Overflow flag generation

### `tb_ALU.v`

Contains the Verilog testbench, including:

* DUT instantiation
* Test-vector application
* Expected-output calculation
* Actual-versus-expected comparison
* PASS/FAIL messages
* Final test summary

### `alu.xdc`

Contains FPGA pin-location and I/O-standard constraints for the PYNQ-Z2 implementation.

All package-pin assignments must be verified against the official PYNQ-Z2 master XDC before hardware use.

## Verification / Test Cases

The testbench checks representative cases for all eight operations.

### Test 1 --- Addition

```text
A = 0011
B = 0010
op = 000

Expected result = 0101
carry = 0
zero = 0
overflow = 0
```

### Test 2 --- Addition with Carry

```text
A = 1111
B = 0001
op = 000

Expected result = 0000
carry = 1
zero = 1
overflow = 0
```

### Test 3 --- Signed Overflow

```text
A = 0111
B = 0001
op = 000

Expected result = 1000
overflow = 1
```

### Test 4 --- Subtraction

```text
A = 0111
B = 0011
op = 001

Expected result = 0100
carry = 1
overflow = 0
```

### Test 5 --- Logical Operations and Shifts

The testbench also checks:

* AND
* OR
* XOR
* NOT A
* Shift Left
* Shift Right
* Zero-result detection

## Simulation Result

The testbench is designed to display each test case as PASS or FAIL, followed by the total number of tests, passed tests, and failed tests.

A successful simulation indicates that the DUT matches the expected outputs for the included test vectors.

## Running the Simulation in Vivado

1. Create or open a Vivado project.
2. Add `ALU.v` under **Design Sources**.
3. Add `tb_ALU.v` under **Simulation Sources**.
4. Set `tb_ALU` as the simulation top.
5. Select **Run Simulation → Run Behavioral Simulation**.
6. Review the simulator console and final test summary.

For FPGA synthesis, set `ALU` as the design top instead of `tb_ALU`.

## FPGA Implementation

The target board for this project is **PYNQ-Z2 (Zynq-7000)**.

Implementation steps:

1. Add the correct board-specific XDC file.
2. Assign valid FPGA package pins to all top-level ports.
3. Set the appropriate I/O standard (`LVCMOS33`).
4. Run Synthesis.
5. Run Implementation.
6. Resolve all pin-assignment and I/O-standard DRC errors.
7. Generate the bitstream.
8. Program the FPGA and verify the hardware functionality.

**Hardware Note:** PMOD inputs require appropriate 3.3 V logic-level signals. Never apply 5 V directly to FPGA I/O pins.

## Tools & Technologies

* **Verilog HDL**
* **RTL Design**
* **Combinational Logic**
* **Arithmetic and Logic Operations**
* **Behavioral Simulation**
* **Vivado / XSim**
* **PYNQ-Z2 FPGA**

## What I Practiced

Through this project, I worked on:

* Designing combinational RTL using Verilog
* Implementing arithmetic and bitwise operations
* Understanding 4-bit arithmetic and result truncation
* Generating Carry and signed Overflow flags
* Writing a self-checking testbench
* Comparing expected and actual outputs
* Debugging simulation issues
* Understanding FPGA constraints and implementation workflow

## Future Improvements

Possible extensions include:

* Exhaustive testing of all operand combinations
* Additional signed and unsigned test cases
* Parameterized ALU width
* Additional status flags, such as Negative
* Seven-segment display interface
* PMOD switch interface and physical board demonstration
* More extensive verification using assertions

## Author

**Fiza Parveen**
Electronics & Communication Engineering

---

### Project Summary

This project is a 4-bit combinational ALU developed to strengthen practical understanding of **Verilog HDL, RTL design, arithmetic and logic operations, status flags, testbench-based verification, and FPGA implementation**.
