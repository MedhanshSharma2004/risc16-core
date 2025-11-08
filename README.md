# IITB-CPU  
*A 16-bit RISC-based Processor implemented in VHDL*

---

## Overview
**IITB-CPU** is a simple **16-bit RISC processor** designed and implemented in **VHDL** as part of the *Digital Systems Design Laboratory* at **IIT Bombay**. It supports a small yet expressive **instruction set architecture (ISA)** comprising 14 RIJ-type instructions and is capable of executing basic arithmetic, logical and control operations.

---

## Design Objectives
The project aimed to:
- Design a **16-bit CPU** with **8 general-purpose registers (R0–R7)**.  
- Implement **point-to-point communication** between datapath and controller.  
- Develop a **Controller FSM** to manage instruction cycles.  
- Integrate all modules and verify functionality on an **FPGA board**.

---

## System Specifications

| Component | Description |
|------------|--------------|
| **Word Length** | 16 bits |
| **Registers** | 8 (R0–R7), R7 serves as the Program Counter |
| **Addressing** | Short word addressing (each address = 2 bytes) |
| **Condition Flags** | Carry (C), Zero (Z) |
| **Instruction Formats** | R-type, I-type, J-type |
| **Communication** | Point-to-point between datapath components |
| **Implementation** | VHDL |
| **Simulation & Testing** | ModelSim |

---

## Instruction Set Architecture (ISA)

### **R-Type Instructions**
| Instruction | Opcode | Description |
|--------------|---------|-------------|
| ADD | 0000 | Add RA, RB → RC |
| SUB | 0010 | Subtract RB from RA → RC |
| MUL | 0011 | Multiply RA × RB → RC |
| AND | 0100 | Bitwise AND of RA, RB → RC |
| ORA | 0101 | Bitwise OR of RA, RB → RC |
| IMP | 0110 | Bitwise implication (RA → RB) → RC |

### **I-Type Instructions**
| Instruction | Opcode | Description |
|--------------|---------|-------------|
| ADI | 0001 | Add immediate to RA |
| LW  | 1010 | Load word from memory |
| SW  | 1011 | Store word to memory |
| BEQ | 1100 | Branch if equal |

### **J-Type Instructions**
| Instruction | Opcode | Description |
|--------------|---------|-------------|
| LHI | 1000 | Load high immediate |
| LLI | 1001 | Load low immediate |
| JAL | 1101 | Jump and link |
| JLR | 1111 | Jump and link register |

---

## Verification & Simulation
The design was verified through **test benches** written in VHDL.  
Simulation was performed using **ModelSim**.

---
