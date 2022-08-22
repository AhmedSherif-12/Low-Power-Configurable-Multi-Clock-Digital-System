module UART_TOP (

    input wire CLK,
    input wire RST,
    input wire [7:0] P_DATA,
    input wire       DATA_VALID,
    input wire       PAR_EN,
    input wire       PAR_TYP,

    output wire       S_DATA,
    output wire       BUSY


);

wire serial_en;
//wire serial_out;
wire [3:0] bit_no;


wire mux_i2;
wire mux_i3;

wire [1:0] mux_sel;

//wire parity_out;

mux MUX1(

    .sel(mux_sel),
    .i1(1'b0),
    .i2(mux_i2),
    .i3(mux_i3),
    .i4(1'b1),
    .mux_out(S_DATA)    

);

parity p1(

    .P_data(P_DATA),
    .parity_type(PAR_TYP),
    .parity_bit(mux_i3)

);

serializer s1(

    .clk(CLK),
    .rst(RST),
    .load(serial_en),
    .s_input(P_DATA),
    .bit_no(bit_no),
    .s_output(mux_i2)

);

FSM F1(

    .clk(CLK),
    .rst(RST),
    .data_valid(DATA_VALID),
    .bit_no(bit_no),
    .parity_en(PAR_EN),
    .MuX_cntrol(mux_sel),
    .serial_en(serial_en),
    .busy_sig(BUSY)
);
endmodule