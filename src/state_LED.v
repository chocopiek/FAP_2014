module state_LED(

 input [2:0] i_State,
 output reg [4:0] o_LED

);

localparam IDLE    = 3'd0;
localparam HEAT    = 3'd1;
localparam PUMP    = 3'd2;
localparam EXTRACT = 3'd3;
localparam SERVE   = 3'd4;

always @(*)
begin

 case(i_State)

 IDLE:    o_LED = 5'b00001;
 HEAT:    o_LED = 5'b00010;
 PUMP:    o_LED = 5'b00100;
 EXTRACT: o_LED = 5'b01000;
 SERVE:   o_LED = 5'b10000;

 default: o_LED = 5'b00000;

 endcase

end

endmodule