//`timescale 1ns / 1ps
//cdebounce module for push buttons 
module debouncer(button_in,clk,rst,p);
	input button_in;
    input clk;
	input rst;
    output reg p;
	reg [9:0] but_value;
	reg [1:0] but_output;

	always@(posedge clk)
		begin
			if(rst == 1)
				begin
					but_value<=10'b0;
					but_output<=2'b0;
				end
			else
				begin
					// evealuate RHS first and hence all 10 bits are ones after 10 clk cycles --> input is stable  
					but_value[0] <= button_in;
					but_value[1] <= but_value[0];
					but_value[2] <= but_value[1];
					but_value[3] <= but_value[2];
					but_value[4] <= but_value[3];
					but_value[5] <= but_value[4];
					but_value[6] <= but_value[5];
					but_value[7] <= but_value[6];
					but_value[8] <= but_value[7];
					but_value[9] <= but_value[8];
					/*
					if(but_value == 10'b1111111111)
					begin
						but_output[0]<=1;
						but_output[1]<=but_output[0];
					end
					else
					begin
						but_output[0]<=0;
						but_output[1]<=but_output[0];
					end
					*/
					// much simpler than if else statement 
					but_output[0]<=&but_value;
					but_output[1]<=but_output[0];
				end
		end

	always@(but_output)
		begin
			// got one and the previous value is zero --> push button is pressed 
			if(but_output == 2'b01)	p=1;
			else	p=0;
		end
		
endmodule


/*

// fsm is ued to debounce push buttons
module db_fsm(input clk, rst, sw, output reg db);

  // Defined state encoding
  parameter zero    = 3'b000;
  parameter wait1_1 = 3'b001; 
  parameter wait1_2 = 3'b010;
  parameter wait1_3 = 3'b011; 
  parameter one     = 3'b100;
  parameter wait0_1 = 3'b101; 
  parameter wait0_2 = 3'b110;
  parameter wait0_3 = 3'b111; 
  
  //  19-bit counter with clk of 50 MHz --> tick = 2^19 * 20n = 10.48m
  // counter to generate 10 ms tick 
  parameter N = 19; 

  reg [N-1:0] count;
  wire tick;
  reg [2:0] current_state, next_state;
  
  always @(posedge clk or posedge rst)
  begin
    if(rst) count <= 0;
    else count <= count + 1;
  end
  // piece-wise anding of all count bits 
  // set only tick = 1 if all bits of count are ones 
  // after that count will over flow and reset to zero and start counting again
  assign tick = &count; 



  

  // always block for state register 
  always @(posedge clk or posedge rst)
  begin
    if (rst) current_state <= zero; 
    else current_state <= next_state;
  end
  
  // always block for combinational logic portion 
  // next state logic and output logic 
  always @(*) 
  begin
      next_state = current_state; // default state: the same  
      db = 0; // default output: 0 
      case (current_state)
        
        zero: if (sw) next_state = wait1_1; 
        wait1_1: 
          begin
            if (~sw) next_state = zero; 
            else 
              if(tick) next_state = wait1_2; 
          end
        wait1_2: 
          begin
            if (~sw) next_state = zero; 
            else 
              if(tick) next_state = wait1_3; 
          end
        wait1_3: 
          begin
            if (~sw) next_state = zero; 
            else 
              if(tick) next_state = one; 
          end
        one: 
          begin
            db = 1;
            if (~sw) next_state = wait0_1; 
          end
        wait0_1:  
          begin
            db = 1;
            if (sw) next_state = one;
            else  
              if (tick) next_state = wait0_2;
          end
        wait0_2:  
          begin
            db = 1;
            if (sw) next_state = one;
            else  
              if (tick) next_state = wait0_3;
          end
        wait0_3:  
          begin
            db = 1;
            if (sw) next_state = one;
            else  
              if (tick) next_state = zero;
          end
        default:  next_state = zero;
    endcase       
  end
endmodule


*/
