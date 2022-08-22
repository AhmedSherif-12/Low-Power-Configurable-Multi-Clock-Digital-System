`timescale 1ns/10ps
module UART_RX_tb (
);

reg       clk_tb;
reg       rst_tb;
reg       RX_IN_tb;
reg       PAR_EN_tb;
reg       PAR_TYP_tb;
reg [4:0] prescale_tb;
wire      data_valid_tb;
wire[7:0] P_data_tb;

//parameter 1=1;
//reg [10:0] value,data;

UART_RX_TOP DUT(

    
    .clk(clk_tb),
    .rst(rst_tb),
    .RX_IN(RX_IN_tb),
    .PAR_EN(PAR_EN_tb),
    .PAR_TYP(PAR_TYP_tb),
    .prescale(prescale_tb),                 
    .data_valid(data_valid_tb),
    .P_data(P_data_tb) 
);

initial
    
    begin
        
        $dumpfile("uart_tx_tb.vcd");
        $dumpvars;
        //$monitor("data",data_valid_tb);

        rst_tb=1'b1;
        #1
        rst_tb=1'b0;
        #1
        rst_tb=1'b1;
        clk_tb=1;

        RX_IN_tb=1'b1;
        PAR_EN_tb=1'b1;
        PAR_TYP_tb=1'b0;
        prescale_tb=5'b10000;

        #1

        RX_IN_tb=1'b0; //start
        #(1*16)

        RX_IN_tb=1'b1; //data
        #(1*16)

        RX_IN_tb=1'b0;
        #(1*16)

        RX_IN_tb=1'b1;
        #(1*16)
        RX_IN_tb=1'b0;
        #(1*16)

        RX_IN_tb=1'b0;
        #(1*16)
        
        RX_IN_tb=1'b0;
        #(1*16)

        RX_IN_tb=1'b0;
        #(1*16)
        RX_IN_tb=1'b1;
        #(1*16)

        RX_IN_tb=1'b0; //parity
        #(1*16)

        RX_IN_tb=1'b1; //stop
        #(1*16)
      
      	#1
       //$display("Valid data=%b \nDATA=%b",data_valid_tb,P_data_tb);

        if (data_valid_tb) 
            
          $display("Valid data -- DATA=%b",P_data_tb);
        else
                $display("Invalid data");

        
        RX_IN_tb=1'b1;
        #(1*16)

        $finish;



    end

//clock generator //5ns ==200Mhz
always #0.5 clk_tb=~clk_tb; 


endmodule