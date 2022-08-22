module serializer (
    input wire       clk,
    input wire       rst,
    input wire       load,
    input wire [7:0] s_input,

    output reg [3:0] bit_no,
    output reg       s_output

);
reg [7:0] temp;
always @(posedge clk or negedge rst)
 begin
     if (!rst) 
        begin
            temp<=8'b0;
            s_output<=1'b0;
            bit_no<=4'b0;
        end
     else

        begin
           if (load) 
                begin
                   temp<=s_input;
                   bit_no<=4'b0;
                end

            else
                begin
                    if (bit_no<=3'b111) 
                        begin
                          s_output<=temp[bit_no];
                          bit_no<=bit_no+1'b1; 
                        end
                    else
                        begin
                             s_output<=1'b0;
                        end
                end
        end
 end
endmodule