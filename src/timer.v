module timer
#(
 parameter TIMER_MAX = 25
)

(
 input i_Clk,
 input i_Enable,
 input i_Reset,

 output reg o_Done
);

reg [$clog2(TIMER_MAX)-1:0] r_Count = 0;

always @(posedge i_Clk or posedge i_Reset)
begin

 if(i_Reset)
 begin
  r_Count <= 0;
  o_Done <= 0;
 end

 else if(i_Enable)
 begin

  if(r_Count == TIMER_MAX-1)
  begin
   r_Count <= 0;
   o_Done <= 1;
  end

  else
  begin
   r_Count <= r_Count + 1'b1;
   o_Done <= 0;
  end

 end

end

endmodule