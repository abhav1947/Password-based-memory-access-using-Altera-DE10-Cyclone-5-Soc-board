module mem_mem(
input [7:0] data_in,
input [3:0] addr,
input o_unlock,
input rd_wr,
input en_key,
input clk,
input rst,
output reg [7:0] data_out);

reg [7:0] file_reg [3:0];

always@(posedge clk)
begin
if(rst)
	begin
	data_out <= 8'h00;
	end
else
	begin
		if(o_unlock)
			begin
				if(!rd_wr)
					begin
					data_out <= file_reg[addr];
					end
				else
					begin
					file_reg[addr]<= data_in;
					end
			end
		else
			begin
				data_out <= data_out;
			end
	end
end

endmodule
