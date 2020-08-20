//`timescale 1ns / 1ps
// ALU top module 
module alu_top(
	input clk, 
	input rst,
	input pb1,
	input pb2,
	input pb3,
	input [7:0] sw,
	output [7:0] led,
	output [3:0] anode_activate,
	output [6:0] led_out
   );
	
	parameter num_width = 7;	// numbers are 8 bits long
	
	//(* keep = "true" *)  
	wire pb1_db, pb2_db, pb3_db;
	
	reg [num_width:0] a,b;	// a , b registers 
	reg [num_width:0] c;		// c register
	reg carry_out;
	wire [num_width+1:0] c_plus_carry;
	reg [3:0] letter;
	
	wire [15:0] displayed_number;

	wire [11:0] bcd;
	
	/*
	// using fsm to debounce push buttons 
	db_fsm db1 (clk, rst, pb1, pb1_db);
	db_fsm db2 (clk, rst, pb2, pb2_db);
	db_fsm db3 (clk, rst, pb3, pb3_db);
	*/
	
	//much simplier way to debounce push buttons 
	debouncer db1(pb1,clk,rst,pb1_db);
	debouncer db2(pb2,clk,rst,pb2_db);
	debouncer db3(pb3,clk,rst,pb3_db);


	// display status of switches on LEDs
	assign led = sw;
	
	// has to be a ff to hold the c=values even if push buttons are not pressed
	always@(posedge clk)
		begin
			if(rst)	begin a<=0;	b<=0;	c<=sw;	carry_out<=0;	letter<=0;	end
			else if (pb1_db)	begin a<=sw;	c<=sw;	carry_out<=0;	letter<=4'b1010;	end 
			else if (pb2_db)  begin b<=sw;	c<=sw;	carry_out<=0;	letter<=4'b1011; end 
			else if (pb3_db)  
				begin		letter<=4'b1100;	carry_out<=0;
					case (sw)
						8'b0000_0001: {carry_out,c}<=a+b; 
  						8'b0000_0010: c<=a-b; 
						8'b0000_0011: c<=~a; 
  						8'b0000_0100: c<=a&b; 
						8'b0000_0101: c<=a|b; 
  						8'b0000_0110: c<=a^b; 
						// for all other combinations of c reg --> c = 0 --> display C000
						default: c<=0;
					endcase
				end
			// no else case, otherwise a,b,c will not displayed if push buttons are not pressed 
		end
	
	assign c_plus_carry = {carry_out,c};	
	
	// convert DEC to BCD
	bin2bcd bcd1(c_plus_carry,bcd);
	// combine BCD of reg c and letter
	assign displayed_number = {letter,bcd};

	sev_seg sev_seg1(clk,rst,displayed_number,anode_activate,led_out);

endmodule

module t_alu_top();
  
	reg clk_50Mhz,rst,pb1,pb2,pb3;
	reg [7:0] sw;
	wire [7:0] led;
	wire [3:0] anode_activate;
	wire [6:0] led_out;

  initial begin
    //$monitor ($time,,,"A=%d, B=%d, MODE=%b, C=%d",A,B,{},ALU_Out,CarryOut);
    $monitor ($time,,,"pb1=%d, pb2=%d, pb3=%b",pb1,pb2,pb3);
    clk_50Mhz=0;rst=1;pb1=0;pb2=0;pb3=0;
    #2 rst=0;
    sw=8'b1111_1111;pb1=1;
    #10000 pb1=0;
    //displayed_number = 16'b0111_0011_1001_0000;
    // The underscore ?_? is a separator used to improve readability

  end  
  
  always #10 clk_50Mhz=~clk_50Mhz; 
  // clk --> 50 MHz 
  alu_top top1(clk_50Mhz,rst,pb1,pb2,pb3,sw,led,anode_activate,led_out);  
endmodule 