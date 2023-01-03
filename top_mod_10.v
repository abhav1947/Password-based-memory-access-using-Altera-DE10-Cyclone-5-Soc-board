module top_mod_10(
input clk, //clk is clock
input rst, //rst is reset
input on, // turn on the memory
inout [7:0] JA,
input addr_data, //if add_data =1 then write address else write data
input rd_wr,
input in_out,
output g_nd,
output [6:0] seg_o,
output [6:0] addr_out_o,
output [13:0] data_out_o,
output [1:0] pow,
output o_lock,
output count_en,
output buzzz,
output out_led,
//output [6:0] count_seg,
output o_unlock,
output [13:0] data_out_o_o);

wire [7:0] data_out_temp;
wire [7:0] data_out;
wire [3:0] addr_out;
wire [3:0] key;
wire en_key;
reg [3:0] count;

//power to keypad
assign pow = 2'b11;
assign g_nd = 1'b0;
//keypad mod instatiation
pmod_keypad u4(
    .clk(clk),
    .col(JA[3:0]), 
    .row(JA[7:4]), 
    .key(key));

//presentkey==nextkey instatiation
present_next u1(
.clk(clk),
.rst(rst),
.key(key),
.en_key(en_key));


//Count en instantiation
counter_sig u2(
.clk(clk),
.rst(rst),
.key(key),
.out_led(out_led),
.o_unlock(o_unlock),
.buzzz(buzzz),
.en_key(en_key),
.count_en(count_en)
    );

	 
// State machine instantiation	 
state_machine u3(
.clk(clk),  // to accept password once typed
.en_key(en_key),  //data_valid pulse
.rst(rst),
.key(key),
.count_en(count_en),
.o_lock(o_lock),
.o_unlock(o_unlock));



//seven Seg instantiation
sseg_display s1(
    .clk(clk),
    .rst(rst),
    .hex(addr_out),
    .seg(addr_out_o[6:0])
    );
	 
sseg_display r4(
    .clk(clk),
    .rst(rst),
    .hex(data_out[3:0]),
    .seg(data_out_o[6:0])
    );
	 
sseg_display r3(
    .clk(clk),
    .rst(rst),
    .hex(data_out[7:4]),
    .seg(data_out_o[13:7])
    );
	 
sseg_display_m2 s4(
    .clk(clk),
    .rst(rst),
	 .o_unlock(o_unlock),
    .hex(key),
    .seg(seg_o[6:0])
    );
	 

data_in z3(
.clk(clk),
.rst(rst),
.o_unlock(o_unlock),
.key(key),
.on(on),
.en_key(en_key),
.addr_data(addr_data),
.addr_out(addr_out),
.data_out(data_out));

mem_mem f3(
.data_in(data_out),
.addr(addr_out),
.o_unlock(o_unlock),
.rd_wr(rd_wr),
.en_key(en_key),
.clk(clk),
.rst(rst),
.data_out(data_out_temp));

sseg_display_modfy s6(
    .clk(clk),
    .rst(rst),
    .in_out(in_out),
	 .data_in(data_out[3:0]),
	 .data_out(data_out_temp[3:0]),
    .seg(data_out_o_o[6:0])
    );


sseg_display_modfy s9(
    .clk(clk),
    .rst(rst),
    .in_out(in_out),
	 .data_in(data_out[7:4]),
	 .data_out(data_out_temp[7:4]),
    .seg(data_out_o_o[13:7])
    );
	 
/*	 
sseg_display s2(
    .clk(clk),
    .rst(rst),
    .hex(count),
    .seg(count_seg[6:0])
    );
*/
  
endmodule
