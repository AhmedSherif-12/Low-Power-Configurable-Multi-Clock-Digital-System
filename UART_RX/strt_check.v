module strt_check (
    input wire strt_check_en,
    input wire sampled_bit,
    input wire rst,
    input wire clk,
    output reg strt_glitch

);


always @(negedge rst or posedge clk)
    begin
        if (!rst)
            begin
                strt_glitch<=0; 
            end
        else
            begin
                if(strt_check_en)
                    strt_glitch<=sampled_bit;
            end
    end    
        
       
endmodule