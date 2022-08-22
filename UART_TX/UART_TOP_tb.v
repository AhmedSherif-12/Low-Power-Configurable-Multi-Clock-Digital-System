`timescale 1ns/100ps
module UART_TOP_tb ();

reg CLK_tb;
reg RST_tb;
reg [7:0] P_DATA_tb;
reg       DATA_VALID_tb;
reg       PAR_EN_tb;
reg       PAR_TYP_tb;
wire       S_DATA_TB;
wire       BUSY_tb;


parameter clk_period=5;
  reg [10:0] value,data;


//initial block 

initial

    begin
        $dumpfile("UART_TOP.vcd");
        $dumpvars;
        
        CLK_tb=1'b0;

        
        RST_tb=1'b1;
        #clk_period
        RST_tb=1'b0;
        #clk_period
        RST_tb=1'b1;
        //initialization
      	DATA_VALID_tb=1'b0;
      	PAR_EN_tb=1'b0;
        PAR_TYP_tb=1'b0;
      	P_DATA_tb=8'b0;
      
    //testing
      //case 1
        $display("Test case 1 :Parity enabled & Even");
        P_DATA_tb=8'b0101011;
        data={1'b0,P_DATA_tb[0],P_DATA_tb[1],P_DATA_tb[2],P_DATA_tb[3],P_DATA_tb[4],P_DATA_tb[5],P_DATA_tb[6],
              P_DATA_tb[7],2'b01};
      	#clk_period
        $display("Data=%b",P_DATA_tb);
        DATA_VALID_tb=1'b1;
      	#clk_period
      	DATA_VALID_tb=1'b0;
        value={value,S_DATA_TB};
        PAR_EN_tb=1'b1;
        PAR_TYP_tb=1'b0;
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        $display("Expected Frame=%b",data);
        #clk_period

        if (BUSY_tb==0)
            begin
                $display("Output Frame	=%b",value);
                if(value==data)
                $display("Case 1 successful");
                else  
                $display("Case 1 unsuccessful");
            end
      
      //Case2
        $display("\nTest case 2 :Parity enabled & Odd");
        P_DATA_tb=8'b0101011;
        data={1'b0,P_DATA_tb[0],P_DATA_tb[1],P_DATA_tb[2],P_DATA_tb[3],P_DATA_tb[4],P_DATA_tb[5],P_DATA_tb[6],
              P_DATA_tb[7],2'b11};
      	#clk_period
        $display("Data=%b",P_DATA_tb);
        DATA_VALID_tb=1'b1;
      	#clk_period
      	DATA_VALID_tb=1'b0;
        value={value,S_DATA_TB};
        PAR_EN_tb=1'b1;
        PAR_TYP_tb=1'b1;
        #clk_period
      	value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        $display("Expected Frame=%b",data);
        #clk_period

        if (BUSY_tb==0)
            begin
                $display("Output Frame	=%b",value);
                if(value==data)
                    $display("Case 2 successful");
                else  
                $display("Case 2 unsuccessful");
            end
        
      //case 3
     
        $display("\nTest case 3 :Parity disabled");
        P_DATA_tb=8'b0101011;
        data={1'b0,P_DATA_tb[0],P_DATA_tb[1],P_DATA_tb[2],P_DATA_tb[3],P_DATA_tb[4],P_DATA_tb[5],P_DATA_tb[6],
              P_DATA_tb[7],1'b1};
      	#clk_period
        $display("Data=%b",P_DATA_tb);
        DATA_VALID_tb=1'b1;
      	#clk_period
      	DATA_VALID_tb=1'b0;
        value={value,S_DATA_TB};
        PAR_EN_tb=1'b0;
        PAR_TYP_tb=1'b1;
        #clk_period
      	value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        $display("Expected Frame=%b",data[9:0]);
        #clk_period
      	

        if (BUSY_tb==0)
            begin
                $display("Output Frame	=%b",value[9:0]);
                if(value[9:0]==data[9:0])
                    $display("Case 3 successful");
                    else  
                    $display("Case 3 unsuccessful");
            end
        
    //Case4
        $display("\nTest case 4 :Data valid change during TX");
        P_DATA_tb=8'b0101011;
        data={1'b0,P_DATA_tb[0],P_DATA_tb[1],P_DATA_tb[2],P_DATA_tb[3],P_DATA_tb[4],P_DATA_tb[5],P_DATA_tb[6],
              P_DATA_tb[7],1'b1};
      	#clk_period
        $display("Data=%b",P_DATA_tb);
        DATA_VALID_tb=1'b1;
      	#clk_period
      	DATA_VALID_tb=1'b0;
        value={value,S_DATA_TB};
        PAR_EN_tb=1'b0;
        PAR_TYP_tb=1'b1;
        #clk_period
      	value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
      	DATA_VALID_tb=1'b1;
      	P_DATA_tb=8'b0101001;
        #clk_period
      	DATA_VALID_tb=1'b0;
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        $display("Expected Frame=%b",data[9:0]);
        #clk_period
      	

        if (BUSY_tb==0)
            begin
                $display("Output Frame	=%b",value[9:0]);
                if(value[9:0]==data[9:0])
                    $display("Case 4 successful");
                    else  
                    $display("Case 4 unsuccessful");
            end
      
      $finish;
        
        

     
    end


//instantiate
UART_TOP DUT(

.CLK(CLK_tb),
.RST(RST_tb),
.P_DATA(P_DATA_tb),
.DATA_VALID(DATA_VALID_tb),
.PAR_EN(PAR_EN_tb),
.PAR_TYP(PAR_TYP_tb),
.S_DATA(S_DATA_TB),
.BUSY(BUSY_tb)
);


//clock generator //5ns ==200Mhz
always #(clk_period*0.5) CLK_tb=~CLK_tb;


endmodule


//TEMSA77777 test

/*
`timescale 1ns/100ps

module UART_TOP_tb ();


//Testbench Signals
reg                  CLK_TB;
reg                  RST_TB;
reg     [7:0]        P_DATA_TB;
reg                  Data_Valid_TB;
reg                  parity_enable_TB;
reg                  parity_type_TB; 
wire                 S_DATA_TB;
wire                 busy_TB;

reg [10:0] value;
parameter clk_period=1;
//Initial 
initial
 begin

//initial values
CLK_TB            = 1'b0   ;
RST_TB            = 1'b1   ;    // rst is deactivated
P_DATA_TB         = 8'b11110011  ;
parity_enable_TB  = 1'b1   ;
parity_type_TB    = 1'b0   ;
Data_Valid_TB     = 1'b0   ;

//Reset the design
#5
RST_TB = 1'b0;    // rst is activated
#5
RST_TB = 1'b1;    // rst is deactivated

$monitor("DATA=%b",S_DATA_TB);

#10
//Data_Valid_TB     = 1'b1   ;
 Data_Valid_TB=1'b1;
      	#clk_period
      	Data_Valid_TB=1'b0;
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        #clk_period
        value={value,S_DATA_TB};
        //$display("Expected Frame=%b",data);
        #clk_period

        if (busy_TB==0)
            begin
                $display("Output Frame	=%b",value);
               
            end
//#20
Data_Valid_TB     = 1'b0   ;



#2000

$stop ;

end
 
 
// Clock Generator
//clock generator //5ns ==200Mhz
always #(clk_period*0.5) CLK_TB=~CLK_TB;

// Design Instaniation
UART_TOP DUT (
.CLK(CLK_TB),
.RST(RST_TB),
.P_DATA(P_DATA_TB),
.DATA_VALID(Data_Valid_TB),
.PAR_EN(parity_enable_TB),
.PAR_TYP(parity_type_TB),
.S_DATA(S_DATA_TB), 
.BUSY(busy_TB)
);

endmodule
*/