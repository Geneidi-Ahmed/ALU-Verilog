//`timescale 1ns / 1ps
// seven segement display module 
module sev_seg
	(
		input clk,
		input rst,
		input [15:0] displayed_number,
		output reg [3:0] anode_activate,
		output reg [6:0] led_out
    );
	 
  //reg [18:0] refresh_counter;
  // adjust slow clk for smaller sim time  
  reg [9:0] refresh_counter; 
    
  // 20-bit for creating 10.5ms refresh period or 380Hz refresh rate
  // the first 2 MSB bits for creating 4 LED-activating signals with 2.6ms digit period
  wire [1:0] led_activating_counter; 
  
  // count          0    ->  1  ->  2  ->  3
  // activates    LED1    LED2    LED3    LED4
  //              0111    1011    1101    1110 
  // and repeat
  reg [3:0] led_bcd;
  
  // cut displayed_number into 4 of 4 bits for each led  
  always @(posedge clk or posedge rst)
  begin 
    if(rst)
      refresh_counter <= 0;
    else
      refresh_counter <= refresh_counter + 1;
  end
  
  // assign led_activating_counter = refresh_counter[18:17];
  // for smaller sim time
  assign led_activating_counter = refresh_counter[9:8];
  
  // anode activating signals for 4 LEDs
  // decoder to generate anode signals 
  always @(*)
  begin
    case(led_activating_counter)
      2'b00: begin
        anode_activate = 4'b0111; 
        // activate LED1 and Deactivate LED2, LED3, LED4
        led_bcd = displayed_number[15:12];
        // the first hex-digit of the 16-bit number
      end
      2'b01: begin
        anode_activate = 4'b1011; 
        // activate LED2 and Deactivate LED1, LED3, LED4
        led_bcd = displayed_number[11:8];
        // the second hex-digit of the 16-bit number
      end
      2'b10: begin
        anode_activate = 4'b1101; 
        // activate LED3 and Deactivate LED2, LED1, LED4
        led_bcd = displayed_number[7:4];
        // the third hex-digit of the 16-bit number
      end
      2'b11: begin
        anode_activate = 4'b1110; 
        // activate LED4 and Deactivate LED2, LED3, LED1
        led_bcd = displayed_number[3:0];
        // the fourth hex-digit of the 16-bit number 
      end   
      default:begin
        anode_activate = 4'b000; 
        // Deactivate all
        led_bcd = 4'b0000;
      end
      endcase
    end
    
    // Cathode patterns of the 7-segment LED display 
    always @(*)
    begin
      case(led_bcd)
        4'b0000: led_out  = 7'b0000001; // "0"  
        4'b0001: led_out  = 7'b1001111; // "1" 
        4'b0010: led_out  = 7'b0010010; // "2" 
        4'b0011: led_out  = 7'b0000110; // "3" 
        4'b0100: led_out  = 7'b1001100; // "4" 
        4'b0101: led_out  = 7'b0100100; // "5" 
        4'b0110: led_out  = 7'b0100000; // "6" 
        4'b0111: led_out  = 7'b0001111; // "7" 
        4'b1000: led_out  = 7'b0000000; // "8"  
        4'b1001: led_out  = 7'b0000100; // "9" 
		// not it is active low 						
		4'b1010: led_out  = 7'b0001000; // Hexadecimal A
		4'b1011: led_out  = 7'b1100000; // Hexadecimal B
		4'b1100: led_out  = 7'b0110001; // Hexadecimal C
        default: led_out  = 7'b0000001; // "0"
      endcase
    end

endmodule
