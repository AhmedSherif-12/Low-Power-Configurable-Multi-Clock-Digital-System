module UART_RX_TOP (
    input wire clk,
    input wire rst,

    input wire RX_IN,
    input wire PAR_EN,
    input wire PAR_TYP,
    input wire [4:0] prescale,
    output wire data_valid,
    output wire [7:0] P_data

);

wire sampled_bit;
wire strt_glitch;
wire par_err;
wire stp_glitch;

wire strt_chk_en;
wire stp_chk_en;
wire par_chk_en;
wire cnt_en;
wire deser_en;

wire [3:0] bit_cnt;
wire [4:0] edge_cnt;

wire data_samp_en;



strt_check strt(

    .clk(clk),
    .rst(rst),
    .strt_check_en(strt_chk_en),
    .sampled_bit(sampled_bit),
    .strt_glitch(strt_glitch)

);

stp_check stp(

    .clk(clk),
    .rst(rst),
    .stp_check_en(stp_chk_en),
    .sampled_bit(sampled_bit),
    .stp_glitch(stp_glitch)
);

parity_check parity  (

    .clk(clk),
    .rst(rst),
    .par_chk_en(par_chk_en),
    .PAR_TYP(PAR_TYP),
    .sampled_bit(sampled_bit),
    .edge_cnt(edge_cnt),
    .presample(prescale),
    .par_err(par_err)

);
edge_bit_counter cntr(

    .clk(clk),
    .rst(rst),
    .cnt_en(cnt_en),
    .prescale(prescale),
    .bit_cnt(bit_cnt),
    .edge_cnt(edge_cnt)
);

data_sampling Dts(

    .clk(clk),
    .rst(rst),
    .RX_IN(RX_IN),
    .prescale(prescale),
    .edge_cnt(edge_cnt),
    .data_samp_en(data_samp_en),
    .sampled_bit(sampled_bit)
);

deserializer ds(

    .clk(clk),
    .rst(rst),
    .En(deser_en),
    .sampled_bit(sampled_bit),
    .edge_cnt(edge_cnt),
    .presample(prescale),
    .P_data(P_data)
);
FSM_RX fsm(

    .clk(clk),
    .RST(rst),
    .RX_IN(RX_IN),
    .bit_cnt(bit_cnt),
    .edge_cnt(edge_cnt),
    .PAR_EN(PAR_EN),
    .par_err(par_err),
    .strt_glitch(strt_glitch),
    .stp_err(stp_glitch),
    .prescale(prescale),
    .par_chk_en(par_chk_en),
    .strt_chk_en(strt_chk_en),
    .stp_chk_en(stp_chk_en),
    .deser_en(deser_en),
    .counter_en(cnt_en),
    .data_samp_en(data_samp_en),
    .data_valid(data_valid)

);





endmodule