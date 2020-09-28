//`include "clock_divider.v" 
`include "clock50_divider.v"
`include "horizontal_counter.v" 
`include "vertical_counter.v" 

module top(
  input clk,
  output Hsynq,
  output Vsynq,
  output [2:0] Red,
  output [2:0] Green,
  output [2:0] Blue,
  output clk_25M
);
  wire clk_25M;
  wire enable_V_Counter;
  wire [15:0] H_Count_Value;
  wire [15:0] V_Count_Value;
  //clock_divider VGA_Clock_gen (clk, clk_25M); //100MHz
  clock50_divider VGA_Clock_gen (clk, clk_25M);  //50MHz
  horizontal_counter VGA_Horiz(clk_25M, enable_V_Counter, H_Count_Value);
  vertical_counter VGA_Verti(clk_25M, enable_V_Counter, V_Count_Value);
  
  //outputs
  assign Hsynq = (H_Count_Value > 96)?1'b1:1'b0;
  assign Vsynq = (V_Count_Value > 2)?1'b1:1'b0;
  
  //colors
  //column 1 is Black
  //column 2 is Red
  //column 3 is Red+Blue (Magenta)
  //column 4 is Blue
  //column 5 is Blue+Green (Cyan)
  //column 6 is Green
  //column 7 is Green+Red (Yellow)
  //column 8 is Green+Red+Blue (White)
  							
  							//2-4 columns									// 7-8 colums
  assign Red = (((H_Count_Value <= 384 && H_Count_Value > 224) || (H_Count_Value <= 784 && H_Count_Value > 624)) && V_Count_Value < 515 && V_Count_Value > 33) ? 3'b111:3'b000;
  							//3-5 columns									// 8 colum
  assign Blue = (((H_Count_Value <= 544 && H_Count_Value > 304) || (H_Count_Value <= 784 && H_Count_Value > 704)) && V_Count_Value < 515 && V_Count_Value > 33) ? 3'b111:3'b000;
  							//5-8 columns
  assign Green = (H_Count_Value <= 784 && H_Count_Value > 464 && V_Count_Value < 515 && V_Count_Value > 33) ? 3'b111:3'b000;
endmodule