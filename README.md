# 8-Bit Custom CPU

A fully custom 8-bit CPU designed and implemented from scratch using VHDL and Quartus, with a custom instruction set architecture and a Python assembler.

The project was built to explore computer architecture at the hardware level, from instruction encoding and datapath design to instruction decoding, memory access, and execution.

## Features

* Custom 8-bit ISA
* 8-bit instruction width
* 4 general-purpose 8-bit registers (R1 - R4)
* 16-byte RAM
* Custom ALU
* Load and Store memory instructions
* Arithmetic and logical instructions
* ROM and RAM programming modes
* Python assembler for the custom ISA with GUI frontend

## Architecture

The CPU uses 8-bit instructions divided into two major categories:

### Memory Instructions

Memory instructions have an MSB of `0`. Their syntax is : 0 I RR AAAA
Where:

 - I : determines whether the instruction is a LOAD (1) or a STORE (0)
 - RR : 2 bit address of the relevant General-Purpose (R) register (00 - 11)
 - AAAA : 4 bit RAM address to be loaded from/ stored to

Note :

* `LOAD`: RAM → register
* `STORE`: register → RAM

### ALU Instructions

ALU instructions have an MSB of `1`. Their syntax is : 1 OOO I1I1 I2I2
Where :

 - OOO : 3 bit op-code for the alu (more information in /Documents)
 - I1I1 : 2 bit address of the R register to be used as input 1 of the ALU
 - I2I2 : 2 bit address of the R register to be used as input 2 of the ALU

** Note :**
  For two-register operations, the result is stored in the second register.

  For example:

    ADD R1 R2

  performs:

    R2 <- R1 + R2

The complete ISA specification can be found in /Documents.

## Register encoding:

| Register | Address |
| -------- | ------- |
| R1       | `00`    |
| R2       | `01`    |
| R3       | `10`    |
| R4       | `11`    |

## Assembler

The project includes a Python assembler that translates programs written using the custom assembly syntax into the 8-bit machine instructions understood by the CPU.

Example:

LOAD R1 1010  
LOAD R2 0110  
ADD R1 R2  
STORE R2 1111  

The assembler produces:

01101010  
01010110  
11100001  
00111111  

A Tkinter-based GUI is provided as a frontend for selecting assembly files, assembling them, viewing the resulting machine code, and saving the output as a .bin file.

## Programming the CPU

The CPU includes dedicated programming modes for initializing ROM and RAM.

When programming the ROM, the Program Counter is reset until programming is complete so that execution begins from the newly programmed instruction sequence.

RAM can similarly be initialized before running a program.


## Design Philosophy

Rather than implementing an existing ISA, this project uses a custom instruction format designed specifically for the CPU.

The goal was to understand the relationship between assembly, machine code, a general CPU's datapath, and how it all links together with all of the components in between.

This project is the first version of the architecture. Future versions may expand the instruction set and introduce features such as branching and jump instructions.

## Tools

* VHDL
* Quartus
* Python
* Tkinter
* Digital logic / schematic design


The project is intended primarily as a hardware architecture and learning project, and does not aim to reproduce the feature set of modern commercial processors.

## **Note**
To use the Quartus Project :

 - open CPU.qpf
 - ensure all of the dependencies in /CPU/Dependencies are included in the project
 - If you wish to run a program, use the enable ROM program input and program the ROM with a program provided by the assembler

