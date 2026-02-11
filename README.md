# Synchronous FIFO RTL Design and Verification

## 📌 Overview
This project implements a parameterized synchronous FIFO in Verilog and verifies it using a SystemVerilog self-checking testbench with scoreboard-based data integrity validation.

## ⚙️ Features
- Parameterized data width and depth
- Write and read pointer logic
- Full and empty flag detection
- Self-checking testbench
- Scoreboard-based data comparison
- Boundary condition testing (empty and full)

## 📂 Project Structure
rtl/  → FIFO RTL implementation  
tb/   → SystemVerilog verification testbench  

## ▶️ Simulation Command
```bash
iverilog rtl/fifo.v tb/fifo_tb.sv -o fifo.out
vvp fifo.out
```

## 🛠 Tools Used
- Verilog
- SystemVerilog
- Icarus Verilog
- EPWave
