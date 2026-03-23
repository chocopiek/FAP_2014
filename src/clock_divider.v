module clock_divider
#(
 parameter CLOCK_FREQ = 100_000_000,
 parameter TARGET_FREQ = 1
)

(
 input i_Clk,
 output reg o_Tick
);

localparam DIV_VALUE = CLOCK_FREQ/(2*TARGET_FREQ);

reg [$clog2(DIV_VALUE)-1:0] r_Count = 0;

always @(posedge i_Clk)
begin

 if(r_Count == DIV_VALUE-1)
 begin
  r_Count <= 0;
  o_Tick <= ~o_Tick;
 end

 else
  r_Count <= r_Count + 1'b1;

end

endmodule