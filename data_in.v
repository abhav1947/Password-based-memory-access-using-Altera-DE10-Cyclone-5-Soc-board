module data_in(
input clk,
input rst,
input o_unlock,
input [3:0] key,
input on,
input en_key,
input addr_data,
output reg [3:0] addr_out,
output [7:0] data_out);

reg [3:0] data_out_temp [1:0];
reg [1:0] count = 0;



always@(posedge clk or posedge rst)
begin
	if(rst)
		begin
			addr_out <= 4'h0;
			data_out_temp[0] <= 4'h0;
			data_out_temp[1] <= 4'h0;
		end
else
begin	
	if(on && o_unlock && en_key)
		 begin
		  if(addr_data)
				begin
					addr_out <= key;
					//data_out_temp[0] <= data_out_temp[0];
					//data_out_temp[1] <= data_out_temp[1];
				end
		  else
				begin
					if(count <= 1)
						begin
							data_out_temp[count] <= key;
							count <= count+1;
						end
					else
						begin
							count <= 0;
							  data_out_temp[0] <= 4'h0;
							  data_out_temp[1] <= 4'h0;
					   end
				 end
			end
	else
	 begin
			addr_out <= addr_out;
			data_out_temp[0] <= data_out_temp[0];
			data_out_temp[1] <= data_out_temp[1];
	 end		 
end
end

	
assign data_out[3:0] = data_out_temp[0];
assign data_out[7:4] = data_out_temp[1];

endmodule