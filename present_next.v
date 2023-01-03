module present_next(
input clk,
input rst,
input [3:0] key,
output reg en_key);

reg [3:0] temp_key = 0;

always@(posedge clk)
begin
	if(temp_key != key)
	begin
		en_key <= 1'b1;
		temp_key <= key;
	end
	else
	begin
		en_key <= 1'b0;
		temp_key <= temp_key;
	end
end

endmodule
