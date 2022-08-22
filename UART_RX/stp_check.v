module stp_check (
    input wire stp_check_en,
    input wire sampled_bit,
    input wire rst,
    input wire clk,
    output reg stp_glitch

);


always @(negedge rst or posedge clk)
    begin
        if (!rst)
            begin
                stp_glitch<=0; 
            end
        else
            begin
                if(stp_check_en)
                    stp_glitch<=(!sampled_bit);
            end
    end    
        
       
endmodule