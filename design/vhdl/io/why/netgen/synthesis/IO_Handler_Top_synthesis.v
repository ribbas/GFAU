////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: IO_Handler_Top_synthesis.v
// /___/   /\     Timestamp: Wed May  9 18:51:53 2018
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/synthesis -ofmt verilog -sim IO_Handler_Top.ngc IO_Handler_Top_synthesis.v 
// Device	: xc6slx9-3-tqg144
// Input file	: IO_Handler_Top.ngc
// Output file	: /home/brian/asdf/why/netgen/synthesis/IO_Handler_Top_synthesis.v
// # of Modules	: 1
// Design Name	: IO_Handler_Top
// Xilinx        : /opt/Xilinx/14.7/ISE_DS/ISE/
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module IO_Handler_Top (
  Start, t_clk, g_rst, INTA, clk, op_done, gen_rdy, z_err, oob_err, ready_sig, err, INT, rst, gfau_data, input_size, data, opcode_out, out_data
);
  input Start;
  input t_clk;
  input g_rst;
  input INTA;
  input clk;
  input op_done;
  input gen_rdy;
  input z_err;
  input oob_err;
  output ready_sig;
  output err;
  output INT;
  output rst;
  input [15 : 0] gfau_data;
  input [3 : 0] input_size;
  inout [31 : 0] data;
  output [5 : 0] opcode_out;
  output [31 : 0] out_data;
  wire gfau_data_15_IBUF_0;
  wire gfau_data_14_IBUF_1;
  wire gfau_data_13_IBUF_2;
  wire gfau_data_12_IBUF_3;
  wire gfau_data_11_IBUF_4;
  wire gfau_data_10_IBUF_5;
  wire gfau_data_9_IBUF_6;
  wire gfau_data_8_IBUF_7;
  wire gfau_data_7_IBUF_8;
  wire gfau_data_6_IBUF_9;
  wire gfau_data_5_IBUF_10;
  wire gfau_data_4_IBUF_11;
  wire gfau_data_3_IBUF_12;
  wire gfau_data_2_IBUF_13;
  wire gfau_data_1_IBUF_14;
  wire gfau_data_0_IBUF_15;
  wire input_size_3_IBUF_16;
  wire input_size_2_IBUF_17;
  wire input_size_1_IBUF_18;
  wire input_size_0_IBUF_19;
  wire Start_IBUF_20;
  wire t_clk_BUFGP_21;
  wire g_rst_IBUF_22;
  wire INTA_IBUF_23;
  wire clk_BUFGP_24;
  wire op_done_IBUF_25;
  wire gen_rdy_IBUF_26;
  wire z_err_IBUF_27;
  wire oob_err_IBUF_28;
  wire serial_d;
  wire ready_sig_OBUF_47;
  wire err_OBUF_48;
  wire INT_OBUF_49;
  wire \FSM/err_type_50 ;
  wire \FSM/serial_e_51 ;
  wire deserial_r;
  wire \FSM/poly_gen_53 ;
  wire \FSM/wr_rd_54 ;
  wire \deser/done_87 ;
  wire \deser/count_rst_88 ;
  wire count_rst;
  wire data_31_IOBUF_108;
  wire N1;
  wire t_clk_inv;
  wire \iop/oe_inv ;
  wire \num_clks<0>_bdd5 ;
  wire \serial/mux14 ;
  wire \serial/mux13 ;
  wire \serial/GND_6_o_bus_size[1]_equal_1_o ;
  wire \FSM/_n0291_inv2 ;
  wire \FSM/_n0395_inv1 ;
  wire \FSM/GND_4_o_state[7]_equal_43_o<7>1_152 ;
  wire \FSM/GND_4_o_state[7]_equal_10_o<7>1 ;
  wire \FSM/GND_4_o_n_state[1]_Select_55_o<1>12 ;
  wire \FSM/_n0369_inv ;
  wire \FSM/_n0356_inv ;
  wire \FSM/_n0352_inv ;
  wire \FSM/_n0321_inv ;
  wire \FSM/_n0317_inv ;
  wire \FSM/_n0302_inv ;
  wire \FSM/_n0268_inv ;
  wire \FSM/_n0261_inv ;
  wire \FSM/_n0271_inv ;
  wire \FSM/GND_4_o_state[7]_equal_9_o ;
  wire \FSM/GND_4_o_state[7]_equal_10_o ;
  wire \FSM/GND_4_o_state[7]_equal_11_o ;
  wire \FSM/PWR_4_o_state[7]_equal_12_o ;
  wire \FSM/GND_4_o_state[7]_equal_8_o ;
  wire \FSM/GND_4_o_n_state[1]_Select_55_o ;
  wire \FSM/GND_4_o_wr_rd_Select_28_o ;
  wire \FSM/GND_4_o_s_state[0]_Select_21_o ;
  wire \FSM/GND_4_o_serial_e_Select_31_o ;
  wire \FSM/GND_4_o_opcode_in[5]_equal_3_o ;
  wire \FSM/deserial_ne_INV_32_o ;
  wire \FSM/serr_INV_40_o ;
  wire \FSM/s_state[4]_INV_37_o ;
  wire \FSM/s_state[5]_INV_47_o ;
  wire \FSM/n_state[3]_INV_41_o ;
  wire \FSM/deserial_se_INV_8_o ;
  wire \FSM/nerr_INV_18_o ;
  wire \FSM/ngen_INT_INV_15_o ;
  wire \FSM/nop_INT_INV_12_o ;
  wire \FSM/deserial_ne_187 ;
  wire \FSM/s_state_2_188 ;
  wire \FSM/s_state_3_189 ;
  wire \FSM/n_state_3_190 ;
  wire \FSM/serr_191 ;
  wire \FSM/s_state_4_192 ;
  wire \FSM/s_state_5_193 ;
  wire \FSM/n_state_1_194 ;
  wire \FSM/nop_INT_195 ;
  wire \FSM/ngen_INT_196 ;
  wire \FSM/nerr_197 ;
  wire \FSM/n_state_7_198 ;
  wire \FSM/deserial_se_199 ;
  wire \FSM/s_state_0_200 ;
  wire \deser/_n0259_inv ;
  wire \deser/_n0250_inv ;
  wire \deser/_n0238 ;
  wire \deser/_n0219 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<0> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<1> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<2> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<3> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<4> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<5> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<6> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<7> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<8>_213 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<9>_214 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<10>_215 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<11>_216 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<12> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<13> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<14> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<15> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<16> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<17> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<18> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<19> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<20> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<21> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<22> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<23> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<24> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<25> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<26> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<27> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<28> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<29> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<30> ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<31> ;
  wire N0;
  wire N2;
  wire N4;
  wire \FSM/GND_4_o_s_state[0]_Select_21_o1_240 ;
  wire \FSM/GND_4_o_s_state[0]_Select_21_o2_241 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<23>2_242 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<23>3_243 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<23>4_244 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<22>2_245 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<22>3_246 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<22>4_247 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<21>2_248 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<21>3_249 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<21>4_250 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<20>2_252 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<20>3_253 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<20>4_254 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<19>1_255 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<19>2_256 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<18>1_257 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<18>2_258 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<17>1_259 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<17>2_260 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<16>3_261 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<16>4_262 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<27>1_263 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<27>2_264 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<26>1_265 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<26>2_266 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<25>1_267 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<25>2_268 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<24>2_269 ;
  wire \deser/in_data[31]_in_data[7]_mux_23_OUT<24>3_270 ;
  wire N16;
  wire N17;
  wire N18;
  wire N19;
  wire N20;
  wire N21;
  wire N22;
  wire N23;
  wire N24;
  wire N25;
  wire N26;
  wire N27;
  wire N28;
  wire N29;
  wire N30;
  wire N31;
  wire N32;
  wire N33;
  wire N34;
  wire N35;
  wire N36;
  wire N37;
  wire N38;
  wire N39;
  wire N40;
  wire N41;
  wire N42;
  wire N43;
  wire N44;
  wire N45;
  wire N46;
  wire N47;
  wire \deser/done_glue_set_374 ;
  wire N81;
  wire N84;
  wire N87;
  wire N90;
  wire N92;
  wire N94;
  wire N96;
  wire N98;
  wire N122;
  wire N123;
  wire N125;
  wire N126;
  wire N128;
  wire N129;
  wire N131;
  wire N132;
  wire \FSM/n_state_7_rstpot_391 ;
  wire N134;
  wire N136;
  wire N144;
  wire N145;
  wire N147;
  wire N148;
  wire N150;
  wire N151;
  wire N153;
  wire N154;
  wire N156;
  wire N157;
  wire N158;
  wire N160;
  wire N161;
  wire N162;
  wire N164;
  wire N165;
  wire N166;
  wire N168;
  wire N169;
  wire N170;
  wire N172;
  wire N173;
  wire N174;
  wire N176;
  wire N177;
  wire N178;
  wire N180;
  wire N181;
  wire N182;
  wire N184;
  wire N185;
  wire N186;
  wire N188;
  wire N194;
  wire N195;
  wire N197;
  wire N198;
  wire N200;
  wire N201;
  wire N203;
  wire N204;
  wire N206;
  wire N207;
  wire N208;
  wire N210;
  wire N211;
  wire \FSM/s_state_2_rstpot_440 ;
  wire \FSM/s_state_3_rstpot ;
  wire N213;
  wire \FSM/err_type_rstpot_443 ;
  wire N216;
  wire N218;
  wire \FSM/mode_1_1_446 ;
  wire \counter/count_reg_0_1_447 ;
  wire \counter/count_reg_1_1_448 ;
  wire \counter/count_reg_1_2_449 ;
  wire \counter/count_reg_0_2_450 ;
  wire \FSM/mode_0_1_451 ;
  wire \counter/count_reg_1_3_452 ;
  wire \counter/count_reg_0_3_453 ;
  wire N219;
  wire N220;
  wire N221;
  wire N222;
  wire N223;
  wire N224;
  wire N225;
  wire N226;
  wire [15 : 8] \serial/out_data ;
  wire [0 : 0] num_clks;
  wire [5 : 0] \FSM/opcode_out ;
  wire [1 : 0] \FSM/mode ;
  wire [31 : 0] \deser/output_reg ;
  wire [1 : 0] \counter/count_reg ;
  wire [15 : 0] out_data_ext;
  wire [1 : 0] Result;
  wire [5 : 2] \FSM/state ;
  GND   XST_GND (
    .G(data_31_IOBUF_108)
  );
  VCC   XST_VCC (
    .P(N1)
  );
  FDR   \counter/count_reg_0  (
    .C(t_clk_inv),
    .D(Result[0]),
    .R(count_rst),
    .Q(\counter/count_reg [0])
  );
  FDR   \counter/count_reg_1  (
    .C(t_clk_inv),
    .D(Result[1]),
    .R(count_rst),
    .Q(\counter/count_reg [1])
  );
  LD_1 #(
    .INIT ( 1'b0 ))
  \serial/out_data_8  (
    .D(gfau_data_8_IBUF_7),
    .G(\serial/GND_6_o_bus_size[1]_equal_1_o ),
    .Q(\serial/out_data [8])
  );
  LD_1 #(
    .INIT ( 1'b0 ))
  \serial/out_data_9  (
    .D(gfau_data_9_IBUF_6),
    .G(\serial/GND_6_o_bus_size[1]_equal_1_o ),
    .Q(\serial/out_data [9])
  );
  LD_1 #(
    .INIT ( 1'b0 ))
  \serial/out_data_10  (
    .D(gfau_data_10_IBUF_5),
    .G(\serial/GND_6_o_bus_size[1]_equal_1_o ),
    .Q(\serial/out_data [10])
  );
  LD_1 #(
    .INIT ( 1'b0 ))
  \serial/out_data_11  (
    .D(gfau_data_11_IBUF_4),
    .G(\serial/GND_6_o_bus_size[1]_equal_1_o ),
    .Q(\serial/out_data [11])
  );
  LD_1 #(
    .INIT ( 1'b0 ))
  \serial/out_data_12  (
    .D(gfau_data_12_IBUF_3),
    .G(\serial/GND_6_o_bus_size[1]_equal_1_o ),
    .Q(\serial/out_data [12])
  );
  LD_1 #(
    .INIT ( 1'b0 ))
  \serial/out_data_13  (
    .D(gfau_data_13_IBUF_2),
    .G(\serial/GND_6_o_bus_size[1]_equal_1_o ),
    .Q(\serial/out_data [13])
  );
  LD_1 #(
    .INIT ( 1'b0 ))
  \serial/out_data_14  (
    .D(gfau_data_14_IBUF_1),
    .G(\serial/GND_6_o_bus_size[1]_equal_1_o ),
    .Q(\serial/out_data [14])
  );
  LD_1 #(
    .INIT ( 1'b0 ))
  \serial/out_data_15  (
    .D(gfau_data_15_IBUF_0),
    .G(\serial/GND_6_o_bus_size[1]_equal_1_o ),
    .Q(\serial/out_data [15])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \FSM/deserial_ne  (
    .C(clk_BUFGP_24),
    .CE(\FSM/_n0395_inv1 ),
    .D(\FSM/deserial_ne_INV_32_o ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/deserial_ne_187 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \FSM/serr  (
    .C(clk_BUFGP_24),
    .CE(\FSM/_n0291_inv2 ),
    .D(\FSM/serr_INV_40_o ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/serr_191 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \FSM/s_state_4  (
    .C(clk_BUFGP_24),
    .CE(\FSM/_n0356_inv ),
    .D(\FSM/s_state[4]_INV_37_o ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/s_state_4_192 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \FSM/s_state_5  (
    .C(clk_BUFGP_24),
    .CE(\FSM/_n0352_inv ),
    .D(\FSM/s_state[5]_INV_47_o ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/s_state_5_193 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \FSM/n_state_3  (
    .C(clk_BUFGP_24),
    .CE(\FSM/_n0369_inv ),
    .D(\FSM/n_state[3]_INV_41_o ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/n_state_3_190 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \FSM/deserial_se  (
    .C(t_clk_BUFGP_21),
    .CE(\FSM/_n0268_inv ),
    .D(\FSM/deserial_se_INV_8_o ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/deserial_se_199 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \FSM/nerr  (
    .C(t_clk_BUFGP_21),
    .CE(\FSM/_n0317_inv ),
    .D(\FSM/nerr_INV_18_o ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/nerr_197 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \FSM/n_state_1  (
    .C(clk_BUFGP_24),
    .D(\FSM/GND_4_o_n_state[1]_Select_55_o ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/n_state_1_194 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \FSM/ngen_INT  (
    .C(t_clk_BUFGP_21),
    .CE(\FSM/_n0321_inv ),
    .D(\FSM/ngen_INT_INV_15_o ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/ngen_INT_196 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \FSM/nop_INT  (
    .C(t_clk_BUFGP_21),
    .CE(\FSM/_n0302_inv ),
    .D(\FSM/nop_INT_INV_12_o ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/nop_INT_195 )
  );
  FDE   \FSM/mode_1  (
    .C(t_clk_BUFGP_21),
    .CE(\FSM/_n0261_inv ),
    .D(N45),
    .Q(\FSM/mode [1])
  );
  FDE   \FSM/mode_0  (
    .C(t_clk_BUFGP_21),
    .CE(\FSM/_n0261_inv ),
    .D(N46),
    .Q(\FSM/mode [0])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \FSM/poly_gen  (
    .C(t_clk_BUFGP_21),
    .CE(\FSM/_n0271_inv ),
    .D(\FSM/GND_4_o_opcode_in[5]_equal_3_o ),
    .Q(\FSM/poly_gen_53 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \FSM/wr_rd  (
    .C(t_clk_BUFGP_21),
    .D(\FSM/GND_4_o_wr_rd_Select_28_o ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/wr_rd_54 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \FSM/s_state_0  (
    .C(t_clk_BUFGP_21),
    .D(\FSM/GND_4_o_s_state[0]_Select_21_o ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/s_state_0_200 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \FSM/serial_e  (
    .C(t_clk_BUFGP_21),
    .D(\FSM/GND_4_o_serial_e_Select_31_o ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/serial_e_51 )
  );
  FDE   \FSM/opcode_out_5  (
    .C(t_clk_BUFGP_21),
    .CE(\FSM/_n0271_inv ),
    .D(N42),
    .Q(\FSM/opcode_out [5])
  );
  FDE   \FSM/opcode_out_4  (
    .C(t_clk_BUFGP_21),
    .CE(\FSM/_n0271_inv ),
    .D(N43),
    .Q(\FSM/opcode_out [4])
  );
  FDE   \FSM/opcode_out_3  (
    .C(t_clk_BUFGP_21),
    .CE(\FSM/_n0271_inv ),
    .D(N44),
    .Q(\FSM/opcode_out [3])
  );
  FDE   \FSM/opcode_out_2  (
    .C(t_clk_BUFGP_21),
    .CE(\FSM/_n0271_inv ),
    .D(N45),
    .Q(\FSM/opcode_out [2])
  );
  FDE   \FSM/opcode_out_1  (
    .C(t_clk_BUFGP_21),
    .CE(\FSM/_n0271_inv ),
    .D(N46),
    .Q(\FSM/opcode_out [1])
  );
  FDE   \FSM/opcode_out_0  (
    .C(t_clk_BUFGP_21),
    .CE(\FSM/_n0271_inv ),
    .D(N47),
    .Q(\FSM/opcode_out [0])
  );
  FDSE   \deser/count_rst  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0259_inv ),
    .D(\deser/_n0219 ),
    .S(\deser/_n0238 ),
    .Q(\deser/count_rst_88 )
  );
  FDE   \deser/output_reg_31  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<31> ),
    .Q(\deser/output_reg [31])
  );
  FDE   \deser/output_reg_30  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<30> ),
    .Q(\deser/output_reg [30])
  );
  FDE   \deser/output_reg_29  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<29> ),
    .Q(\deser/output_reg [29])
  );
  FDE   \deser/output_reg_28  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<28> ),
    .Q(\deser/output_reg [28])
  );
  FDE   \deser/output_reg_27  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<27> ),
    .Q(\deser/output_reg [27])
  );
  FDE   \deser/output_reg_26  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<26> ),
    .Q(\deser/output_reg [26])
  );
  FDE   \deser/output_reg_25  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<25> ),
    .Q(\deser/output_reg [25])
  );
  FDE   \deser/output_reg_24  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<24> ),
    .Q(\deser/output_reg [24])
  );
  FDE   \deser/output_reg_23  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<23> ),
    .Q(\deser/output_reg [23])
  );
  FDE   \deser/output_reg_22  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<22> ),
    .Q(\deser/output_reg [22])
  );
  FDE   \deser/output_reg_21  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<21> ),
    .Q(\deser/output_reg [21])
  );
  FDE   \deser/output_reg_20  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<20> ),
    .Q(\deser/output_reg [20])
  );
  FDE   \deser/output_reg_19  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<19> ),
    .Q(\deser/output_reg [19])
  );
  FDE   \deser/output_reg_18  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<18> ),
    .Q(\deser/output_reg [18])
  );
  FDE   \deser/output_reg_17  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<17> ),
    .Q(\deser/output_reg [17])
  );
  FDE   \deser/output_reg_16  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<16> ),
    .Q(\deser/output_reg [16])
  );
  FDE   \deser/output_reg_15  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<15> ),
    .Q(\deser/output_reg [15])
  );
  FDE   \deser/output_reg_14  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<14> ),
    .Q(\deser/output_reg [14])
  );
  FDE   \deser/output_reg_13  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<13> ),
    .Q(\deser/output_reg [13])
  );
  FDE   \deser/output_reg_12  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<12> ),
    .Q(\deser/output_reg [12])
  );
  FDE   \deser/output_reg_11  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<11>_216 ),
    .Q(\deser/output_reg [11])
  );
  FDE   \deser/output_reg_10  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<10>_215 ),
    .Q(\deser/output_reg [10])
  );
  FDE   \deser/output_reg_9  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<9>_214 ),
    .Q(\deser/output_reg [9])
  );
  FDE   \deser/output_reg_8  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<8>_213 ),
    .Q(\deser/output_reg [8])
  );
  FDE   \deser/output_reg_7  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<7> ),
    .Q(\deser/output_reg [7])
  );
  FDE   \deser/output_reg_6  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<6> ),
    .Q(\deser/output_reg [6])
  );
  FDE   \deser/output_reg_5  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<5> ),
    .Q(\deser/output_reg [5])
  );
  FDE   \deser/output_reg_4  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<4> ),
    .Q(\deser/output_reg [4])
  );
  FDE   \deser/output_reg_3  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<3> ),
    .Q(\deser/output_reg [3])
  );
  FDE   \deser/output_reg_2  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<2> ),
    .Q(\deser/output_reg [2])
  );
  FDE   \deser/output_reg_1  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<1> ),
    .Q(\deser/output_reg [1])
  );
  FDE   \deser/output_reg_0  (
    .C(t_clk_BUFGP_21),
    .CE(\deser/_n0250_inv ),
    .D(\deser/in_data[31]_in_data[7]_mux_23_OUT<0> ),
    .Q(\deser/output_reg [0])
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  count_rst1 (
    .I0(\FSM/serial_e_51 ),
    .I1(\deser/count_rst_88 ),
    .O(count_rst)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \counter/Mcount_count_reg_xor<1>11  (
    .I0(\counter/count_reg [1]),
    .I1(\counter/count_reg [0]),
    .O(Result[1])
  );
  LUT6 #(
    .INIT ( 64'hFFEAEAEA55404040 ))
  Mmux_out_data_ext11 (
    .I0(err_OBUF_48),
    .I1(gfau_data_0_IBUF_15),
    .I2(\serial/mux13 ),
    .I3(gfau_data_8_IBUF_7),
    .I4(\serial/mux14 ),
    .I5(\FSM/err_type_50 ),
    .O(out_data_ext[0])
  );
  LUT6 #(
    .INIT ( 64'h00000000000000E0 ))
  \num_clks<1>1  (
    .I0(\num_clks<0>_bdd5 ),
    .I1(input_size_2_IBUF_17),
    .I2(input_size_3_IBUF_16),
    .I3(\FSM/poly_gen_53 ),
    .I4(\FSM/mode [1]),
    .I5(\FSM/mode [0]),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 )
  );
  LUT6 #(
    .INIT ( 64'h000000E00000E098 ))
  \num_clks<0>1  (
    .I0(\num_clks<0>_bdd5 ),
    .I1(input_size_2_IBUF_17),
    .I2(input_size_3_IBUF_16),
    .I3(\FSM/mode_0_1_451 ),
    .I4(\FSM/mode_1_1_446 ),
    .I5(\FSM/poly_gen_53 ),
    .O(num_clks[0])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \num_clks<0>31  (
    .I0(input_size_0_IBUF_19),
    .I1(input_size_1_IBUF_18),
    .O(\num_clks<0>_bdd5 )
  );
  LUT6 #(
    .INIT ( 64'h1110111011100000 ))
  \serial/mux141  (
    .I0(\FSM/mode [0]),
    .I1(\FSM/mode [1]),
    .I2(num_clks[0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(\counter/count_reg [0]),
    .I5(\counter/count_reg [1]),
    .O(\serial/mux14 )
  );
  LUT6 #(
    .INIT ( 64'hFFF1FFF1FFF1FFFF ))
  \serial/mux131  (
    .I0(\counter/count_reg [0]),
    .I1(\counter/count_reg [1]),
    .I2(\FSM/mode [0]),
    .I3(\FSM/mode [1]),
    .I4(num_clks[0]),
    .I5(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .O(\serial/mux13 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFEEEF ))
  \serial/Mmux_done11  (
    .I0(\FSM/mode [1]),
    .I1(\FSM/mode [0]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I3(num_clks[0]),
    .I4(\counter/count_reg_1_1_448 ),
    .I5(\counter/count_reg_0_1_447 ),
    .O(serial_d)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  \serial/GND_6_o_bus_size[1]_equal_1_o<1>1  (
    .I0(\FSM/mode [1]),
    .I1(\FSM/mode [0]),
    .O(\serial/GND_6_o_bus_size[1]_equal_1_o )
  );
  LUT6 #(
    .INIT ( 64'h0000FE0000000000 ))
  \FSM/_n0369_inv1  (
    .I0(z_err_IBUF_27),
    .I1(op_done_IBUF_25),
    .I2(oob_err_IBUF_28),
    .I3(\FSM/state [3]),
    .I4(\FSM/state [2]),
    .I5(\FSM/GND_4_o_state[7]_equal_43_o<7>1_152 ),
    .O(\FSM/_n0369_inv )
  );
  LUT6 #(
    .INIT ( 64'h00000E0000000000 ))
  \FSM/_n0291_inv21  (
    .I0(z_err_IBUF_27),
    .I1(oob_err_IBUF_28),
    .I2(op_done_IBUF_25),
    .I3(\FSM/state [3]),
    .I4(\FSM/state [2]),
    .I5(\FSM/GND_4_o_state[7]_equal_43_o<7>1_152 ),
    .O(\FSM/_n0291_inv2 )
  );
  LUT6 #(
    .INIT ( 64'h0900000000000000 ))
  \FSM/GND_4_o_state[7]_equal_9_o<7>1  (
    .I0(\FSM/n_state_7_198 ),
    .I1(\FSM/nop_INT_195 ),
    .I2(\FSM/state [5]),
    .I3(\FSM/GND_4_o_state[7]_equal_10_o<7>1 ),
    .I4(\FSM/state [4]),
    .I5(\FSM/GND_4_o_n_state[1]_Select_55_o<1>12 ),
    .O(\FSM/GND_4_o_state[7]_equal_9_o )
  );
  LUT6 #(
    .INIT ( 64'h0000900000000000 ))
  \FSM/GND_4_o_state[7]_equal_10_o<7>2  (
    .I0(\FSM/n_state_7_198 ),
    .I1(\FSM/nop_INT_195 ),
    .I2(\FSM/state [5]),
    .I3(\FSM/GND_4_o_state[7]_equal_10_o<7>1 ),
    .I4(\FSM/state [4]),
    .I5(\FSM/GND_4_o_n_state[1]_Select_55_o<1>12 ),
    .O(\FSM/GND_4_o_state[7]_equal_10_o )
  );
  LUT6 #(
    .INIT ( 64'h0000000800080000 ))
  \FSM/PWR_4_o_state[7]_equal_12_o<7>1  (
    .I0(\FSM/GND_4_o_n_state[1]_Select_55_o<1>12 ),
    .I1(\FSM/GND_4_o_state[7]_equal_10_o<7>1 ),
    .I2(\FSM/state [4]),
    .I3(\FSM/state [5]),
    .I4(\FSM/n_state_7_198 ),
    .I5(\FSM/nop_INT_195 ),
    .O(\FSM/PWR_4_o_state[7]_equal_12_o )
  );
  LUT6 #(
    .INIT ( 64'h0000000000000900 ))
  \FSM/GND_4_o_state[7]_equal_11_o<7>1  (
    .I0(\FSM/n_state_7_198 ),
    .I1(\FSM/nop_INT_195 ),
    .I2(\FSM/state [5]),
    .I3(\FSM/GND_4_o_state[7]_equal_10_o<7>1 ),
    .I4(\FSM/state [4]),
    .I5(\FSM/GND_4_o_n_state[1]_Select_55_o<1>12 ),
    .O(\FSM/GND_4_o_state[7]_equal_11_o )
  );
  LUT6 #(
    .INIT ( 64'h0000BF0000000000 ))
  \FSM/_n0271_inv1  (
    .I0(N44),
    .I1(N42),
    .I2(N43),
    .I3(Start_IBUF_20),
    .I4(g_rst_IBUF_22),
    .I5(\FSM/GND_4_o_state[7]_equal_8_o ),
    .O(\FSM/_n0271_inv )
  );
  LUT5 #(
    .INIT ( 32'hBF000000 ))
  \FSM/_n0268_inv1  (
    .I0(N44),
    .I1(N42),
    .I2(N43),
    .I3(Start_IBUF_20),
    .I4(\FSM/GND_4_o_state[7]_equal_8_o ),
    .O(\FSM/_n0268_inv )
  );
  LUT6 #(
    .INIT ( 64'h0000200000000000 ))
  \FSM/_n0261_inv1  (
    .I0(Start_IBUF_20),
    .I1(g_rst_IBUF_22),
    .I2(N42),
    .I3(N43),
    .I4(N44),
    .I5(\FSM/GND_4_o_state[7]_equal_8_o ),
    .O(\FSM/_n0261_inv )
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \FSM/GND_4_o_n_state[1]_Select_55_o<1>121  (
    .I0(\FSM/serr_191 ),
    .I1(\FSM/nerr_197 ),
    .O(\FSM/GND_4_o_n_state[1]_Select_55_o<1>12 )
  );
  LUT6 #(
    .INIT ( 64'h6FF6FFFFFFFF6FF6 ))
  \FSM/INT1  (
    .I0(\FSM/nop_INT_195 ),
    .I1(\FSM/s_state_4_192 ),
    .I2(\FSM/serr_191 ),
    .I3(\FSM/nerr_197 ),
    .I4(\FSM/s_state_5_193 ),
    .I5(\FSM/ngen_INT_196 ),
    .O(INT_OBUF_49)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \FSM/ready1  (
    .I0(\FSM/s_state_0_200 ),
    .I1(\FSM/deserial_se_199 ),
    .O(ready_sig_OBUF_47)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \FSM/deserial_r1  (
    .I0(\FSM/deserial_se_199 ),
    .I1(\FSM/deserial_ne_187 ),
    .O(deserial_r)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \FSM/Mxor_state<7:1>_1_xo<0>1  (
    .I0(\FSM/s_state_5_193 ),
    .I1(\FSM/s_state_2_188 ),
    .O(\FSM/state [2])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \FSM/Mxor_state<7:1>_2_xo<0>1  (
    .I0(\FSM/n_state_3_190 ),
    .I1(\FSM/s_state_3_189 ),
    .O(\FSM/state [3])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \FSM/Mxor_state<7:1>_3_xo<0>1  (
    .I0(\FSM/s_state_4_192 ),
    .I1(\FSM/nop_INT_195 ),
    .O(\FSM/state [4])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \FSM/Mxor_state<7:1>_4_xo<0>1  (
    .I0(\FSM/s_state_5_193 ),
    .I1(\FSM/ngen_INT_196 ),
    .O(\FSM/state [5])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \FSM/Mxor_err_xo<0>1  (
    .I0(\FSM/nerr_197 ),
    .I1(\FSM/serr_191 ),
    .O(err_OBUF_48)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \FSM/_n0321_inv1  (
    .I0(INTA_IBUF_23),
    .I1(\FSM/GND_4_o_state[7]_equal_10_o ),
    .O(\FSM/_n0321_inv )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \FSM/_n0317_inv1  (
    .I0(INTA_IBUF_23),
    .I1(\FSM/GND_4_o_state[7]_equal_11_o ),
    .O(\FSM/_n0317_inv )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \FSM/_n0302_inv1  (
    .I0(INTA_IBUF_23),
    .I1(\FSM/GND_4_o_state[7]_equal_9_o ),
    .O(\FSM/_n0302_inv )
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  \FSM/GND_4_o_opcode_in[5]_equal_3_o<5>1  (
    .I0(N42),
    .I1(N43),
    .I2(N44),
    .O(\FSM/GND_4_o_opcode_in[5]_equal_3_o )
  );
  LUT6 #(
    .INIT ( 64'hEEEEEEEEE8EAEEFF ))
  \deser/Mmux__n021911  (
    .I0(\counter/count_reg [1]),
    .I1(\counter/count_reg [0]),
    .I2(\deser/count_rst_88 ),
    .I3(num_clks[0]),
    .I4(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I5(\FSM/mode [0]),
    .O(\deser/_n0219 )
  );
  LUT4 #(
    .INIT ( 16'h9FF9 ))
  \FSM/GND_4_o_state[7]_equal_43_o<7>1_SW0  (
    .I0(\FSM/deserial_se_199 ),
    .I1(\FSM/n_state_1_194 ),
    .I2(\FSM/nop_INT_195 ),
    .I3(\FSM/n_state_7_198 ),
    .O(N0)
  );
  LUT6 #(
    .INIT ( 64'h0000001000000000 ))
  \FSM/GND_4_o_state[7]_equal_8_o<7>  (
    .I0(\FSM/state [3]),
    .I1(\FSM/state [5]),
    .I2(ready_sig_OBUF_47),
    .I3(N2),
    .I4(\FSM/state [4]),
    .I5(\FSM/GND_4_o_n_state[1]_Select_55_o<1>12 ),
    .O(\FSM/GND_4_o_state[7]_equal_8_o )
  );
  LUT3 #(
    .INIT ( 8'hFE ))
  \FSM/GND_4_o_n_state[1]_Select_55_o<1>_SW0  (
    .I0(z_err_IBUF_27),
    .I1(op_done_IBUF_25),
    .I2(oob_err_IBUF_28),
    .O(N4)
  );
  LUT6 #(
    .INIT ( 64'h96F0B4F0D2F0F0F0 ))
  \FSM/GND_4_o_n_state[1]_Select_55_o<1>  (
    .I0(\FSM/state [3]),
    .I1(\FSM/state [2]),
    .I2(\FSM/n_state_1_194 ),
    .I3(\FSM/GND_4_o_state[7]_equal_43_o<7>1_152 ),
    .I4(N4),
    .I5(gen_rdy_IBUF_26),
    .O(\FSM/GND_4_o_n_state[1]_Select_55_o )
  );
  LUT6 #(
    .INIT ( 64'hFFEC7360ECECEC60 ))
  \FSM/GND_4_o_s_state[0]_Select_21_o3  (
    .I0(INTA_IBUF_23),
    .I1(\FSM/s_state_0_200 ),
    .I2(\FSM/GND_4_o_s_state[0]_Select_21_o2_241 ),
    .I3(\FSM/PWR_4_o_state[7]_equal_12_o ),
    .I4(\FSM/GND_4_o_s_state[0]_Select_21_o1_240 ),
    .I5(serial_d),
    .O(\FSM/GND_4_o_s_state[0]_Select_21_o )
  );
  LUT6 #(
    .INIT ( 64'hC0A0C0C000A0C0C0 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<23>2  (
    .I0(N44),
    .I1(\deser/output_reg [23]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I3(num_clks[0]),
    .I4(\counter/count_reg_1_2_449 ),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<23>2_242 )
  );
  LUT6 #(
    .INIT ( 64'hA0AAC0CC0000C0CC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<23>3  (
    .I0(N40),
    .I1(\deser/output_reg [23]),
    .I2(\FSM/mode [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(num_clks[0]),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<23>3_243 )
  );
  LUT5 #(
    .INIT ( 32'h0000A0CC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<23>4  (
    .I0(N40),
    .I1(\deser/output_reg [23]),
    .I2(num_clks[0]),
    .I3(\counter/count_reg_1_1_448 ),
    .I4(\counter/count_reg_0_1_447 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<23>4_244 )
  );
  LUT5 #(
    .INIT ( 32'hBBBBBBB8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<23>5  (
    .I0(N24),
    .I1(\FSM/mode [1]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<23>3_243 ),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<23>4_244 ),
    .I4(\deser/in_data[31]_in_data[7]_mux_23_OUT<23>2_242 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<23> )
  );
  LUT6 #(
    .INIT ( 64'hC0A0C0C000A0C0C0 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<22>2  (
    .I0(N45),
    .I1(\deser/output_reg [22]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I3(num_clks[0]),
    .I4(\counter/count_reg_1_2_449 ),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<22>2_245 )
  );
  LUT6 #(
    .INIT ( 64'hA0AAC0CC0000C0CC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<22>3  (
    .I0(N41),
    .I1(\deser/output_reg [22]),
    .I2(\FSM/mode [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(num_clks[0]),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<22>3_246 )
  );
  LUT5 #(
    .INIT ( 32'h0000A0CC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<22>4  (
    .I0(N41),
    .I1(\deser/output_reg [22]),
    .I2(num_clks[0]),
    .I3(\counter/count_reg_1_1_448 ),
    .I4(\counter/count_reg_0_1_447 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<22>4_247 )
  );
  LUT5 #(
    .INIT ( 32'hBBBBBBB8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<22>5  (
    .I0(N25),
    .I1(\FSM/mode [1]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<22>3_246 ),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<22>4_247 ),
    .I4(\deser/in_data[31]_in_data[7]_mux_23_OUT<22>2_245 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<22> )
  );
  LUT6 #(
    .INIT ( 64'hC0A0C0C000A0C0C0 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<21>2  (
    .I0(N46),
    .I1(\deser/output_reg [21]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I3(num_clks[0]),
    .I4(\counter/count_reg_1_2_449 ),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<21>2_248 )
  );
  LUT6 #(
    .INIT ( 64'hA0AAC0CC0000C0CC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<21>3  (
    .I0(N42),
    .I1(\deser/output_reg [21]),
    .I2(\FSM/mode [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(num_clks[0]),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<21>3_249 )
  );
  LUT5 #(
    .INIT ( 32'h0000A0CC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<21>4  (
    .I0(N42),
    .I1(\deser/output_reg [21]),
    .I2(num_clks[0]),
    .I3(\counter/count_reg_1_1_448 ),
    .I4(\counter/count_reg_0_1_447 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<21>4_250 )
  );
  LUT5 #(
    .INIT ( 32'hBBBBBBB8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<21>5  (
    .I0(N26),
    .I1(\FSM/mode [1]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<21>3_249 ),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<21>4_250 ),
    .I4(\deser/in_data[31]_in_data[7]_mux_23_OUT<21>2_248 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<21> )
  );
  LUT6 #(
    .INIT ( 64'hC0A0C0C000A0C0C0 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<20>2  (
    .I0(N47),
    .I1(\deser/output_reg [20]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I3(num_clks[0]),
    .I4(\counter/count_reg_1_2_449 ),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>2_252 )
  );
  LUT6 #(
    .INIT ( 64'hA0AAC0CC0000C0CC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<20>3  (
    .I0(N43),
    .I1(\deser/output_reg [20]),
    .I2(\FSM/mode [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(num_clks[0]),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>3_253 )
  );
  LUT5 #(
    .INIT ( 32'h0000A0CC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<20>4  (
    .I0(N43),
    .I1(\deser/output_reg [20]),
    .I2(num_clks[0]),
    .I3(\counter/count_reg_1_1_448 ),
    .I4(\counter/count_reg_0_1_447 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>4_254 )
  );
  LUT5 #(
    .INIT ( 32'hBBBBBBB8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<20>5  (
    .I0(N27),
    .I1(\FSM/mode [1]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>3_253 ),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>4_254 ),
    .I4(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>2_252 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<20> )
  );
  LUT6 #(
    .INIT ( 64'hACACAACCAAAAAACC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<19>1  (
    .I0(N44),
    .I1(\deser/output_reg [19]),
    .I2(\FSM/mode [0]),
    .I3(\counter/count_reg_1_3_452 ),
    .I4(\counter/count_reg_0_1_447 ),
    .I5(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<19>1_255 )
  );
  LUT6 #(
    .INIT ( 64'hCCCACACACCCACCCA ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<19>2  (
    .I0(N40),
    .I1(\deser/output_reg [19]),
    .I2(\FSM/mode [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(\counter/count_reg_1_2_449 ),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<19>2_256 )
  );
  LUT5 #(
    .INIT ( 32'hBBB88B88 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<19>3  (
    .I0(N28),
    .I1(\FSM/mode [1]),
    .I2(num_clks[0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<19>2_256 ),
    .I4(\deser/in_data[31]_in_data[7]_mux_23_OUT<19>1_255 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<19> )
  );
  LUT6 #(
    .INIT ( 64'hACACAACCAAAAAACC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<18>1  (
    .I0(N45),
    .I1(\deser/output_reg [18]),
    .I2(\FSM/mode [0]),
    .I3(\counter/count_reg_1_3_452 ),
    .I4(\counter/count_reg_0_1_447 ),
    .I5(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<18>1_257 )
  );
  LUT6 #(
    .INIT ( 64'hCCCACACACCCACCCA ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<18>2  (
    .I0(N41),
    .I1(\deser/output_reg [18]),
    .I2(\FSM/mode [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(\counter/count_reg_1_2_449 ),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<18>2_258 )
  );
  LUT5 #(
    .INIT ( 32'hBBB88B88 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<18>3  (
    .I0(N29),
    .I1(\FSM/mode [1]),
    .I2(num_clks[0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<18>2_258 ),
    .I4(\deser/in_data[31]_in_data[7]_mux_23_OUT<18>1_257 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<18> )
  );
  LUT6 #(
    .INIT ( 64'hACACAACCAAAAAACC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<17>1  (
    .I0(N46),
    .I1(\deser/output_reg [17]),
    .I2(\FSM/mode [0]),
    .I3(\counter/count_reg_1_3_452 ),
    .I4(\counter/count_reg_0_1_447 ),
    .I5(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<17>1_259 )
  );
  LUT6 #(
    .INIT ( 64'hCCCACACACCCACCCA ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<17>2  (
    .I0(N42),
    .I1(\deser/output_reg [17]),
    .I2(\FSM/mode [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(\counter/count_reg_1_2_449 ),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<17>2_260 )
  );
  LUT5 #(
    .INIT ( 32'hBBB88B88 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<17>3  (
    .I0(N30),
    .I1(\FSM/mode [1]),
    .I2(num_clks[0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<17>2_260 ),
    .I4(\deser/in_data[31]_in_data[7]_mux_23_OUT<17>1_259 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<17> )
  );
  LUT6 #(
    .INIT ( 64'hACAAACCCAAAAAACC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<16>4  (
    .I0(N47),
    .I1(\deser/output_reg [16]),
    .I2(\FSM/mode [0]),
    .I3(\counter/count_reg_0_3_453 ),
    .I4(\counter/count_reg_1_3_452 ),
    .I5(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<16>4_262 )
  );
  LUT5 #(
    .INIT ( 32'hBBBBB888 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<16>5  (
    .I0(N31),
    .I1(\FSM/mode [1]),
    .I2(num_clks[0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<16>4_262 ),
    .I4(\deser/in_data[31]_in_data[7]_mux_23_OUT<16>3_261 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<16> )
  );
  LUT4 #(
    .INIT ( 16'hBBB8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<27>3  (
    .I0(N20),
    .I1(\FSM/mode [1]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<27>2_264 ),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<27>1_263 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<27> )
  );
  LUT4 #(
    .INIT ( 16'hBBB8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<26>3  (
    .I0(N21),
    .I1(\FSM/mode [1]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<26>2_266 ),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<26>1_265 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<26> )
  );
  LUT4 #(
    .INIT ( 16'hBBB8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<25>3  (
    .I0(N22),
    .I1(\FSM/mode [1]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<25>2_268 ),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<25>1_267 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<25> )
  );
  LUT4 #(
    .INIT ( 16'hBBB8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<24>3  (
    .I0(N23),
    .I1(\FSM/mode [1]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<24>3_270 ),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<24>2_269 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<24> )
  );
  IBUF   gfau_data_15_IBUF (
    .I(gfau_data[15]),
    .O(gfau_data_15_IBUF_0)
  );
  IBUF   gfau_data_14_IBUF (
    .I(gfau_data[14]),
    .O(gfau_data_14_IBUF_1)
  );
  IBUF   gfau_data_13_IBUF (
    .I(gfau_data[13]),
    .O(gfau_data_13_IBUF_2)
  );
  IBUF   gfau_data_12_IBUF (
    .I(gfau_data[12]),
    .O(gfau_data_12_IBUF_3)
  );
  IBUF   gfau_data_11_IBUF (
    .I(gfau_data[11]),
    .O(gfau_data_11_IBUF_4)
  );
  IBUF   gfau_data_10_IBUF (
    .I(gfau_data[10]),
    .O(gfau_data_10_IBUF_5)
  );
  IBUF   gfau_data_9_IBUF (
    .I(gfau_data[9]),
    .O(gfau_data_9_IBUF_6)
  );
  IBUF   gfau_data_8_IBUF (
    .I(gfau_data[8]),
    .O(gfau_data_8_IBUF_7)
  );
  IBUF   gfau_data_7_IBUF (
    .I(gfau_data[7]),
    .O(gfau_data_7_IBUF_8)
  );
  IBUF   gfau_data_6_IBUF (
    .I(gfau_data[6]),
    .O(gfau_data_6_IBUF_9)
  );
  IBUF   gfau_data_5_IBUF (
    .I(gfau_data[5]),
    .O(gfau_data_5_IBUF_10)
  );
  IBUF   gfau_data_4_IBUF (
    .I(gfau_data[4]),
    .O(gfau_data_4_IBUF_11)
  );
  IBUF   gfau_data_3_IBUF (
    .I(gfau_data[3]),
    .O(gfau_data_3_IBUF_12)
  );
  IBUF   gfau_data_2_IBUF (
    .I(gfau_data[2]),
    .O(gfau_data_2_IBUF_13)
  );
  IBUF   gfau_data_1_IBUF (
    .I(gfau_data[1]),
    .O(gfau_data_1_IBUF_14)
  );
  IBUF   gfau_data_0_IBUF (
    .I(gfau_data[0]),
    .O(gfau_data_0_IBUF_15)
  );
  IBUF   input_size_3_IBUF (
    .I(input_size[3]),
    .O(input_size_3_IBUF_16)
  );
  IBUF   input_size_2_IBUF (
    .I(input_size[2]),
    .O(input_size_2_IBUF_17)
  );
  IBUF   input_size_1_IBUF (
    .I(input_size[1]),
    .O(input_size_1_IBUF_18)
  );
  IBUF   input_size_0_IBUF (
    .I(input_size[0]),
    .O(input_size_0_IBUF_19)
  );
  IBUF   Start_IBUF (
    .I(Start),
    .O(Start_IBUF_20)
  );
  IBUF   g_rst_IBUF (
    .I(g_rst),
    .O(g_rst_IBUF_22)
  );
  IBUF   INTA_IBUF (
    .I(INTA),
    .O(INTA_IBUF_23)
  );
  IBUF   op_done_IBUF (
    .I(op_done),
    .O(op_done_IBUF_25)
  );
  IBUF   gen_rdy_IBUF (
    .I(gen_rdy),
    .O(gen_rdy_IBUF_26)
  );
  IBUF   z_err_IBUF (
    .I(z_err),
    .O(z_err_IBUF_27)
  );
  IBUF   oob_err_IBUF (
    .I(oob_err),
    .O(oob_err_IBUF_28)
  );
  IOBUF   data_31_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N16),
    .IO(data[31])
  );
  IOBUF   data_30_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N17),
    .IO(data[30])
  );
  IOBUF   data_29_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N18),
    .IO(data[29])
  );
  IOBUF   data_28_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N19),
    .IO(data[28])
  );
  IOBUF   data_27_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N20),
    .IO(data[27])
  );
  IOBUF   data_26_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N21),
    .IO(data[26])
  );
  IOBUF   data_25_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N22),
    .IO(data[25])
  );
  IOBUF   data_24_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N23),
    .IO(data[24])
  );
  IOBUF   data_23_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N24),
    .IO(data[23])
  );
  IOBUF   data_22_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N25),
    .IO(data[22])
  );
  IOBUF   data_21_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N26),
    .IO(data[21])
  );
  IOBUF   data_20_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N27),
    .IO(data[20])
  );
  IOBUF   data_19_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N28),
    .IO(data[19])
  );
  IOBUF   data_18_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N29),
    .IO(data[18])
  );
  IOBUF   data_17_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N30),
    .IO(data[17])
  );
  IOBUF   data_16_IOBUF (
    .I(data_31_IOBUF_108),
    .T(\iop/oe_inv ),
    .O(N31),
    .IO(data[16])
  );
  IOBUF   data_15_IOBUF (
    .I(out_data_ext[15]),
    .T(\iop/oe_inv ),
    .O(N32),
    .IO(data[15])
  );
  IOBUF   data_14_IOBUF (
    .I(out_data_ext[14]),
    .T(\iop/oe_inv ),
    .O(N33),
    .IO(data[14])
  );
  IOBUF   data_13_IOBUF (
    .I(out_data_ext[13]),
    .T(\iop/oe_inv ),
    .O(N34),
    .IO(data[13])
  );
  IOBUF   data_12_IOBUF (
    .I(out_data_ext[12]),
    .T(\iop/oe_inv ),
    .O(N35),
    .IO(data[12])
  );
  IOBUF   data_11_IOBUF (
    .I(out_data_ext[11]),
    .T(\iop/oe_inv ),
    .O(N36),
    .IO(data[11])
  );
  IOBUF   data_10_IOBUF (
    .I(out_data_ext[10]),
    .T(\iop/oe_inv ),
    .O(N37),
    .IO(data[10])
  );
  IOBUF   data_9_IOBUF (
    .I(out_data_ext[9]),
    .T(\iop/oe_inv ),
    .O(N38),
    .IO(data[9])
  );
  IOBUF   data_8_IOBUF (
    .I(out_data_ext[8]),
    .T(\iop/oe_inv ),
    .O(N39),
    .IO(data[8])
  );
  IOBUF   data_7_IOBUF (
    .I(out_data_ext[7]),
    .T(\iop/oe_inv ),
    .O(N40),
    .IO(data[7])
  );
  IOBUF   data_6_IOBUF (
    .I(out_data_ext[6]),
    .T(\iop/oe_inv ),
    .O(N41),
    .IO(data[6])
  );
  IOBUF   data_5_IOBUF (
    .I(out_data_ext[5]),
    .T(\iop/oe_inv ),
    .O(N42),
    .IO(data[5])
  );
  IOBUF   data_4_IOBUF (
    .I(out_data_ext[4]),
    .T(\iop/oe_inv ),
    .O(N43),
    .IO(data[4])
  );
  IOBUF   data_3_IOBUF (
    .I(out_data_ext[3]),
    .T(\iop/oe_inv ),
    .O(N44),
    .IO(data[3])
  );
  IOBUF   data_2_IOBUF (
    .I(out_data_ext[2]),
    .T(\iop/oe_inv ),
    .O(N45),
    .IO(data[2])
  );
  IOBUF   data_1_IOBUF (
    .I(out_data_ext[1]),
    .T(\iop/oe_inv ),
    .O(N46),
    .IO(data[1])
  );
  IOBUF   data_0_IOBUF (
    .I(out_data_ext[0]),
    .T(\iop/oe_inv ),
    .O(N47),
    .IO(data[0])
  );
  OBUF   opcode_out_5_OBUF (
    .I(\FSM/opcode_out [5]),
    .O(opcode_out[5])
  );
  OBUF   opcode_out_4_OBUF (
    .I(\FSM/opcode_out [4]),
    .O(opcode_out[4])
  );
  OBUF   opcode_out_3_OBUF (
    .I(\FSM/opcode_out [3]),
    .O(opcode_out[3])
  );
  OBUF   opcode_out_2_OBUF (
    .I(\FSM/opcode_out [2]),
    .O(opcode_out[2])
  );
  OBUF   opcode_out_1_OBUF (
    .I(\FSM/opcode_out [1]),
    .O(opcode_out[1])
  );
  OBUF   opcode_out_0_OBUF (
    .I(\FSM/opcode_out [0]),
    .O(opcode_out[0])
  );
  OBUF   out_data_31_OBUF (
    .I(\deser/output_reg [31]),
    .O(out_data[31])
  );
  OBUF   out_data_30_OBUF (
    .I(\deser/output_reg [30]),
    .O(out_data[30])
  );
  OBUF   out_data_29_OBUF (
    .I(\deser/output_reg [29]),
    .O(out_data[29])
  );
  OBUF   out_data_28_OBUF (
    .I(\deser/output_reg [28]),
    .O(out_data[28])
  );
  OBUF   out_data_27_OBUF (
    .I(\deser/output_reg [27]),
    .O(out_data[27])
  );
  OBUF   out_data_26_OBUF (
    .I(\deser/output_reg [26]),
    .O(out_data[26])
  );
  OBUF   out_data_25_OBUF (
    .I(\deser/output_reg [25]),
    .O(out_data[25])
  );
  OBUF   out_data_24_OBUF (
    .I(\deser/output_reg [24]),
    .O(out_data[24])
  );
  OBUF   out_data_23_OBUF (
    .I(\deser/output_reg [23]),
    .O(out_data[23])
  );
  OBUF   out_data_22_OBUF (
    .I(\deser/output_reg [22]),
    .O(out_data[22])
  );
  OBUF   out_data_21_OBUF (
    .I(\deser/output_reg [21]),
    .O(out_data[21])
  );
  OBUF   out_data_20_OBUF (
    .I(\deser/output_reg [20]),
    .O(out_data[20])
  );
  OBUF   out_data_19_OBUF (
    .I(\deser/output_reg [19]),
    .O(out_data[19])
  );
  OBUF   out_data_18_OBUF (
    .I(\deser/output_reg [18]),
    .O(out_data[18])
  );
  OBUF   out_data_17_OBUF (
    .I(\deser/output_reg [17]),
    .O(out_data[17])
  );
  OBUF   out_data_16_OBUF (
    .I(\deser/output_reg [16]),
    .O(out_data[16])
  );
  OBUF   out_data_15_OBUF (
    .I(\deser/output_reg [15]),
    .O(out_data[15])
  );
  OBUF   out_data_14_OBUF (
    .I(\deser/output_reg [14]),
    .O(out_data[14])
  );
  OBUF   out_data_13_OBUF (
    .I(\deser/output_reg [13]),
    .O(out_data[13])
  );
  OBUF   out_data_12_OBUF (
    .I(\deser/output_reg [12]),
    .O(out_data[12])
  );
  OBUF   out_data_11_OBUF (
    .I(\deser/output_reg [11]),
    .O(out_data[11])
  );
  OBUF   out_data_10_OBUF (
    .I(\deser/output_reg [10]),
    .O(out_data[10])
  );
  OBUF   out_data_9_OBUF (
    .I(\deser/output_reg [9]),
    .O(out_data[9])
  );
  OBUF   out_data_8_OBUF (
    .I(\deser/output_reg [8]),
    .O(out_data[8])
  );
  OBUF   out_data_7_OBUF (
    .I(\deser/output_reg [7]),
    .O(out_data[7])
  );
  OBUF   out_data_6_OBUF (
    .I(\deser/output_reg [6]),
    .O(out_data[6])
  );
  OBUF   out_data_5_OBUF (
    .I(\deser/output_reg [5]),
    .O(out_data[5])
  );
  OBUF   out_data_4_OBUF (
    .I(\deser/output_reg [4]),
    .O(out_data[4])
  );
  OBUF   out_data_3_OBUF (
    .I(\deser/output_reg [3]),
    .O(out_data[3])
  );
  OBUF   out_data_2_OBUF (
    .I(\deser/output_reg [2]),
    .O(out_data[2])
  );
  OBUF   out_data_1_OBUF (
    .I(\deser/output_reg [1]),
    .O(out_data[1])
  );
  OBUF   out_data_0_OBUF (
    .I(\deser/output_reg [0]),
    .O(out_data[0])
  );
  OBUF   ready_sig_OBUF (
    .I(ready_sig_OBUF_47),
    .O(ready_sig)
  );
  OBUF   err_OBUF (
    .I(err_OBUF_48),
    .O(err)
  );
  OBUF   INT_OBUF (
    .I(INT_OBUF_49),
    .O(INT)
  );
  OBUF   rst_OBUF (
    .I(g_rst_IBUF_22),
    .O(rst)
  );
  FDR   \deser/done  (
    .C(t_clk_BUFGP_21),
    .D(\deser/done_glue_set_374 ),
    .R(deserial_r),
    .Q(\deser/done_87 )
  );
  LUT2 #(
    .INIT ( 4'hD ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<28>1_SW1  (
    .I0(\FSM/mode [1]),
    .I1(N19),
    .O(N81)
  );
  LUT2 #(
    .INIT ( 4'hD ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<29>1_SW1  (
    .I0(\FSM/mode [1]),
    .I1(N18),
    .O(N84)
  );
  LUT2 #(
    .INIT ( 4'hD ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<30>1_SW1  (
    .I0(\FSM/mode [1]),
    .I1(N17),
    .O(N87)
  );
  LUT2 #(
    .INIT ( 4'hD ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<31>1_SW1  (
    .I0(\FSM/mode [1]),
    .I1(N16),
    .O(N90)
  );
  LUT3 #(
    .INIT ( 8'h27 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<16>3_SW0  (
    .I0(\FSM/mode [0]),
    .I1(\deser/output_reg [16]),
    .I2(N43),
    .O(N92)
  );
  LUT6 #(
    .INIT ( 64'h00A3003300A300A3 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<16>3  (
    .I0(\deser/output_reg [16]),
    .I1(N92),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I3(num_clks[0]),
    .I4(\counter/count_reg_1_2_449 ),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<16>3_261 )
  );
  LUT6 #(
    .INIT ( 64'hFEFEFCFEFEFEFEFE ))
  \FSM/GND_4_o_wr_rd_Select_28_o2  (
    .I0(\FSM/wr_rd_54 ),
    .I1(\FSM/GND_4_o_state[7]_equal_11_o ),
    .I2(\FSM/GND_4_o_state[7]_equal_9_o ),
    .I3(\FSM/PWR_4_o_state[7]_equal_12_o ),
    .I4(N94),
    .I5(serial_d),
    .O(\FSM/GND_4_o_wr_rd_Select_28_o )
  );
  LUT6 #(
    .INIT ( 64'hECECE0ECECECECEC ))
  \FSM/GND_4_o_serial_e_Select_31_o1  (
    .I0(INTA_IBUF_23),
    .I1(\FSM/serial_e_51 ),
    .I2(\FSM/GND_4_o_state[7]_equal_9_o ),
    .I3(\FSM/PWR_4_o_state[7]_equal_12_o ),
    .I4(N96),
    .I5(serial_d),
    .O(\FSM/GND_4_o_serial_e_Select_31_o )
  );
  LUT6 #(
    .INIT ( 64'h0A0C0000000C0000 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<27>2  (
    .I0(N44),
    .I1(N40),
    .I2(N98),
    .I3(num_clks[0]),
    .I4(\counter/count_reg_1_1_448 ),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<27>2_264 )
  );
  LUT6 #(
    .INIT ( 64'h0A0C0000000C0000 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<26>2  (
    .I0(N45),
    .I1(N41),
    .I2(N98),
    .I3(num_clks[0]),
    .I4(\counter/count_reg_1_1_448 ),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<26>2_266 )
  );
  LUT6 #(
    .INIT ( 64'h0A0C0000000C0000 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<25>2  (
    .I0(N46),
    .I1(N42),
    .I2(N98),
    .I3(num_clks[0]),
    .I4(\counter/count_reg_1_1_448 ),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<25>2_268 )
  );
  LUT6 #(
    .INIT ( 64'h0A0C0000000C0000 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<24>2  (
    .I0(N47),
    .I1(N43),
    .I2(N98),
    .I3(num_clks[0]),
    .I4(\counter/count_reg_1_1_448 ),
    .I5(\counter/count_reg_0_2_450 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<24>3_270 )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \deser/Mmux__n02173411_SW0  (
    .I0(\FSM/mode [1]),
    .I1(\deser/output_reg [28]),
    .I2(N19),
    .O(N122)
  );
  LUT4 #(
    .INIT ( 16'hA0AC ))
  \deser/Mmux__n02173411_SW1  (
    .I0(N19),
    .I1(\deser/output_reg [28]),
    .I2(\FSM/mode [1]),
    .I3(num_clks[0]),
    .O(N123)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \deser/Mmux__n02173411_SW2  (
    .I0(\FSM/mode [1]),
    .I1(\deser/output_reg [29]),
    .I2(N18),
    .O(N125)
  );
  LUT4 #(
    .INIT ( 16'hA0AC ))
  \deser/Mmux__n02173411_SW3  (
    .I0(N18),
    .I1(\deser/output_reg [29]),
    .I2(\FSM/mode [1]),
    .I3(num_clks[0]),
    .O(N126)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \deser/Mmux__n02173411_SW4  (
    .I0(\FSM/mode [1]),
    .I1(\deser/output_reg [30]),
    .I2(N17),
    .O(N128)
  );
  LUT4 #(
    .INIT ( 16'hA0AC ))
  \deser/Mmux__n02173411_SW5  (
    .I0(N17),
    .I1(\deser/output_reg [30]),
    .I2(\FSM/mode [1]),
    .I3(num_clks[0]),
    .O(N129)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \deser/Mmux__n02173411_SW6  (
    .I0(\FSM/mode [1]),
    .I1(\deser/output_reg [31]),
    .I2(N16),
    .O(N131)
  );
  LUT4 #(
    .INIT ( 16'hA0AC ))
  \deser/Mmux__n02173411_SW7  (
    .I0(N16),
    .I1(\deser/output_reg [31]),
    .I2(\FSM/mode [1]),
    .I3(num_clks[0]),
    .O(N132)
  );
  FDR #(
    .INIT ( 1'b0 ))
  \FSM/n_state_7  (
    .C(t_clk_BUFGP_21),
    .D(\FSM/n_state_7_rstpot_391 ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/n_state_7_198 )
  );
  LUT2 #(
    .INIT ( 4'hE ))
  \serial/Mmux_done11_SW0  (
    .I0(\FSM/mode [1]),
    .I1(\FSM/mode [0]),
    .O(N134)
  );
  LUT3 #(
    .INIT ( 8'hDC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<3>1_SW0  (
    .I0(\FSM/mode [0]),
    .I1(num_clks[0]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .O(N136)
  );
  LUT6 #(
    .INIT ( 64'hACACACAAAAAAAAAA ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<3>1  (
    .I0(N44),
    .I1(\deser/output_reg [3]),
    .I2(\FSM/mode [1]),
    .I3(\counter/count_reg [1]),
    .I4(\counter/count_reg [0]),
    .I5(N136),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<3> )
  );
  LUT6 #(
    .INIT ( 64'hACACACAAAAAAAAAA ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<2>1  (
    .I0(N45),
    .I1(\deser/output_reg [2]),
    .I2(\FSM/mode [1]),
    .I3(\counter/count_reg [1]),
    .I4(\counter/count_reg [0]),
    .I5(N136),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<2> )
  );
  LUT6 #(
    .INIT ( 64'hACACACAAAAAAAAAA ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<1>1  (
    .I0(N46),
    .I1(\deser/output_reg [1]),
    .I2(\FSM/mode [1]),
    .I3(\counter/count_reg [1]),
    .I4(\counter/count_reg [0]),
    .I5(N136),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<1> )
  );
  LUT6 #(
    .INIT ( 64'hACACACAAAAAAAAAA ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<0>1  (
    .I0(N47),
    .I1(\deser/output_reg [0]),
    .I2(\FSM/mode [1]),
    .I3(\counter/count_reg [1]),
    .I4(\counter/count_reg [0]),
    .I5(N136),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<0> )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAAAAAAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<7>1_SW0  (
    .I0(N40),
    .I1(\deser/output_reg [7]),
    .I2(\FSM/mode [0]),
    .I3(\FSM/mode [1]),
    .I4(num_clks[0]),
    .I5(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .O(N144)
  );
  LUT5 #(
    .INIT ( 32'hACACAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<7>1_SW1  (
    .I0(N40),
    .I1(\deser/output_reg [7]),
    .I2(\FSM/mode [1]),
    .I3(\FSM/mode [0]),
    .I4(num_clks[0]),
    .O(N145)
  );
  LUT4 #(
    .INIT ( 16'hF1E0 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<7>1  (
    .I0(\counter/count_reg [1]),
    .I1(\counter/count_reg [0]),
    .I2(N145),
    .I3(N144),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<7> )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAAAAAAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<6>1_SW0  (
    .I0(N41),
    .I1(\deser/output_reg [6]),
    .I2(\FSM/mode [0]),
    .I3(\FSM/mode [1]),
    .I4(num_clks[0]),
    .I5(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .O(N147)
  );
  LUT5 #(
    .INIT ( 32'hACACAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<6>1_SW1  (
    .I0(N41),
    .I1(\deser/output_reg [6]),
    .I2(\FSM/mode [1]),
    .I3(\FSM/mode [0]),
    .I4(num_clks[0]),
    .O(N148)
  );
  LUT4 #(
    .INIT ( 16'hF1E0 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<6>1  (
    .I0(\counter/count_reg [1]),
    .I1(\counter/count_reg [0]),
    .I2(N148),
    .I3(N147),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<6> )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAAAAAAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<5>1_SW0  (
    .I0(N42),
    .I1(\deser/output_reg [5]),
    .I2(\FSM/mode [0]),
    .I3(\FSM/mode [1]),
    .I4(num_clks[0]),
    .I5(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .O(N150)
  );
  LUT5 #(
    .INIT ( 32'hACACAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<5>1_SW1  (
    .I0(N42),
    .I1(\deser/output_reg [5]),
    .I2(\FSM/mode [1]),
    .I3(\FSM/mode [0]),
    .I4(num_clks[0]),
    .O(N151)
  );
  LUT4 #(
    .INIT ( 16'hF1E0 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<5>1  (
    .I0(\counter/count_reg [1]),
    .I1(\counter/count_reg [0]),
    .I2(N151),
    .I3(N150),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<5> )
  );
  LUT6 #(
    .INIT ( 64'hAAAAAAAAAAAAAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<4>1_SW0  (
    .I0(N43),
    .I1(\deser/output_reg [4]),
    .I2(\FSM/mode [0]),
    .I3(\FSM/mode [1]),
    .I4(num_clks[0]),
    .I5(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .O(N153)
  );
  LUT5 #(
    .INIT ( 32'hACACAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<4>1_SW1  (
    .I0(N43),
    .I1(\deser/output_reg [4]),
    .I2(\FSM/mode [1]),
    .I3(\FSM/mode [0]),
    .I4(num_clks[0]),
    .O(N154)
  );
  LUT4 #(
    .INIT ( 16'hF1E0 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<4>1  (
    .I0(\counter/count_reg [1]),
    .I1(\counter/count_reg [0]),
    .I2(N154),
    .I3(N153),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<4> )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<15>3_SW0  (
    .I0(N32),
    .I1(\FSM/mode [1]),
    .I2(\FSM/mode [0]),
    .I3(\deser/output_reg [15]),
    .O(N156)
  );
  LUT5 #(
    .INIT ( 32'hACACAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<15>3_SW1  (
    .I0(N32),
    .I1(\deser/output_reg [15]),
    .I2(\FSM/mode [1]),
    .I3(\FSM/mode [0]),
    .I4(num_clks[0]),
    .O(N157)
  );
  LUT6 #(
    .INIT ( 64'hAAF0AACCAAAAAAF0 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<15>3_SW2  (
    .I0(N32),
    .I1(N40),
    .I2(\deser/output_reg [15]),
    .I3(\FSM/mode [1]),
    .I4(\FSM/mode [0]),
    .I5(num_clks[0]),
    .O(N158)
  );
  LUT6 #(
    .INIT ( 64'hFEFECEFE32020202 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<15>3  (
    .I0(N156),
    .I1(\counter/count_reg [1]),
    .I2(\counter/count_reg [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(N158),
    .I5(N157),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<15> )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<14>3_SW0  (
    .I0(N33),
    .I1(\FSM/mode [1]),
    .I2(\FSM/mode [0]),
    .I3(\deser/output_reg [14]),
    .O(N160)
  );
  LUT5 #(
    .INIT ( 32'hACACAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<14>3_SW1  (
    .I0(N33),
    .I1(\deser/output_reg [14]),
    .I2(\FSM/mode [1]),
    .I3(\FSM/mode [0]),
    .I4(num_clks[0]),
    .O(N161)
  );
  LUT6 #(
    .INIT ( 64'hAAF0AACCAAAAAAF0 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<14>3_SW2  (
    .I0(N33),
    .I1(N41),
    .I2(\deser/output_reg [14]),
    .I3(\FSM/mode [1]),
    .I4(\FSM/mode [0]),
    .I5(num_clks[0]),
    .O(N162)
  );
  LUT6 #(
    .INIT ( 64'hFEFECEFE32020202 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<14>3  (
    .I0(N160),
    .I1(\counter/count_reg [1]),
    .I2(\counter/count_reg [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(N162),
    .I5(N161),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<14> )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<13>3_SW0  (
    .I0(N34),
    .I1(\FSM/mode [1]),
    .I2(\FSM/mode [0]),
    .I3(\deser/output_reg [13]),
    .O(N164)
  );
  LUT5 #(
    .INIT ( 32'hACACAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<13>3_SW1  (
    .I0(N34),
    .I1(\deser/output_reg [13]),
    .I2(\FSM/mode [1]),
    .I3(\FSM/mode [0]),
    .I4(num_clks[0]),
    .O(N165)
  );
  LUT6 #(
    .INIT ( 64'hAAF0AACCAAAAAAF0 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<13>3_SW2  (
    .I0(N34),
    .I1(N42),
    .I2(\deser/output_reg [13]),
    .I3(\FSM/mode [1]),
    .I4(\FSM/mode [0]),
    .I5(num_clks[0]),
    .O(N166)
  );
  LUT6 #(
    .INIT ( 64'hFEFECEFE32020202 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<13>3  (
    .I0(N164),
    .I1(\counter/count_reg [1]),
    .I2(\counter/count_reg [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(N166),
    .I5(N165),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<13> )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<12>3_SW0  (
    .I0(N35),
    .I1(\FSM/mode [1]),
    .I2(\FSM/mode [0]),
    .I3(\deser/output_reg [12]),
    .O(N168)
  );
  LUT5 #(
    .INIT ( 32'hACACAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<12>3_SW1  (
    .I0(N35),
    .I1(\deser/output_reg [12]),
    .I2(\FSM/mode [1]),
    .I3(\FSM/mode [0]),
    .I4(num_clks[0]),
    .O(N169)
  );
  LUT6 #(
    .INIT ( 64'hAAF0AACCAAAAAAF0 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<12>3_SW2  (
    .I0(N35),
    .I1(N43),
    .I2(\deser/output_reg [12]),
    .I3(\FSM/mode [1]),
    .I4(\FSM/mode [0]),
    .I5(num_clks[0]),
    .O(N170)
  );
  LUT6 #(
    .INIT ( 64'hFEFECEFE32020202 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<12>3  (
    .I0(N168),
    .I1(\counter/count_reg [1]),
    .I2(\counter/count_reg [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(N170),
    .I5(N169),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<12> )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<9>_SW1  (
    .I0(N38),
    .I1(\FSM/mode [1]),
    .I2(\FSM/mode [0]),
    .I3(\deser/output_reg [9]),
    .O(N172)
  );
  LUT5 #(
    .INIT ( 32'hACACAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<9>_SW2  (
    .I0(N38),
    .I1(\deser/output_reg [9]),
    .I2(\FSM/mode [1]),
    .I3(\FSM/mode [0]),
    .I4(num_clks[0]),
    .O(N173)
  );
  LUT6 #(
    .INIT ( 64'hAAF0AACCAAAAAACC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<9>_SW3  (
    .I0(N38),
    .I1(N46),
    .I2(\deser/output_reg [9]),
    .I3(\FSM/mode [1]),
    .I4(\FSM/mode [0]),
    .I5(num_clks[0]),
    .O(N174)
  );
  LUT6 #(
    .INIT ( 64'hFEFE3202CEFE0202 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<9>  (
    .I0(N172),
    .I1(\counter/count_reg [1]),
    .I2(\counter/count_reg [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(N173),
    .I5(N174),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<9>_214 )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<8>_SW1  (
    .I0(N39),
    .I1(\FSM/mode [1]),
    .I2(\FSM/mode [0]),
    .I3(\deser/output_reg [8]),
    .O(N176)
  );
  LUT5 #(
    .INIT ( 32'hACACAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<8>_SW2  (
    .I0(N39),
    .I1(\deser/output_reg [8]),
    .I2(\FSM/mode [1]),
    .I3(\FSM/mode [0]),
    .I4(num_clks[0]),
    .O(N177)
  );
  LUT6 #(
    .INIT ( 64'hAAF0AACCAAAAAACC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<8>_SW3  (
    .I0(N39),
    .I1(N47),
    .I2(\deser/output_reg [8]),
    .I3(\FSM/mode [1]),
    .I4(\FSM/mode [0]),
    .I5(num_clks[0]),
    .O(N178)
  );
  LUT6 #(
    .INIT ( 64'hFEFE3202CEFE0202 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<8>  (
    .I0(N176),
    .I1(\counter/count_reg [1]),
    .I2(\counter/count_reg [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(N177),
    .I5(N178),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<8>_213 )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<11>_SW1  (
    .I0(N36),
    .I1(\FSM/mode [1]),
    .I2(\FSM/mode [0]),
    .I3(\deser/output_reg [11]),
    .O(N180)
  );
  LUT5 #(
    .INIT ( 32'hACACAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<11>_SW2  (
    .I0(N36),
    .I1(\deser/output_reg [11]),
    .I2(\FSM/mode [1]),
    .I3(\FSM/mode [0]),
    .I4(num_clks[0]),
    .O(N181)
  );
  LUT6 #(
    .INIT ( 64'hAAF0AACCAAAAAACC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<11>_SW3  (
    .I0(N36),
    .I1(N44),
    .I2(\deser/output_reg [11]),
    .I3(\FSM/mode [1]),
    .I4(\FSM/mode [0]),
    .I5(num_clks[0]),
    .O(N182)
  );
  LUT6 #(
    .INIT ( 64'hFEFE3202CEFE0202 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<11>  (
    .I0(N180),
    .I1(\counter/count_reg [1]),
    .I2(\counter/count_reg [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(N181),
    .I5(N182),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<11>_216 )
  );
  LUT4 #(
    .INIT ( 16'hABA8 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<10>_SW1  (
    .I0(N37),
    .I1(\FSM/mode [1]),
    .I2(\FSM/mode [0]),
    .I3(\deser/output_reg [10]),
    .O(N184)
  );
  LUT5 #(
    .INIT ( 32'hACACAAAC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<10>_SW2  (
    .I0(N37),
    .I1(\deser/output_reg [10]),
    .I2(\FSM/mode [1]),
    .I3(\FSM/mode [0]),
    .I4(num_clks[0]),
    .O(N185)
  );
  LUT6 #(
    .INIT ( 64'hAAF0AACCAAAAAACC ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<10>_SW3  (
    .I0(N37),
    .I1(N45),
    .I2(\deser/output_reg [10]),
    .I3(\FSM/mode [1]),
    .I4(\FSM/mode [0]),
    .I5(num_clks[0]),
    .O(N186)
  );
  LUT6 #(
    .INIT ( 64'hFEFE3202CEFE0202 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<10>  (
    .I0(N184),
    .I1(\counter/count_reg [1]),
    .I2(\counter/count_reg [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(N185),
    .I5(N186),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<10>_215 )
  );
  LUT6 #(
    .INIT ( 64'h0802000000000802 ))
  \FSM/GND_4_o_s_state[0]_Select_21_o2  (
    .I0(\FSM/GND_4_o_state[7]_equal_10_o<7>1 ),
    .I1(\FSM/state [5]),
    .I2(\FSM/state [4]),
    .I3(\FSM/GND_4_o_n_state[1]_Select_55_o<1>12 ),
    .I4(\FSM/nop_INT_195 ),
    .I5(\FSM/n_state_7_198 ),
    .O(\FSM/GND_4_o_s_state[0]_Select_21_o2_241 )
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \FSM/GND_4_o_s_state[0]_Select_21_o1_SW0  (
    .I0(\FSM/nop_INT_195 ),
    .I1(\FSM/n_state_7_198 ),
    .O(N188)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFF6BFFFF ))
  \FSM/GND_4_o_s_state[0]_Select_21_o1  (
    .I0(\FSM/state [5]),
    .I1(N188),
    .I2(\FSM/GND_4_o_n_state[1]_Select_55_o<1>12 ),
    .I3(\FSM/state [4]),
    .I4(\FSM/GND_4_o_state[7]_equal_10_o<7>1 ),
    .I5(\FSM/GND_4_o_state[7]_equal_8_o ),
    .O(\FSM/GND_4_o_s_state[0]_Select_21_o1_240 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF40000040 ))
  \FSM/GND_4_o_wr_rd_Select_28_o11_SW1  (
    .I0(\FSM/state [4]),
    .I1(\FSM/GND_4_o_state[7]_equal_10_o<7>1 ),
    .I2(N188),
    .I3(\FSM/state [5]),
    .I4(\FSM/GND_4_o_n_state[1]_Select_55_o<1>12 ),
    .I5(\FSM/GND_4_o_state[7]_equal_8_o ),
    .O(N96)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF20000000 ))
  \FSM/GND_4_o_wr_rd_Select_28_o11_SW0  (
    .I0(\FSM/state [5]),
    .I1(\FSM/state [4]),
    .I2(\FSM/GND_4_o_n_state[1]_Select_55_o<1>12 ),
    .I3(\FSM/GND_4_o_state[7]_equal_10_o<7>1 ),
    .I4(N188),
    .I5(\FSM/GND_4_o_state[7]_equal_8_o ),
    .O(N94)
  );
  LUT6 #(
    .INIT ( 64'hF7C4FFCCB3803300 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<28>3_SW0  (
    .I0(N35),
    .I1(\FSM/mode [0]),
    .I2(N81),
    .I3(N122),
    .I4(num_clks[0]),
    .I5(N123),
    .O(N194)
  );
  LUT6 #(
    .INIT ( 64'hFF53FFFFAC000000 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<28>3_SW1  (
    .I0(N35),
    .I1(N43),
    .I2(\FSM/mode [0]),
    .I3(N81),
    .I4(num_clks[0]),
    .I5(N123),
    .O(N195)
  );
  LUT6 #(
    .INIT ( 64'hFEFEC2023EFE0202 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<28>3  (
    .I0(N122),
    .I1(\counter/count_reg [1]),
    .I2(\counter/count_reg [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(N194),
    .I5(N195),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<28> )
  );
  LUT6 #(
    .INIT ( 64'hF7C4FFCCB3803300 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<29>3_SW0  (
    .I0(N34),
    .I1(\FSM/mode [0]),
    .I2(N84),
    .I3(N125),
    .I4(num_clks[0]),
    .I5(N126),
    .O(N197)
  );
  LUT6 #(
    .INIT ( 64'hFF53FFFFAC000000 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<29>3_SW1  (
    .I0(N34),
    .I1(N42),
    .I2(\FSM/mode [0]),
    .I3(N84),
    .I4(num_clks[0]),
    .I5(N126),
    .O(N198)
  );
  LUT6 #(
    .INIT ( 64'hFEFEC2023EFE0202 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<29>3  (
    .I0(N125),
    .I1(\counter/count_reg [1]),
    .I2(\counter/count_reg [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(N197),
    .I5(N198),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<29> )
  );
  LUT6 #(
    .INIT ( 64'hF7C4FFCCB3803300 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<30>3_SW0  (
    .I0(N33),
    .I1(\FSM/mode [0]),
    .I2(N87),
    .I3(N128),
    .I4(num_clks[0]),
    .I5(N129),
    .O(N200)
  );
  LUT6 #(
    .INIT ( 64'hFF53FFFFAC000000 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<30>3_SW1  (
    .I0(N33),
    .I1(N41),
    .I2(\FSM/mode [0]),
    .I3(N87),
    .I4(num_clks[0]),
    .I5(N129),
    .O(N201)
  );
  LUT6 #(
    .INIT ( 64'hFEFEC2023EFE0202 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<30>3  (
    .I0(N128),
    .I1(\counter/count_reg [1]),
    .I2(\counter/count_reg [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(N200),
    .I5(N201),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<30> )
  );
  LUT6 #(
    .INIT ( 64'hF7C4FFCCB3803300 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<31>3_SW0  (
    .I0(N32),
    .I1(\FSM/mode [0]),
    .I2(N90),
    .I3(N131),
    .I4(num_clks[0]),
    .I5(N132),
    .O(N203)
  );
  LUT6 #(
    .INIT ( 64'hFF53FFFFAC000000 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<31>3_SW1  (
    .I0(N32),
    .I1(N40),
    .I2(\FSM/mode [0]),
    .I3(N90),
    .I4(num_clks[0]),
    .I5(N132),
    .O(N204)
  );
  LUT6 #(
    .INIT ( 64'hFEFEC2023EFE0202 ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<31>3  (
    .I0(N131),
    .I1(\counter/count_reg [1]),
    .I2(\counter/count_reg [0]),
    .I3(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I4(N203),
    .I5(N204),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<31> )
  );
  LUT6 #(
    .INIT ( 64'hFEFFC2CC3E330200 ))
  \deser/done_glue_set  (
    .I0(N207),
    .I1(\counter/count_reg [1]),
    .I2(\counter/count_reg [0]),
    .I3(num_clks[0]),
    .I4(N206),
    .I5(N208),
    .O(\deser/done_glue_set_374 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \FSM/s_state_2  (
    .C(clk_BUFGP_24),
    .D(\FSM/s_state_2_rstpot_440 ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/s_state_2_188 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \FSM/s_state_3  (
    .C(clk_BUFGP_24),
    .D(\FSM/s_state_3_rstpot ),
    .R(g_rst_IBUF_22),
    .Q(\FSM/s_state_3_189 )
  );
  LUT6 #(
    .INIT ( 64'h999AAAAA9995AAAA ))
  \FSM/n_state_7_rstpot  (
    .I0(\FSM/n_state_7_198 ),
    .I1(N211),
    .I2(\counter/count_reg [1]),
    .I3(\counter/count_reg [0]),
    .I4(N213),
    .I5(N210),
    .O(\FSM/n_state_7_rstpot_391 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \FSM/err_type  (
    .C(clk_BUFGP_24),
    .D(\FSM/err_type_rstpot_443 ),
    .Q(\FSM/err_type_50 )
  );
  LUT6 #(
    .INIT ( 64'h0000000600000000 ))
  \FSM/GND_4_o_state[7]_equal_43_o<7>1  (
    .I0(\FSM/deserial_se_199 ),
    .I1(\FSM/s_state_0_200 ),
    .I2(N0),
    .I3(\FSM/state [4]),
    .I4(\FSM/state [5]),
    .I5(\FSM/GND_4_o_n_state[1]_Select_55_o<1>12 ),
    .O(\FSM/GND_4_o_state[7]_equal_43_o<7>1_152 )
  );
  LUT4 #(
    .INIT ( 16'hE2F0 ))
  \FSM/err_type_rstpot  (
    .I0(oob_err_IBUF_28),
    .I1(g_rst_IBUF_22),
    .I2(\FSM/err_type_50 ),
    .I3(\FSM/_n0291_inv2 ),
    .O(\FSM/err_type_rstpot_443 )
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFEFEFEFFF ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<27>2_SW0  (
    .I0(\FSM/mode [0]),
    .I1(\FSM/mode [1]),
    .I2(input_size_3_IBUF_16),
    .I3(input_size_2_IBUF_17),
    .I4(\num_clks<0>_bdd5 ),
    .I5(\FSM/poly_gen_53 ),
    .O(N98)
  );
  LUT6 #(
    .INIT ( 64'h6FFFF6FFFF6FFFF6 ))
  \FSM/GND_4_o_state[7]_equal_8_o<7>_SW0  (
    .I0(\FSM/s_state_2_188 ),
    .I1(\FSM/s_state_5_193 ),
    .I2(\FSM/n_state_1_194 ),
    .I3(\FSM/n_state_7_198 ),
    .I4(\FSM/deserial_se_199 ),
    .I5(\FSM/nop_INT_195 ),
    .O(N2)
  );
  LUT6 #(
    .INIT ( 64'h8AAAAAAABAAAAAAA ))
  \FSM/s_state_2_rstpot  (
    .I0(\FSM/s_state_2_188 ),
    .I1(\FSM/state [3]),
    .I2(\FSM/poly_gen_53 ),
    .I3(\FSM/GND_4_o_state[7]_equal_43_o<7>1_152 ),
    .I4(\deser/done_87 ),
    .I5(\FSM/s_state_5_193 ),
    .O(\FSM/s_state_2_rstpot_440 )
  );
  MUXF7   \FSM/PWR_4_o_state[7]_equal_12_o<7>1_SW0  (
    .I0(N1),
    .I1(N216),
    .S(\FSM/GND_4_o_n_state[1]_Select_55_o<1>12 ),
    .O(N210)
  );
  LUT6 #(
    .INIT ( 64'h9FFF9FFF9FFF9F9F ))
  \FSM/PWR_4_o_state[7]_equal_12_o<7>1_SW0_G  (
    .I0(\FSM/n_state_7_198 ),
    .I1(\FSM/nop_INT_195 ),
    .I2(\FSM/GND_4_o_state[7]_equal_10_o<7>1 ),
    .I3(N134),
    .I4(num_clks[0]),
    .I5(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .O(N216)
  );
  LUT5 #(
    .INIT ( 32'hDECCDEDE ))
  \deser/done_glue_set_SW0  (
    .I0(\FSM/deserial_ne_187 ),
    .I1(\deser/done_87 ),
    .I2(\FSM/deserial_se_199 ),
    .I3(\FSM/mode [1]),
    .I4(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .O(N206)
  );
  LUT4 #(
    .INIT ( 16'hAEEA ))
  \deser/done_glue_set_SW1  (
    .I0(\deser/done_87 ),
    .I1(\FSM/mode [1]),
    .I2(\FSM/deserial_ne_187 ),
    .I3(\FSM/deserial_se_199 ),
    .O(N207)
  );
  LUT4 #(
    .INIT ( 16'h9009 ))
  \FSM/_n0313_inv1_SW0  (
    .I0(\FSM/s_state_4_192 ),
    .I1(\FSM/nop_INT_195 ),
    .I2(\FSM/s_state_5_193 ),
    .I3(\FSM/ngen_INT_196 ),
    .O(N213)
  );
  LUT3 #(
    .INIT ( 8'hF9 ))
  \deser/_n02381  (
    .I0(\FSM/deserial_ne_187 ),
    .I1(\FSM/deserial_se_199 ),
    .I2(\FSM/mode [1]),
    .O(\deser/_n0238 )
  );
  LUT6 #(
    .INIT ( 64'h0000009000000900 ))
  \FSM/GND_4_o_state[7]_equal_10_o<7>11  (
    .I0(\FSM/s_state_2_188 ),
    .I1(\FSM/s_state_5_193 ),
    .I2(\FSM/n_state_1_194 ),
    .I3(\FSM/s_state_0_200 ),
    .I4(\FSM/state [3]),
    .I5(\FSM/deserial_se_199 ),
    .O(\FSM/GND_4_o_state[7]_equal_10_o<7>1 )
  );
  LUT6 #(
    .INIT ( 64'hDECCDEDEDEDEDEDE ))
  \deser/done_glue_set_SW2  (
    .I0(\FSM/deserial_ne_187 ),
    .I1(\deser/done_87 ),
    .I2(\FSM/deserial_se_199 ),
    .I3(\FSM/mode [1]),
    .I4(\FSM/mode [0]),
    .I5(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .O(N208)
  );
  LUT5 #(
    .INIT ( 32'hFF6F6FFF ))
  \FSM/PWR_4_o_state[7]_equal_12_o<7>1_SW1  (
    .I0(\FSM/nerr_197 ),
    .I1(\FSM/serr_191 ),
    .I2(\FSM/GND_4_o_state[7]_equal_10_o<7>1 ),
    .I3(\FSM/nop_INT_195 ),
    .I4(\FSM/n_state_7_198 ),
    .O(N211)
  );
  LUT6 #(
    .INIT ( 64'h8AA8AAAABAABAAAA ))
  \FSM/s_state_3_rstpot_G  (
    .I0(\FSM/s_state_3_189 ),
    .I1(\FSM/poly_gen_53 ),
    .I2(\FSM/s_state_5_193 ),
    .I3(\FSM/s_state_2_188 ),
    .I4(\deser/done_87 ),
    .I5(\FSM/n_state_3_190 ),
    .O(N218)
  );
  LUT3 #(
    .INIT ( 8'h82 ))
  Mmux_out_data_ext161 (
    .I0(\serial/out_data [9]),
    .I1(\FSM/nerr_197 ),
    .I2(\FSM/serr_191 ),
    .O(out_data_ext[9])
  );
  LUT3 #(
    .INIT ( 8'h82 ))
  Mmux_out_data_ext151 (
    .I0(\serial/out_data [8]),
    .I1(\FSM/nerr_197 ),
    .I2(\FSM/serr_191 ),
    .O(out_data_ext[8])
  );
  LUT6 #(
    .INIT ( 64'h9999900090009000 ))
  Mmux_out_data_ext141 (
    .I0(\FSM/nerr_197 ),
    .I1(\FSM/serr_191 ),
    .I2(gfau_data_7_IBUF_8),
    .I3(\serial/mux13 ),
    .I4(gfau_data_15_IBUF_0),
    .I5(\serial/mux14 ),
    .O(out_data_ext[7])
  );
  LUT6 #(
    .INIT ( 64'h9999900090009000 ))
  Mmux_out_data_ext131 (
    .I0(\FSM/nerr_197 ),
    .I1(\FSM/serr_191 ),
    .I2(gfau_data_6_IBUF_9),
    .I3(\serial/mux13 ),
    .I4(gfau_data_14_IBUF_1),
    .I5(\serial/mux14 ),
    .O(out_data_ext[6])
  );
  LUT6 #(
    .INIT ( 64'h9999900090009000 ))
  Mmux_out_data_ext121 (
    .I0(\FSM/nerr_197 ),
    .I1(\FSM/serr_191 ),
    .I2(gfau_data_5_IBUF_10),
    .I3(\serial/mux13 ),
    .I4(gfau_data_13_IBUF_2),
    .I5(\serial/mux14 ),
    .O(out_data_ext[5])
  );
  LUT6 #(
    .INIT ( 64'h9999900090009000 ))
  Mmux_out_data_ext111 (
    .I0(\FSM/nerr_197 ),
    .I1(\FSM/serr_191 ),
    .I2(gfau_data_4_IBUF_11),
    .I3(\serial/mux13 ),
    .I4(gfau_data_12_IBUF_3),
    .I5(\serial/mux14 ),
    .O(out_data_ext[4])
  );
  LUT6 #(
    .INIT ( 64'h9999900090009000 ))
  Mmux_out_data_ext101 (
    .I0(\FSM/nerr_197 ),
    .I1(\FSM/serr_191 ),
    .I2(gfau_data_3_IBUF_12),
    .I3(\serial/mux13 ),
    .I4(gfau_data_11_IBUF_4),
    .I5(\serial/mux14 ),
    .O(out_data_ext[3])
  );
  LUT6 #(
    .INIT ( 64'h9999900090009000 ))
  Mmux_out_data_ext91 (
    .I0(\FSM/nerr_197 ),
    .I1(\FSM/serr_191 ),
    .I2(gfau_data_2_IBUF_13),
    .I3(\serial/mux13 ),
    .I4(gfau_data_10_IBUF_5),
    .I5(\serial/mux14 ),
    .O(out_data_ext[2])
  );
  LUT6 #(
    .INIT ( 64'h9999900090009000 ))
  Mmux_out_data_ext81 (
    .I0(\FSM/nerr_197 ),
    .I1(\FSM/serr_191 ),
    .I2(gfau_data_1_IBUF_14),
    .I3(\serial/mux13 ),
    .I4(gfau_data_9_IBUF_6),
    .I5(\serial/mux14 ),
    .O(out_data_ext[1])
  );
  LUT3 #(
    .INIT ( 8'h82 ))
  Mmux_out_data_ext71 (
    .I0(\serial/out_data [15]),
    .I1(\FSM/nerr_197 ),
    .I2(\FSM/serr_191 ),
    .O(out_data_ext[15])
  );
  LUT3 #(
    .INIT ( 8'h82 ))
  Mmux_out_data_ext61 (
    .I0(\serial/out_data [14]),
    .I1(\FSM/nerr_197 ),
    .I2(\FSM/serr_191 ),
    .O(out_data_ext[14])
  );
  LUT3 #(
    .INIT ( 8'h82 ))
  Mmux_out_data_ext51 (
    .I0(\serial/out_data [13]),
    .I1(\FSM/nerr_197 ),
    .I2(\FSM/serr_191 ),
    .O(out_data_ext[13])
  );
  LUT3 #(
    .INIT ( 8'h82 ))
  Mmux_out_data_ext41 (
    .I0(\serial/out_data [12]),
    .I1(\FSM/nerr_197 ),
    .I2(\FSM/serr_191 ),
    .O(out_data_ext[12])
  );
  LUT3 #(
    .INIT ( 8'h82 ))
  Mmux_out_data_ext31 (
    .I0(\serial/out_data [11]),
    .I1(\FSM/nerr_197 ),
    .I2(\FSM/serr_191 ),
    .O(out_data_ext[11])
  );
  LUT3 #(
    .INIT ( 8'h82 ))
  Mmux_out_data_ext21 (
    .I0(\serial/out_data [10]),
    .I1(\FSM/nerr_197 ),
    .I2(\FSM/serr_191 ),
    .O(out_data_ext[10])
  );
  LUT5 #(
    .INIT ( 32'h06066606 ))
  \deser/_n0259_inv1  (
    .I0(\FSM/deserial_ne_187 ),
    .I1(\FSM/deserial_se_199 ),
    .I2(\FSM/mode [0]),
    .I3(num_clks[0]),
    .I4(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .O(\deser/_n0259_inv )
  );
  LUT6 #(
    .INIT ( 64'h2800002800000000 ))
  \FSM/_n0356_inv1  (
    .I0(op_done_IBUF_25),
    .I1(\FSM/s_state_3_189 ),
    .I2(\FSM/n_state_3_190 ),
    .I3(\FSM/s_state_2_188 ),
    .I4(\FSM/s_state_5_193 ),
    .I5(\FSM/GND_4_o_state[7]_equal_43_o<7>1_152 ),
    .O(\FSM/_n0356_inv )
  );
  LUT6 #(
    .INIT ( 64'h0082820000000000 ))
  \FSM/_n0352_inv1  (
    .I0(gen_rdy_IBUF_26),
    .I1(\FSM/s_state_3_189 ),
    .I2(\FSM/n_state_3_190 ),
    .I3(\FSM/s_state_2_188 ),
    .I4(\FSM/s_state_5_193 ),
    .I5(\FSM/GND_4_o_state[7]_equal_43_o<7>1_152 ),
    .O(\FSM/_n0352_inv )
  );
  LUT6 #(
    .INIT ( 64'h9000009000000000 ))
  \FSM/_n0395_inv11  (
    .I0(\FSM/n_state_3_190 ),
    .I1(\FSM/s_state_3_189 ),
    .I2(\deser/done_87 ),
    .I3(\FSM/s_state_2_188 ),
    .I4(\FSM/s_state_5_193 ),
    .I5(\FSM/GND_4_o_state[7]_equal_43_o<7>1_152 ),
    .O(\FSM/_n0395_inv1 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \deser/_n0250_inv1  (
    .I0(\FSM/deserial_se_199 ),
    .I1(\FSM/deserial_ne_187 ),
    .O(\deser/_n0250_inv )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \FSM/s_state_3_rstpot1  (
    .I0(\FSM/GND_4_o_state[7]_equal_43_o<7>1_152 ),
    .I1(\FSM/s_state_3_189 ),
    .I2(N218),
    .O(\FSM/s_state_3_rstpot )
  );
  FDE   \FSM/mode_1_1  (
    .C(t_clk_BUFGP_21),
    .CE(\FSM/_n0261_inv ),
    .D(N45),
    .Q(\FSM/mode_1_1_446 )
  );
  FDR   \counter/count_reg_0_1  (
    .C(t_clk_inv),
    .D(Result[0]),
    .R(count_rst),
    .Q(\counter/count_reg_0_1_447 )
  );
  FDR   \counter/count_reg_1_1  (
    .C(t_clk_inv),
    .D(Result[1]),
    .R(count_rst),
    .Q(\counter/count_reg_1_1_448 )
  );
  FDR   \counter/count_reg_1_2  (
    .C(t_clk_inv),
    .D(Result[1]),
    .R(count_rst),
    .Q(\counter/count_reg_1_2_449 )
  );
  FDR   \counter/count_reg_0_2  (
    .C(t_clk_inv),
    .D(Result[0]),
    .R(count_rst),
    .Q(\counter/count_reg_0_2_450 )
  );
  FDE   \FSM/mode_0_1  (
    .C(t_clk_BUFGP_21),
    .CE(\FSM/_n0261_inv ),
    .D(N46),
    .Q(\FSM/mode_0_1_451 )
  );
  FDR   \counter/count_reg_1_3  (
    .C(t_clk_inv),
    .D(Result[1]),
    .R(count_rst),
    .Q(\counter/count_reg_1_3_452 )
  );
  FDR   \counter/count_reg_0_3  (
    .C(t_clk_inv),
    .D(Result[0]),
    .R(count_rst),
    .Q(\counter/count_reg_0_3_453 )
  );
  BUFGP   t_clk_BUFGP (
    .I(t_clk),
    .O(t_clk_BUFGP_21)
  );
  BUFGP   clk_BUFGP (
    .I(clk),
    .O(clk_BUFGP_24)
  );
  INV   t_clk_inv1_INV_0 (
    .I(t_clk_BUFGP_21),
    .O(t_clk_inv)
  );
  INV   \counter/Mcount_count_reg_xor<0>11_INV_0  (
    .I(\counter/count_reg [0]),
    .O(Result[0])
  );
  INV   \iop/oe_inv1_INV_0  (
    .I(\FSM/wr_rd_54 ),
    .O(\iop/oe_inv )
  );
  INV   \FSM/deserial_ne_INV_32_o1_INV_0  (
    .I(\FSM/deserial_ne_187 ),
    .O(\FSM/deserial_ne_INV_32_o )
  );
  INV   \FSM/serr_INV_40_o1_INV_0  (
    .I(\FSM/serr_191 ),
    .O(\FSM/serr_INV_40_o )
  );
  INV   \FSM/s_state[4]_INV_37_o1_INV_0  (
    .I(\FSM/s_state_4_192 ),
    .O(\FSM/s_state[4]_INV_37_o )
  );
  INV   \FSM/s_state[5]_INV_47_o1_INV_0  (
    .I(\FSM/s_state_5_193 ),
    .O(\FSM/s_state[5]_INV_47_o )
  );
  INV   \FSM/n_state[3]_INV_41_o1_INV_0  (
    .I(\FSM/n_state_3_190 ),
    .O(\FSM/n_state[3]_INV_41_o )
  );
  INV   \FSM/deserial_se_INV_8_o1_INV_0  (
    .I(\FSM/deserial_se_199 ),
    .O(\FSM/deserial_se_INV_8_o )
  );
  INV   \FSM/nerr_INV_18_o1_INV_0  (
    .I(\FSM/nerr_197 ),
    .O(\FSM/nerr_INV_18_o )
  );
  INV   \FSM/ngen_INT_INV_15_o1_INV_0  (
    .I(\FSM/ngen_INT_196 ),
    .O(\FSM/ngen_INT_INV_15_o )
  );
  INV   \FSM/nop_INT_INV_12_o1_INV_0  (
    .I(\FSM/nop_INT_195 ),
    .O(\FSM/nop_INT_INV_12_o )
  );
  MUXF7   \deser/in_data[31]_in_data[7]_mux_23_OUT<27>1  (
    .I0(N219),
    .I1(N220),
    .S(\counter/count_reg_1_1_448 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<27>1_263 )
  );
  LUT5 #(
    .INIT ( 32'hEAAA2AAA ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<27>1_F  (
    .I0(\deser/output_reg [27]),
    .I1(\counter/count_reg_0_1_447 ),
    .I2(num_clks[0]),
    .I3(\FSM/mode [0]),
    .I4(N36),
    .O(N219)
  );
  LUT6 #(
    .INIT ( 64'hCEEE8A8A02228A8A ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<27>1_G  (
    .I0(\deser/output_reg [27]),
    .I1(\FSM/mode [0]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I3(\counter/count_reg_0_1_447 ),
    .I4(num_clks[0]),
    .I5(N36),
    .O(N220)
  );
  MUXF7   \deser/in_data[31]_in_data[7]_mux_23_OUT<26>1  (
    .I0(N221),
    .I1(N222),
    .S(\counter/count_reg_1_1_448 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<26>1_265 )
  );
  LUT5 #(
    .INIT ( 32'hEAAA2AAA ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<26>1_F  (
    .I0(\deser/output_reg [26]),
    .I1(\counter/count_reg_0_1_447 ),
    .I2(num_clks[0]),
    .I3(\FSM/mode [0]),
    .I4(N37),
    .O(N221)
  );
  LUT6 #(
    .INIT ( 64'hCEEE8A8A02228A8A ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<26>1_G  (
    .I0(\deser/output_reg [26]),
    .I1(\FSM/mode [0]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I3(\counter/count_reg_0_1_447 ),
    .I4(num_clks[0]),
    .I5(N37),
    .O(N222)
  );
  MUXF7   \deser/in_data[31]_in_data[7]_mux_23_OUT<25>1  (
    .I0(N223),
    .I1(N224),
    .S(\counter/count_reg_1_1_448 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<25>1_267 )
  );
  LUT5 #(
    .INIT ( 32'hEAAA2AAA ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<25>1_F  (
    .I0(\deser/output_reg [25]),
    .I1(\counter/count_reg_0_1_447 ),
    .I2(num_clks[0]),
    .I3(\FSM/mode [0]),
    .I4(N38),
    .O(N223)
  );
  LUT6 #(
    .INIT ( 64'hCEEE8A8A02228A8A ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<25>1_G  (
    .I0(\deser/output_reg [25]),
    .I1(\FSM/mode [0]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I3(\counter/count_reg_0_1_447 ),
    .I4(num_clks[0]),
    .I5(N38),
    .O(N224)
  );
  MUXF7   \deser/in_data[31]_in_data[7]_mux_23_OUT<24>1  (
    .I0(N225),
    .I1(N226),
    .S(\counter/count_reg_1_1_448 ),
    .O(\deser/in_data[31]_in_data[7]_mux_23_OUT<24>2_269 )
  );
  LUT5 #(
    .INIT ( 32'hEAAA2AAA ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<24>1_F  (
    .I0(\deser/output_reg [24]),
    .I1(\counter/count_reg_0_1_447 ),
    .I2(num_clks[0]),
    .I3(\FSM/mode [0]),
    .I4(N39),
    .O(N225)
  );
  LUT6 #(
    .INIT ( 64'hCEEE8A8A02228A8A ))
  \deser/in_data[31]_in_data[7]_mux_23_OUT<24>1_G  (
    .I0(\deser/output_reg [24]),
    .I1(\FSM/mode [0]),
    .I2(\deser/in_data[31]_in_data[7]_mux_23_OUT<20>1 ),
    .I3(\counter/count_reg_0_1_447 ),
    .I4(num_clks[0]),
    .I5(N39),
    .O(N226)
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

