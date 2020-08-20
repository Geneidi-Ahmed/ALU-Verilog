//`timescale 1ns / 1ps
//Binary to BCD converter module 
module bin2bcd(bin,bcd);

    parameter width = 8;
    //input ports and their sizes
    input [width:0] bin;
    //output ports and, their size
    output [11:0] bcd;
    //Internal variables
    reg [11 : 0] bcd; 
    reg [3:0] i;   
     
     //Always block - implement the Double Dabble algorithm
     always @(bin)
        begin
            bcd = 0; //initialize bcd to zero.
            for (i = 0; i < width+1; i = i+1) //run for 8 iterations
            begin
                bcd = {bcd[10:0],bin[width-i]}; //concatenation    
                //if a hex digit of 'bcd' is more than 4, add 3 to it.  
                if(i < width && bcd[3:0] > 4) 
                    bcd[3:0] = bcd[3:0] + 3;
                if(i < width && bcd[7:4] > 4)
                    bcd[7:4] = bcd[7:4] + 3;
                if(i < width && bcd[11:8] > 4)
                    bcd[11:8] = bcd[11:8] + 3;  
            end
        end           
endmodule         


/*
module binary_to_BCD(A,ONES,TENS,HUNDREDS);
	input [7:0] A;
	output [3:0] ONES, TENS;
	output [1:0] HUNDREDS;
	wire [3:0] c1,c2,c3,c4,c5,c6,c7;
	wire [3:0] d1,d2,d3,d4,d5,d6,d7;
	assign d1 = {1'b0,A[7:5]};
	assign d2 = {c1[2:0],A[4]};
	assign d3 = {c2[2:0],A[3]};
	assign d4 = {c3[2:0],A[2]};
	assign d5 = {c4[2:0],A[1]};
	assign d6 = {1'b0,c1[3],c2[3],c3[3]};
	assign d7 = {c6[2:0],c4[3]};
	add3 m1(d1,c1);
	add3 m2(d2,c2);
	add3 m3(d3,c3);
	add3 m4(d4,c4);
	add3 m5(d5,c5);
	add3 m6(d6,c6);
	add3 m7(d7,c7);
	assign ONES = {c5[2:0],A[0]};
	assign TENS = {c7[2:0],c5[3]};
	assign HUNDREDS = {c6[3],c7[3]};
endmodule

// double dabble, shift and add 3 for larger than 4 
module add3(in,out);
	input [3:0] in;
	output [3:0] out;
	reg [3:0] out;
	always @ (in)
		case (in)
			4'b0000: out <= 4'b0000;
			4'b0001: out <= 4'b0001;
			4'b0010: out <= 4'b0010;
			4'b0011: out <= 4'b0011;
			4'b0100: out <= 4'b0100;
			4'b0101: out <= 4'b1000; // 5 --> 8 
			4'b0110: out <= 4'b1001;
			4'b0111: out <= 4'b1010;
			4'b1000: out <= 4'b1011;
			4'b1001: out <= 4'b1100; // 9 --> 12 
			default: out <= 4'b0000;
		endcase
endmodule


*/


