module UART # ( parameter DATA_WIDTH = 8 , PRESCALE_WIDTH = 5 )

(
 input   wire                          RST,
 input   wire                          TX_CLK,
 input   wire                          RX_CLK,
 input   wire                          RX_IN_S,
 output  wire   [DATA_WIDTH-1:0]       RX_OUT_P, 
 output  wire                          RX_OUT_V,
 input   wire   [DATA_WIDTH-1:0]       TX_IN_P, 
 input   wire                          TX_IN_V, 
 output  wire                          TX_OUT_S,
 output  wire                          TX_OUT_V,  
 input   wire   [PRESCALE_WIDTH-1:0]   Prescale,
 input   wire                          parity_enable,
 input   wire                          parity_type
);


UART_TOP  U0_UART_TX (
.CLK(TX_CLK),
.RST(RST),
.P_DATA(TX_IN_P),
.DATA_VALID(TX_IN_V),
.PAR_EN(parity_enable),
.PAR_TYP(parity_type), 
.S_DATA(TX_OUT_S),
.BUSY(TX_OUT_V)
);
 
 
UART_RX_TOP U0_UART_RX (
.clk(RX_CLK),
.rst(RST),
.RX_IN(RX_IN_S),
.prescale(Prescale),
.PAR_EN(parity_enable),
.PAR_TYP(parity_type),
.P_data(RX_OUT_P), 
.data_valid(RX_OUT_V)
);

endmodule