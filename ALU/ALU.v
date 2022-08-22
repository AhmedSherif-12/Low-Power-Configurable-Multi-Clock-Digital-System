module ALU (
    input wire        clk,
    input wire        rst,
    input wire [8:0]  A,
    input wire [8:0]  B,
    input wire [3:0]  ALU_FUN,
    input wire        EN,
    output reg [15:0] ALU_OUT,
    output reg        ALU_VALID
);
reg [15:0] ALU_O_Comp;
reg         data_VLD_COMP;
always @(posedge clk or negedge rst)
    begin
        if (!rst) 
            begin
                ALU_OUT<=0;
                ALU_VALID<=0;
            end
        else
            begin
                ALU_OUT<=ALU_O_Comp;
                ALU_VALID<=data_VLD_COMP;
            end

        end
always @(*) 
    begin
        if(EN)
            begin
                case (ALU_FUN)
                    4'b0000:
                    begin
                        ALU_O_Comp=A+B;
                    data_VLD_COMP=1;
                    end
                    
                    4'b0001:
                    begin
                        ALU_O_Comp=A-B;
                    data_VLD_COMP=1;
                    end
                    4'b0010:
                    begin
                        ALU_O_Comp=A*B;
                    data_VLD_COMP=1;
                    end
                    4'b0011:
                    begin
                        
                        ALU_O_Comp=A/B;
                    data_VLD_COMP=1;
                    end
                    4'b0100:
                    begin
                        ALU_O_Comp=A&B;
                    data_VLD_COMP=1;
                    end
                    4'b0101:
                    begin
                        ALU_O_Comp=A|B;
                    data_VLD_COMP=1;
                    end
                    4'b0110:
                    begin
                        ALU_O_Comp= ~(A&B);
                    data_VLD_COMP=1;
                    end
                    4'b0111:
                    begin
                        ALU_O_Comp=~(A|B);
                    data_VLD_COMP=1;
                    end
                    4'b1000:
                    begin
                        ALU_O_Comp=A^B;
                    data_VLD_COMP=1;
                    end
                    4'b1001:
                    begin
                        ALU_O_Comp=~(A^B);
                        data_VLD_COMP=1;
                    end
                    4'b1010:
                    begin
                        if (A==B)
                            begin 
                                ALU_O_Comp= 16'b1;
                                data_VLD_COMP=1; 
                            end 
                        else
                            begin
                                ALU_O_Comp= 16'b0;   
                                data_VLD_COMP=1;
                            end
                    end
                    4'b1011:
                    begin
                        ALU_O_Comp=(A>B) ? 16'b10 : 16'b0;
                    data_VLD_COMP=1;
                    end
                    4'b1100:
                    begin
                        ALU_O_Comp=(A<B) ? 16'b11 : 16'b0;
                        data_VLD_COMP=1;
                    end
                    4'b1101:
                    begin
                        ALU_O_Comp=(A>>1);
                        data_VLD_COMP=1;
                    end
                    4'b1110:
                    begin
                        ALU_O_Comp=(A<<1);
                        data_VLD_COMP=1;
                    end
                
                    default: 
                        begin
                        ALU_O_Comp=16'b0;
                        data_VLD_COMP=1;

                        end
                endcase
            end
        else
            begin
                ALU_O_Comp=0;
                data_VLD_COMP=0;
            end


    end

endmodule
