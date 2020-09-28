//testbench module
`timescale 1ns/ 1ns

`include "top.v"
//`include "clock50_divider.v"

module testbench;
  reg clk = 1;
  reg clk50;
  wire Hsynq;
  wire Vsynq;
  wire [2:0] Red;
  wire [2:0] Green;
  wire [2:0] Blue;
  integer f;
  
  top UUT(clk,Hsynq,Vsynq,Red,Green,Blue,clk50);
  //always #5 clk = ~clk; //100MHz clock
  always #10 clk = ~clk; //50MHz clock
    
  initial
    begin
      f = $fopen("output.txt","w");
      #50400000;
      $fclose(f);
      $finish();
    end
  
  always @(posedge clk)
	begin
      $fwrite(f,"%0t ns: %b %b %b %b %b\n",$time,Hsynq,Vsynq,Red,Green,Blue);
	end
  
  initial 
    begin 
      $dumpfile("results.vcd");
      $dumpvars(0);
    end
   
endmodule