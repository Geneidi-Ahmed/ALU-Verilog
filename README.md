# ALU-Verilog
An implementation of a simple ALU using Verilog
### Project Block Diagram
ALU is an arithmetic logic unit. It has limited number of instructions to perform it executes six instructions, and takes two operands 8-bit width.
This project was implemented on Basys 2 Spartan-3E FPGA interfacing with: 
- Swithes
- Push Buttons
- Seven Segments
- LEDs


![BlockDiagram](https://user-images.githubusercontent.com/59480727/90840170-90d9aa80-e359-11ea-82df-3160ff30dbd2.jpeg)

The user enters the binary combination of the two operands and select the opcode through the switches,whenever a switch is high the corresponding led is turned on and also the decimal value of the operands and the op code appears on the seven segments. When the user hit the push putton of the opcode the result appers on the seven segments afterwards.

![kit](https://user-images.githubusercontent.com/59480727/90840193-a18a2080-e359-11ea-82a3-6b44a3bbcebb.jpeg)

### Instruction Set
The ALU has a limited instruction set. It can only do basic operations: Add and Sub ... etc.

Here's a table of opcodes used:

![Instructions](https://user-images.githubusercontent.com/59480727/90840070-4a844b80-e359-11ea-87dc-644823e8e57f.jpeg)

### Push Buttons Debouncing

The Algorthim used in debouncing the mechinchal switches is reading the switches for 10 times and the descion is only taken after 10 consecutive successful readings by using the non blocking assignment.

Evaluating RHS first and hence all 10 bits are ones after 10 clk cycles --> input is stable

### Simulation Results
Here are snapshots of the simulation test bench. 

**Entering the two operands**

![sim1](https://user-images.githubusercontent.com/59480727/90840223-b797e100-e359-11ea-88a5-0436de1cca93.jpg)

*Note:* Here, you can see the two operands are entered on the same switch the only thing that differs them is the push button.

**Entering the opcode of complement instruction**

![sim2](https://user-images.githubusercontent.com/59480727/90840252-c9798400-e359-11ea-87c1-dfb8265877c5.jpg)

Output is equal to 0b11111110 (254) which is ~(1)

### References

1. https://zipcpu.com/blog/2017/08/04/debouncing.html
2. https://www.fpga4student.com/2017/09/seven-segment-led-display-controller-basys3-fpga.html
