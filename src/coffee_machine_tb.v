`timescale 1ns/1ps

module coffee_machine_tb;

reg clk;
reg start;
reg reset;
reg mode;

reg timer_done;

wire timer_enable;
wire [2:0] state;


// Instantiate DUT
coffee_fsm DUT
(
 .i_Clk(clk),
 .i_Start(start),
 .i_Mode(mode),
 .i_Reset(reset),
 .i_Timer_Done(timer_done),
 .o_Timer_Enable(timer_enable),
 .o_State(state)
);


// Clock generation
initial
begin
 clk = 0;
 forever #5 clk = ~clk;   // 100MHz clock
end


// Test sequence
initial
begin

 // init
 start = 0;
 reset = 1;
 mode = 0;
 timer_done = 0;

 #20;
 reset = 0;

 //----------------------------------
 // Test SINGLE SHOT
 //----------------------------------

 $display("Single shot test");

 mode = 0;

 #10 start = 1;
 #10 start = 0;

 #40 timer_done = 1;
 #10 timer_done = 0;

 #40 timer_done = 1;
 #10 timer_done = 0;

 #100;


 //----------------------------------
 // Test DOUBLE SHOT
 //----------------------------------

 $display("Double shot test");

 mode = 1;

 #10 start = 1;
 #10 start = 0;

 #40 timer_done = 1;
 #10 timer_done = 0;

 #40 timer_done = 1;
 #10 timer_done = 0;

 #40 timer_done = 1;
 #10 timer_done = 0;

 #200;

 $stop;

end

endmodule