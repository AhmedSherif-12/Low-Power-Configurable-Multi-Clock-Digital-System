module mux (
    input wire [1:0] sel,
    input wire       i1,
    input wire       i2,
    input wire       i3,
    input wire       i4,

    output reg       mux_out
);

always @(*) 
    begin
        case (sel)
            2'b00:mux_out=i1; 
            2'b01:mux_out=i2; 
            2'b10:mux_out=i3; 
            2'b11:mux_out=i4; 
        endcase    
    end  
endmodule