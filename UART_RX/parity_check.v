module parity_check (
    
    input wire clk,
    input wire rst,
    input wire par_chk_en,
    input wire PAR_TYP,
    input wire sampled_bit,
    input wire [4:0] edge_cnt,
    input wire [4:0] presample,
    output reg par_err

);
    
reg [8:0] data;
//reg p_out_comb;
always @(posedge clk or negedge rst) 
    begin
        if (!rst)
            begin
                par_err<=0;
                //p_out_comb<=0;
                data<=0;
            end

        else
            
            if (par_chk_en && edge_cnt==((presample>>1)+2))
                    data<={data,sampled_bit};
            else
                begin
                    
                    if (PAR_TYP==0) 
                        par_err<=((^data[8:1])==data[0]) ? 1'b0:1'b1;
                    else
                        par_err<=((~(^data[8:1]))==data[0]) ? 1'b0:1'b1;  
                    data<=0;
                end        
            
    end
    
 /*   always @(*) 
        begin
        
            
            if (par_chk_en && edge_cnt==((presample>>1)+2))
                data={data,sampled_bit};
            else
                begin
                    
                    if (PAR_TYP==0) 
                        par_err=((^data[8:1])==data[0]) ? 1'b0:1'b1;
                    else
                        par_err=((~(^data[8:1]))==data[0]) ? 1'b0:1'b1;  
                    data=0;
                end              
         end
*/
/*always @(*) 

    begin
        
        if (par_chk_en && edge_cnt==((presample>>1)+1))
            data={data,sampled_bit};
        else
            if (PAR_TYP==0) 
               p_out_comb=((^data[8:1])==data[0]) ? 1'b0:1'b1;
            else
               p_out_comb=((~(^data[8:1]))==data[0]) ? 1'b0:1'b1;
                
    end*/

endmodule