module clock50_divider (
  input wire clk, //50MHz
  output reg divided_clk = 0 //25 MHz
);
  always@ (posedge clk)
      divided_clk <= ~divided_clk; //flip the signal
endmodule