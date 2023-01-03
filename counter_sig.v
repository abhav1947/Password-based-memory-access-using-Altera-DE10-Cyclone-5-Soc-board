module counter_sig
    (
    input clk,
    input rst,
    input en_key,
	 input [3:0] key,
	 input o_unlock,
	 output reg buzzz,
	 output reg out_led,
	 output reg count_en
    );
     reg [3:0] count=0;
	  reg [4:0] count_1 = 0;
    // counter register
   // reg [2:0] count=0;
     integer i;
    // increment or reset the counter
    always @(posedge clk)
    begin
		if (rst)
			begin
				count = 0;
				count_1=0;
				count_en = 0;
				buzzz = 0;
				out_led = 0;
			end
		else 
			begin
			
				if (en_key) //start counting
					begin
						
						count_1 = count_1 + 1;
	
						if(count_1 < 12)
							begin
								buzzz = 1'b0;
				
								if(!o_unlock)
									begin
										if (count<3)
											begin
												count_en = 0;
												out_led = 0;
												count = count + 1;
											end
										else 
											begin
												if(key == 4'b0101)
												begin
													count_en = 0;
													count=0;
												end
												else 
												begin
													count_en = 0;
													count = 0;
													out_led = 1;
												end//next iteration of 4 keys
											end
									end
								else
									begin
										  count_1 = 0;
										//count = 0;
									end
							end 	
						else
							begin
								if(key == 4'b0101)
								begin
								buzzz = 1'b0;
							 	count_1=0;
								end
								else
								begin
								buzzz = 1'b1;
							 	count_1=0;
								end

							end
					end
         end
      end
endmodule
