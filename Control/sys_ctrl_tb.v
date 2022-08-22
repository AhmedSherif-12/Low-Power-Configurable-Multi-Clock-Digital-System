`timescale 1ns/10ps

module sys_ctrl_tb  #(parameter rd_tb=8,parameter ALU_tb=8,parameter UART_size_tb=8) ();



reg clk_tb;
reg rst_tb;
reg [16-1:0] ALU_OUT_tb;
reg out_valid_tb;
reg [rd_tb-1:0] rd_data_tb;
reg rdData_valid_tb;    
reg [UART_size_tb-1:0] rx_p_data_tb;
reg RX_D_VLD_tb;
reg busy_tb;

wire CLK_EN_tb;//clk_gate en
wire ALU_EN_tb;
wire [3:0] ALU_FUN_tb;
wire [3:0] Address_tb;
wire wr_EN_tb;
wire rd_EN_tb;
wire [rd_tb-1:0] Wr_data_tb;
wire [UART_size_tb-1:0] TX_P_DATA_tb;
wire TX_D_VLD_tb;
wire clk_div_en_tb;
    
sys_ctrl #(.rd(rd_tb),.ALU(ALU_tb),.UART_size(UART_size_tb)) DUT(

.clk(clk_tb),
.rst(rst_tb),
.ALU_OUT(ALU_OUT_tb),
.out_valid(out_valid_tb),
.rd_data(rd_data_tb),
.rdData_valid(rdData_valid_tb),    
.rx_p_data(rx_p_data_tb),
.RX_D_VLD(RX_D_VLD_tb),
.busy(busy_tb),
.CLK_EN(CLK_EN_tb),//clk_gate en
.ALU_EN(ALU_EN_tb),
.ALU_FUN(ALU_FUN_tb),
.Address(Address_tb),
.wr_EN(wr_EN_tb),
.rd_EN(rd_EN_tb),
.Wr_data(Wr_data_tb),
.TX_P_DATA(TX_P_DATA_tb),
.TX_D_VLD(TX_D_VLD_tb),
.clk_div_en(clk_div_en_tb)

);

always #0.5 clk_tb=~clk_tb; 

initial
    begin
       $dumpfile("sys_ctrl.vcd");
       $dumpvars;
        rst_tb=1'b1;
        #1
        rst_tb=1'b0;
        #1
        rst_tb=1'b1;
      	clk_tb=1;


        //intialize
      $monitor("TX_P_DATA_tb=%b ,TX_D_VLD_tb=%b,time=%t",TX_P_DATA_tb,TX_D_VLD_tb,$time);
        ALU_OUT_tb=0;
        out_valid_tb=0;
        rd_data_tb=0;
        rdData_valid_tb=0;    
        rx_p_data_tb=0;
        RX_D_VLD_tb=0;
        busy_tb=0;
        #1

        RX_D_VLD_tb=1;
        rx_p_data_tb='hBB;
        #1
       /* rx_p_data_tb='b1;
        $display("wr_data=%b",Wr_data_tb);
        #1
        rx_p_data_tb='b10;
        $display("wr_data=%b,Address=%b",Wr_data_tb,Address_tb);
        #1*/
        rx_p_data_tb='b11;
      $display("Address=%b",Address_tb);
      	RX_D_VLD_tb=0;

        #1
        rdData_valid_tb=1;
        rd_data_tb='b10101010;
        
        //if (TX_D_VLD_tb) begin
            
        //end
        //$display("TX_D_VLD_tb=%b\nTX_P_DATA_tb=%b,time=%t",TX_D_VLD_tb,TX_P_DATA_tb,$time);
        #1
      	 rdData_valid_tb=0;
      	#1

      	/*#0.5
      	 busy_tb=1;
         out_valid_tb=0;
      	#0.5
      	
      busy_tb=0;
      #2*/
     
        //$display("TX_D_VLD_tb=%b\nTX_P_DATA_tb=%b,time=%t",TX_D_VLD_tb,TX_P_DATA_tb,$time);
        $finish;

    end

endmodule