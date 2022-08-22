module sys_ctrl #(parameter rd=8,parameter ALU=8,parameter UART_size=8)(
    
    input wire                  clk,
    input wire                  rst,

    input wire [16-1:0]         ALU_OUT,
    input wire                  out_valid,
    input wire [rd-1:0]         rd_data,
    input wire                  rdData_valid,    
    input wire [UART_size-1:0]  rx_p_data,
    input wire                  RX_D_VLD,
    input wire                  busy,

    output reg                  CLK_EN,//clk_gate en
    output reg                  ALU_EN,
    output reg [3:0]            ALU_FUN,
    output reg [3:0]            Address,
    output reg                  wr_EN,
    output reg                  rd_EN,
    output reg [rd-1:0]         Wr_data,
    output reg [UART_size-1:0]  TX_P_DATA,   
    output reg                  TX_D_VLD,   
    output reg                  clk_div_en

);
    
localparam IDLE_RX         =  4'b00,
           //ALU_strt     =  4'b0001,
           operator_A   =  4'b0001,
           operator_B   =  4'b0010,
           ALU_Fn       =  4'b0011,
           ALu_valid    =  4'b0100,
           REG_strt     =  4'b0101,
           REG_wr_add   =  4'b0110,
           REG_rd_add   =  4'b0111,
           REG_wr_data  =  4'b1000,
           reg_valid   =  4'b1001;


//RX
reg [3:0] state_RX;
reg [3:0] next_state_RX;
reg [UART_size:0] data_RX; //used in comapre bet A & B operan
reg [15:0] ALU_OP;


always @(posedge clk or negedge rst)
    begin
        if (!rst)
            begin 
                state_RX<=IDLE_RX;
            end      
        else
            state_RX<=next_state_RX;
    end


always @(*) 
    begin
        case (state_RX)
            IDLE_RX:
                begin
                    CLK_EN=0;//clk_gate en
                    ALU_EN=0;
                    ALU_FUN=0;
                    Address=0;
                    wr_EN=0;
                    rd_EN=0;
                    Wr_data=0;
                    
                    
                    clk_div_en=1;
                    if (RX_D_VLD) 
                        begin
                            case (rx_p_data)
                                'hCC:
                                    next_state_RX=operator_A;
                                'hDD:
                                    begin
                                        CLK_EN='b1;
                                        next_state_RX=ALU_Fn;
                                    end
                                'hAA:
                                    next_state_RX=REG_wr_add;
                                'hBB:
                                    next_state_RX=REG_rd_add;    
                                default:
                                    next_state_RX=IDLE_RX; 
                            endcase
                        end
                    else
                        next_state_RX=IDLE_RX;
                end
            operator_A:
                begin
                    CLK_EN=0;//clk_gate en
                    ALU_EN=0;
                    ALU_FUN=0;
                    Address=0;
                    wr_EN=1;
                    rd_EN=0;
                    Wr_data=rx_p_data;
                    
                    
                    clk_div_en=1;
                    next_state_RX=operator_B;

                        /*if (rx_p_data==8'hCC) 
                            next_state_RX=operator_A;
                        else
                            begin
                                wr_EN=1;
                                Address='b0;
                                Wr_data=rx_p_data;
                                next_state_RX=operator_B;
                                data_RX=rx_p_data;
                            end*/
                end

            operator_B:
                begin
                    CLK_EN=1;//clk_gate en
                    ALU_EN=0;
                    ALU_FUN=0;
                    Address='b01;
                    wr_EN=1;
                    rd_EN=0;
                    Wr_data=rx_p_data;
                    
                    
                    clk_div_en=1;
                    next_state_RX=ALU_Fn;
                       /*if (rx_p_data==data_RX) 
                            next_state_RX=operator_B;
                        else
                            begin
                                wr_EN=1;
                                //Address='b01;
                                Wr_data=rx_p_data;
                                next_state_RX=ALU_Fn;
                                data_RX=rx_p_data;
                            end*/
                end
            ALU_Fn:
                begin
                    CLK_EN=1;//clk_gate en
                    ALU_FUN=rx_p_data[3:0];
                    ALU_EN=1;
                    Address=0;
                    wr_EN=0;
                    rd_EN=0;
                    Wr_data=0;
                    
                    
                    clk_div_en=1;
                    next_state_RX=ALu_valid;
                    
                   /*if (rx_p_data==data_RX) 
                            next_state_RX=ALU_Fn;
                        else
                            begin
                               ALU_FUN=rx_p_data[3:0];
                               ALU_EN=1;
                               next_state_RX=ALu_valid;
                                //data_RX=rx_p_data;
                            end*/
                end

            ALu_valid:
                begin
                    CLK_EN=1;//clk_gate en
                    ALU_FUN=rx_p_data[3:0];
                    ALU_EN=0;
                    Address=0;
                    wr_EN=0;
                    rd_EN=0;
                    Wr_data=0;
                    
                    
                    clk_div_en=1;
                    if (out_valid) 
                        begin
                            ALU_OP=ALU_OUT;
                            next_state_RX=IDLE_RX;
                        end
                    else
                        next_state_RX=IDLE_RX;
                end

            REG_wr_add:
                begin
                    CLK_EN=0;//clk_gate en
                    ALU_EN=0;
                    ALU_FUN=0;
                    Address=rx_p_data;
                    wr_EN=0;
                    rd_EN=0;
                    Wr_data=0;
                    clk_div_en=1;
                    data_RX=rx_p_data;
                    next_state_RX=REG_wr_data; 
                end
            REG_wr_data :   
                begin
                    CLK_EN=0;//clk_gate en
                    ALU_EN=0;
                    ALU_FUN=0;
                    Address=data_RX;
                    wr_EN=1;
                    rd_EN=0;
                    Wr_data=rx_p_data;
                    clk_div_en=1;
                    next_state_RX=IDLE_RX; 
                end
            REG_rd_add :            
                begin
                    CLK_EN=0;//clk_gate en
                    ALU_FUN=0;
                    ALU_EN=0;
                    Address=rx_p_data;
                    wr_EN=0;
                    rd_EN=1;
                    Wr_data=0;
                 
                    clk_div_en=1;
                    next_state_RX=IDLE_RX; 
                end
            default:
                begin
                    CLK_EN=0;//clk_gate en
                    ALU_EN=0;
                    ALU_FUN=0;
                    Address=0;
                    wr_EN=0;
                    rd_EN=0;
                    Wr_data=0;
                    
                    
                    clk_div_en=1;
                    next_state_RX=IDLE_RX;
                end
        endcase        
    end


//TX

localparam IDLE_TX =  2'b00,
           ALU_F1  =  2'b01,
           ALU_F2  =  2'b10,
           Rgf_F   =  2'b11;

reg [1:0] state_TX;
reg [1:0] next_state_TX;

always @(posedge clk or negedge rst) 
    begin
        if (!rst) 
            begin
                state_TX<=IDLE_TX;        
            end
        else
            state_TX<=next_state_TX;
    end

always @(*) 
    begin
        case (state_TX)
            IDLE_TX:
                begin
                    TX_D_VLD=0;
                    TX_P_DATA=0;
                    if (out_valid) 
                        next_state_TX=ALU_F1;
                    else if(rdData_valid)
                        next_state_TX=Rgf_F;
                    else
                        next_state_TX=IDLE_TX;
                end
            ALU_F1:
                begin
                    TX_D_VLD=0;
                    TX_P_DATA=0;
                    if(busy)
                        next_state_TX=IDLE_TX;
                    else
                        begin
                            TX_D_VLD=1;
                            TX_P_DATA=ALU_OP[7:0];
                            next_state_TX=ALU_F2;
                        end

                end
            ALU_F2:
                begin
                    TX_D_VLD=0;
                    TX_P_DATA=0;
                    if(busy)
                        next_state_TX=ALU_F2;
                    else
                        begin
                            TX_D_VLD=1;
                            TX_P_DATA=ALU_OP[15:8];
                            next_state_TX=IDLE_TX;
                        end
                end

            Rgf_F:
                begin
                    if(busy)
                        next_state_TX=IDLE_TX;
                    else
                        begin
                            TX_D_VLD=1;
                            TX_P_DATA=rd_data;
                            next_state_TX=IDLE_TX;
                        end
                end
            


            default: 
                begin
                    TX_D_VLD=0;
                    TX_P_DATA=0;
                    next_state_TX=IDLE_TX;        
                end
        endcase        
    end
           






endmodule