# opensoftcore-cpu
An implementation of a single-cycle 32-bit RISC softcore CPU on a MAX10 series FPGA.

Disclaimer: I do not own any intellectual property attributed to ARM, and this processor model is not copied from any ARM
designs. The microarchitecture was implemented using a reverse-engineering understanding of the ARM v4 instructuon set.
I do not make any money from this design, or accept donations on behalf of the work contained in this repository.

## Purpose
This repository exists for educational purposes - to educate any programmers interested in System-on-chip design what 
hardware looks like under the hood. The logic for how processors "interpret" machine code are included in the VHDL files,
which are commented. A knowledge of VHDL will help.

## Instruction Set
This cpu implementation is a single-threaded system that utilizes a slightly modified, bare-bones version
of the ARM v4 instruction set architecture. It is a 32-bit architecture that supports all regular operations such as
arithmetic, comparison, logical, and branching statements.

## Interconnect Methods
The implementation does not rely on structural VHDL. Instead, connections between VHDL components are managed using
block diagram files (.bdf, .bsf). The layout of these interconnects can be found in the schematics folder.

## Building the CPU
The system can be built using the Quartus Prime development suite, which has been provided by Intel as the leading IDE for
Altera-brand FPGAs. The only caveat being that block diagram files are not included in this package to prevent lazy redistribution or
resale of intellectual property.
