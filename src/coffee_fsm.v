module coffee_fsm(

 input i_Clk,
 input i_Start,
 input i_Mode,
 input i_Reset,

 input i_Timer_Done,

 output reg o_Timer_Enable,
 output reg [2:0] o_State

);

localparam IDLE    = 3'd0;
localparam HEAT    = 3'd1;
localparam PUMP    = 3'd2;
localparam EXTRACT = 3'd3;
localparam SERVE   = 3'd4;

reg shot_done;

always @(posedge i_Clk or posedge i_Reset)
begin

 if(i_Reset)
 begin
  o_State <= IDLE;
  shot_done <= 0;
 end

 else
 begin

 case(o_State)

 IDLE:
 begin
  shot_done <= 0;
  o_Timer_Enable <= 0;

  if(i_Start)
   o_State <= HEAT;
 end

 HEAT:
 begin
  o_Timer_Enable <= 1;

  if(i_Timer_Done)
   o_State <= PUMP;
 end

 PUMP:
 begin
  o_Timer_Enable <= 0;
  o_State <= EXTRACT;
 end

 EXTRACT:
 begin
  o_Timer_Enable <= 1;

  if(i_Timer_Done)
  begin

   if(i_Mode && !shot_done)
   begin
    shot_done <= 1;
    o_State <= PUMP;
   end

   else
    o_State <= SERVE;

  end

 end

 SERVE:
 begin
  o_Timer_Enable <= 0;
  o_State <= IDLE;
 end

 endcase

 end

end

endmodule