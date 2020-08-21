# ALU-Verilog
An implementation of a simple ALU using VHDL


### Project Block Diagram
ALU is an arithmetic logic unit. It has limited number of instructions to perform it executes six instructions, and takes two operands 8-bit width.
This project was implemented on Basys 2 Spartan-3E FPGA interfacing with: 
- Swithes
- Push Buttons
- Seven Segments
- LEDs

![Block Diagram](../BlockDiagram.jpeg?raw=true)

The user enters the binary combination of the two operands and select the opcode through the switches,whenever a switch is high the corresponding led is turned on and also the decimal value of the operands and the op code appears on the seven segments. When the user hit the push putton of the opcode the result appers on the seven segments afterwards.

![FPGA Kit](../kit.jpeg?raw=true)

### Instruction Set
The ALU has a limited instruction set. It can only do basic operations: Add and Sub ... etc.

Here's a table of opcodes used:

![InstructionSet](../Instructions.jpeg?raw=true)

### Push Buttons Debouncing

The Algorthim used in debouncing the mechinchal switches is reading the switches for 10 times and the descion is only taken after 10 consecutive successful readings.

### Simulation Results
Here are snapshots of the simulation test bench. 

**Entering the two operands**

![sim1](../sim1.jpg?raw=true)

*Note:* Here, you can see the two operands are entered on the same switch the only thing that differs them is the push button.

**Entering the opcode of complement instruction**

![sim2](../sim2.jpg?raw=true)

Output is equal to 0b11111110 (254) which is ~(1)

### References

1. https://zipcpu.com/blog/2017/08/04/debouncing.html
2. https://www.fpga4student.com/2017/09/seven-segment-led-display-controller-basys3-fpga.html