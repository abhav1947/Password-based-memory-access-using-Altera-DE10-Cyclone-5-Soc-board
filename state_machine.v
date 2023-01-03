module state_machine(
input clk,  // to accept password once typed
input en_key,  //data_valid pulse
input rst,
input [3:0] key,
input count_en,
output o_lock,
output o_unlock);

reg [2:0] state;

parameter INIT = 3'h0;
parameter DIGIT_1 = 3'h1;
parameter DIGIT_2 = 3'h2;
parameter DIGIT_3 = 3'h3;
parameter DIGIT_4 = 3'h4;

parameter digit_in_1 = 4'h2;
parameter digit_in_2 = 4'h5;
parameter digit_in_3 = 4'h8;
parameter digit_in_4 = 4'h5;

always@(posedge clk)
begin
	if(rst)
		begin
			state <= INIT;
		end
	else
		begin
			if(en_key)
				begin
					if(!count_en)
						begin
							case(state)
								INIT:
									if(key == digit_in_1)
										begin
											state <= DIGIT_1;
										end
									else
										begin	
											state <= INIT;
										end
								DIGIT_1:
									if(key == digit_in_2)
										begin
											state<= DIGIT_2;
										end
									else
										begin	
											state <= INIT;
										end
								DIGIT_2:
									if(key == digit_in_3)
										begin
											state <= DIGIT_3;
											end
									else
										begin	
											state <= INIT;
										end
								DIGIT_3:
									if(key == digit_in_4)
										begin
											state <= DIGIT_4;
										end
									else
										begin
											state <= INIT;
										end
								DIGIT_4: state <= DIGIT_4;
							endcase
						end
					else
						begin
							state <= INIT;
						end
			end
	else
		begin
			state <= state;
		end
	end
end

assign state_out = state;
assign o_lock= (state == INIT) ? 1'b1 : 1'b0;
assign o_unlock = (state == DIGIT_4) ? 1'b1 : 1'b0;
endmodule






