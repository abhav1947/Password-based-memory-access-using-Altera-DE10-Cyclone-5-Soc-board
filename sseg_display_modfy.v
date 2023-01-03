module sseg_display_modfy(
input clk,
input in_out,
input rst,
input [3:0] data_in, 
input [3:0] data_out,
output reg [6:0] seg
);

    always @(posedge clk or posedge rst)   
    begin
    if(rst)
    seg <= 7'h00;
			else
			begin
				if(in_out)
					begin
						case(data_out)
							4'h0: seg[6:0] = 7'h04;
							4'h1: seg[6:0] = 7'h79;
							4'h2: seg[6:0] = 7'h24;
							4'h3: seg[6:0] = 7'h30;
							4'h4: seg[6:0] = 7'h19;
							4'h5: seg[6:0] = 7'h12;
							4'h6: seg[6:0] = 7'h02;
							4'h7: seg[6:0] = 7'h78;
							4'h8: seg[6:0] = 7'h00;
							4'h9: seg[6:0] = 7'h10;
							4'hA: seg[6:0] = 7'h08;
							4'hB: seg[6:0] = 7'h03;
							4'hC: seg[6:0] = 7'h46;
							4'hD: seg[6:0] = 7'h21;
							4'hE: seg[6:0] = 7'h06;
							default: seg[6:0] = 7'h0E;
						endcase
					end
				else
					begin
						case(data_in)
							4'h0: seg[6:0] = 7'h04;
							4'h1: seg[6:0] = 7'h79;
							4'h2: seg[6:0] = 7'h24;
							4'h3: seg[6:0] = 7'h30;
							4'h4: seg[6:0] = 7'h19;
							4'h5: seg[6:0] = 7'h12;
							4'h6: seg[6:0] = 7'h02;
							4'h7: seg[6:0] = 7'h78;
							4'h8: seg[6:0] = 7'h00;
							4'h9: seg[6:0] = 7'h10;
							4'hA: seg[6:0] = 7'h08;
							4'hB: seg[6:0] = 7'h03;
							4'hC: seg[6:0] = 7'h46;
							4'hD: seg[6:0] = 7'h21;
							4'hE: seg[6:0] = 7'h06;
							default: seg[6:0] = 7'h0E;
						endcase
					end
			end
	end
endmodule
