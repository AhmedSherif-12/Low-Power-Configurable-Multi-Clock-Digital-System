module FSM (
    input wire       clk,
    input wire       rst,
    input wire       data_valid,
    input wire [3:0] bit_no,
    input wire       parity_en,

    output reg [1:0] MuX_cntrol,
    output reg       serial_en,
    output reg       busy_sig

);
    
localparam IDLE   =  3'b0,
           start  =  3'b001,
           data   =  3'b010,
           parity =  3'b011,
           stop   =  3'b100;

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or negedge rst) 
    begin
        if (!rst) 
            state<=IDLE;
        else
            state<=next_state;
    end

always @(*)
    begin

        case (state)
            IDLE:
                begin
                    busy_sig=1'b0;
                    MuX_cntrol=2'b11; //output high
                    if (data_valid) 
                        begin
                            busy_sig=1'b1;
                            serial_en=1'b1;
                            next_state=start;
                            
    
                        end
                    else
                        next_state=IDLE;
                end

            start:
                begin
                    busy_sig=1'b1;
                    serial_en=1'b0;
                    MuX_cntrol=2'b00;
                    next_state=data;      
                end

            data:
                begin
                    busy_sig=1'b1;
                    serial_en=1'b0;
                    MuX_cntrol=2'b01; 
                       
                        if (bit_no<8) 
                            next_state=data;
                        else
                            begin
                                if (parity_en) 
                                    begin
                                        next_state=parity;
                                    end
                                else
                                    next_state=stop;
                            end
                            
                end 
            
            parity:
                begin
                    busy_sig=1'b1;
                    serial_en=1'b0;
                    MuX_cntrol=2'b10;
                    next_state=stop;
                end
            
            stop:
                begin
                    busy_sig=1'b1;
                    serial_en=1'b0;
                    MuX_cntrol=2'b11;
                    next_state=IDLE;

                end
            default: next_state=IDLE; 
        endcase


    end     
endmodule