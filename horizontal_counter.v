module horizontal_counter(
  input clk_25MHz,
  output reg enable_V_Counter = 0,
  output reg [15:0] H_Count_Value = 0
);
  always@(posedge clk_25MHz) begin
    if (H_Count_Value <800) begin
      H_Count_Value<= H_Count_Value +1;
      enable_V_Counter <= 0; //disable Horizontal Counter
      if (H_Count_Value == 799) 
        enable_V_Counter <= 1; // trigger V Counter
    end
    else begin
      H_Count_Value <= 1; //reset Horizontal Counter
      enable_V_Counter <= 0; // trigger V Counter
    end
  end
    
endmodule