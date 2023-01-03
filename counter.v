module counter
    #(BITS = 4)
    (
    input clk,
    input rst,
    output tick,
    output [BITS - 1 : 0] q
    );
     
    // counter register
    reg [BITS - 1 : 0] rCounter;
     
    // increment or reset the counter
    always @(posedge clk, posedge rst)
    begin
        if (rst)
            rCounter <= 0;
        else
       	begin
            rCounter <= rCounter + 1;
            if(rCounter == (2**BITS - 1))
            	rCounter <= 0;
    	end
    end
     // connect counter register to the output wires
    assign q = rCounter;
             
endmodule