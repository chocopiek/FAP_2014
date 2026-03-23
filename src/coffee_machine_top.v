module coffee_machine_top(

 input clk,
 input btn_start,
 input btn_reset,
 input mode_switch,

 output [4:0] LED

);

wire start;
wire tick_1hz;
wire timer_done;
wire timer_enable;
wire [2:0] state;

debounce #(1000000) start_db
(
 .i_Clk(clk),
 .i_Bouncy(btn_start),
 .o_Debounced(start)
);

clock_divider #(100_000_000,1) clk_div
(
 .i_Clk(clk),
 .o_Tick(tick_1hz)
);

timer #(25) coffee_timer
(
 .i_Clk(tick_1hz),
 .i_Enable(timer_enable),
 .i_Reset(btn_reset),
 .o_Done(timer_done)
);

coffee_fsm fsm
(
 .i_Clk(clk),
 .i_Start(start),
 .i_Mode(mode_switch),
 .i_Reset(btn_reset),
 .i_Timer_Done(timer_done),
 .o_Timer_Enable(timer_enable),
 .o_State(state)
);

state_LED led_display
(
 .i_State(state),   
 .o_LED(LED)
);
endmodule