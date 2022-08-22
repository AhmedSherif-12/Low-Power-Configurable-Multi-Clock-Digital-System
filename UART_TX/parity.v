module parity (
    input wire [7:0] P_data,
    input wire       parity_type,
    output reg       parity_bit
);

always @(*)
    begin
        if (parity_type==0)  //even 
            
            parity_bit=^P_data;

        else
            parity_bit=~(^P_data); 
 
    end
endmodule