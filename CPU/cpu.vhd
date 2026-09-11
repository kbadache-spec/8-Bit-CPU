-- Copyright (C) 2025  Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus Prime License Agreement,
-- the Altera IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Altera and sold by Altera or its authorized distributors.  Please
-- refer to the Altera Software License Subscription Agreements 
-- on the Quartus Prime software download page.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 25.1std.0 Build 1129 10/21/2025 SC Lite Edition"
-- CREATED		"Fri Sep 11 10:24:35 2026"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY cpu IS 
	PORT
	(
		Clock :  IN  STD_LOGIC;
		RAM_PROG :  IN  STD_LOGIC;
		ROM_Program :  IN  STD_LOGIC;
		Prog_adrs :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		RAM_ADRS :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		RAM_DATA :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		ROM_DATA :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END cpu;

ARCHITECTURE bdf_type OF cpu IS 

ATTRIBUTE black_box : BOOLEAN;
ATTRIBUTE noopt : BOOLEAN;

COMPONENT lpm_counter_0
	PORT(clock : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END COMPONENT;
ATTRIBUTE black_box OF lpm_counter_0: COMPONENT IS true;
ATTRIBUTE noopt OF lpm_counter_0: COMPONENT IS true;

COMPONENT lpm_counter_1
	PORT(aclr : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 cnt_en : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END COMPONENT;
ATTRIBUTE black_box OF lpm_counter_1: COMPONENT IS true;
ATTRIBUTE noopt OF lpm_counter_1: COMPONENT IS true;

COMPONENT busmux_2
	PORT(sel : IN STD_LOGIC;
		 dataa : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END COMPONENT;
ATTRIBUTE black_box OF busmux_2: COMPONENT IS true;
ATTRIBUTE noopt OF busmux_2: COMPONENT IS true;

COMPONENT busmux_3
	PORT(sel : IN STD_LOGIC;
		 dataa : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END COMPONENT;
ATTRIBUTE black_box OF busmux_3: COMPONENT IS true;
ATTRIBUTE noopt OF busmux_3: COMPONENT IS true;

COMPONENT busmux_4
	PORT(sel : IN STD_LOGIC;
		 dataa : IN STD_LOGIC_VECTOR(0 TO 0);
		 datab : IN STD_LOGIC_VECTOR(0 TO 0);
		 result : OUT STD_LOGIC_VECTOR(0 TO 0));
END COMPONENT;
ATTRIBUTE black_box OF busmux_4: COMPONENT IS true;
ATTRIBUTE noopt OF busmux_4: COMPONENT IS true;

COMPONENT mux_8_4
	PORT(data1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 outp : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alu
	PORT(en : IN STD_LOGIC;
		 A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 zr : OUT STD_LOGIC;
		 ng : OUT STD_LOGIC;
		 outp : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dec4
	PORT(sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 outp : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dmux_4_8
	PORT(Data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 out1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 out2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 out3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 out4 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT reg
	PORT(clk : IN STD_LOGIC;
		 en_r : IN STD_LOGIC;
		 en_w : IN STD_LOGIC;
		 turn_on : IN STD_LOGIC;
		 I : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 outp : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dmux_2_7
	PORT(address : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 outp1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		 outp2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dmux_2_8
	PORT(sel : IN STD_LOGIC;
		 Data1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Data2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 outp : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ram
	PORT(clock : IN STD_LOGIC;
		 sel : IN STD_LOGIC;
		 en : IN STD_LOGIC;
		 Address : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 DataIN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rom
	PORT(clock : IN STD_LOGIC;
		 Prog : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 DataIN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux_2_4
	PORT(sel : IN STD_LOGIC;
		 IN1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 IN2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 outp : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	A :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	ALU_ON :  STD_LOGIC;
SIGNAL	arr_out :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	B :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	cycle :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	IR :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	memory :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	operation :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	PC :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	R1in :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	R2in :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	R3in :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	R4in :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	RAM_ADRS_IN :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	RAM_DATA_IN :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	RAM_EN :  STD_LOGIC;
SIGNAL	RAM_SEL :  STD_LOGIC;
SIGNAL	read :  STD_LOGIC;
SIGNAL	Rin1 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	Rin2 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	Rin3 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	Rin4 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	Rin_op1 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	Rin_op2 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	Rin_op3 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	Rin_op4 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	Rout0 :  STD_LOGIC;
SIGNAL	Rout1 :  STD_LOGIC;
SIGNAL	Rout10 :  STD_LOGIC;
SIGNAL	Rout11 :  STD_LOGIC;
SIGNAL	Rout12 :  STD_LOGIC;
SIGNAL	Rout13 :  STD_LOGIC;
SIGNAL	Rout14 :  STD_LOGIC;
SIGNAL	Rout15 :  STD_LOGIC;
SIGNAL	Rout16 :  STD_LOGIC;
SIGNAL	Rout17 :  STD_LOGIC;
SIGNAL	Rout2 :  STD_LOGIC;
SIGNAL	Rout20 :  STD_LOGIC;
SIGNAL	Rout21 :  STD_LOGIC;
SIGNAL	Rout22 :  STD_LOGIC;
SIGNAL	Rout23 :  STD_LOGIC;
SIGNAL	Rout24 :  STD_LOGIC;
SIGNAL	Rout25 :  STD_LOGIC;
SIGNAL	Rout26 :  STD_LOGIC;
SIGNAL	Rout27 :  STD_LOGIC;
SIGNAL	Rout3 :  STD_LOGIC;
SIGNAL	Rout30 :  STD_LOGIC;
SIGNAL	Rout31 :  STD_LOGIC;
SIGNAL	Rout32 :  STD_LOGIC;
SIGNAL	Rout33 :  STD_LOGIC;
SIGNAL	Rout34 :  STD_LOGIC;
SIGNAL	Rout35 :  STD_LOGIC;
SIGNAL	Rout36 :  STD_LOGIC;
SIGNAL	Rout37 :  STD_LOGIC;
SIGNAL	Rout4 :  STD_LOGIC;
SIGNAL	Rout40 :  STD_LOGIC;
SIGNAL	Rout41 :  STD_LOGIC;
SIGNAL	Rout42 :  STD_LOGIC;
SIGNAL	Rout43 :  STD_LOGIC;
SIGNAL	Rout44 :  STD_LOGIC;
SIGNAL	Rout45 :  STD_LOGIC;
SIGNAL	Rout46 :  STD_LOGIC;
SIGNAL	Rout47 :  STD_LOGIC;
SIGNAL	Rout5 :  STD_LOGIC;
SIGNAL	Rout6 :  STD_LOGIC;
SIGNAL	Rout7 :  STD_LOGIC;
SIGNAL	write :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_7 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_11 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_16 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_6 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_10 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_15 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_5 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_9 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_14 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_4 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_8 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_13 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_12 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_17 :  STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN 
SYNTHESIZED_WIRE_2 <= '1';
SYNTHESIZED_WIRE_8 <= '0';

GDFX_TEMP_SIGNAL_3 <= (Rout47 & Rout46 & Rout45 & Rout44 & Rout43 & Rout42 & Rout41 & Rout40);
GDFX_TEMP_SIGNAL_7 <= (Rout47 & Rout46 & Rout45 & Rout44 & Rout43 & Rout42 & Rout41 & Rout40);
GDFX_TEMP_SIGNAL_11 <= (Rout47 & Rout46 & Rout45 & Rout44 & Rout43 & Rout42 & Rout41 & Rout40);
Rout47 <= GDFX_TEMP_SIGNAL_16(7);
Rout46 <= GDFX_TEMP_SIGNAL_16(6);
Rout45 <= GDFX_TEMP_SIGNAL_16(5);
Rout44 <= GDFX_TEMP_SIGNAL_16(4);
Rout43 <= GDFX_TEMP_SIGNAL_16(3);
Rout42 <= GDFX_TEMP_SIGNAL_16(2);
Rout41 <= GDFX_TEMP_SIGNAL_16(1);
Rout40 <= GDFX_TEMP_SIGNAL_16(0);

GDFX_TEMP_SIGNAL_2 <= (Rout37 & Rout36 & Rout35 & Rout34 & Rout33 & Rout32 & Rout31 & Rout30);
GDFX_TEMP_SIGNAL_6 <= (Rout37 & Rout36 & Rout35 & Rout34 & Rout33 & Rout32 & Rout31 & Rout30);
GDFX_TEMP_SIGNAL_10 <= (Rout37 & Rout36 & Rout35 & Rout34 & Rout33 & Rout32 & Rout31 & Rout30);
Rout37 <= GDFX_TEMP_SIGNAL_15(7);
Rout36 <= GDFX_TEMP_SIGNAL_15(6);
Rout35 <= GDFX_TEMP_SIGNAL_15(5);
Rout34 <= GDFX_TEMP_SIGNAL_15(4);
Rout33 <= GDFX_TEMP_SIGNAL_15(3);
Rout32 <= GDFX_TEMP_SIGNAL_15(2);
Rout31 <= GDFX_TEMP_SIGNAL_15(1);
Rout30 <= GDFX_TEMP_SIGNAL_15(0);

GDFX_TEMP_SIGNAL_1 <= (Rout27 & Rout26 & Rout25 & Rout24 & Rout23 & Rout22 & Rout21 & Rout20);
GDFX_TEMP_SIGNAL_5 <= (Rout27 & Rout26 & Rout25 & Rout24 & Rout23 & Rout22 & Rout21 & Rout20);
GDFX_TEMP_SIGNAL_9 <= (Rout27 & Rout26 & Rout25 & Rout24 & Rout23 & Rout22 & Rout21 & Rout20);
Rout27 <= GDFX_TEMP_SIGNAL_14(7);
Rout26 <= GDFX_TEMP_SIGNAL_14(6);
Rout25 <= GDFX_TEMP_SIGNAL_14(5);
Rout24 <= GDFX_TEMP_SIGNAL_14(4);
Rout23 <= GDFX_TEMP_SIGNAL_14(3);
Rout22 <= GDFX_TEMP_SIGNAL_14(2);
Rout21 <= GDFX_TEMP_SIGNAL_14(1);
Rout20 <= GDFX_TEMP_SIGNAL_14(0);

GDFX_TEMP_SIGNAL_0 <= (Rout17 & Rout16 & Rout15 & Rout14 & Rout13 & Rout12 & Rout11 & Rout10);
GDFX_TEMP_SIGNAL_4 <= (Rout17 & Rout16 & Rout15 & Rout14 & Rout13 & Rout12 & Rout11 & Rout10);
GDFX_TEMP_SIGNAL_8 <= (Rout17 & Rout16 & Rout15 & Rout14 & Rout13 & Rout12 & Rout11 & Rout10);
Rout17 <= GDFX_TEMP_SIGNAL_13(7);
Rout16 <= GDFX_TEMP_SIGNAL_13(6);
Rout15 <= GDFX_TEMP_SIGNAL_13(5);
Rout14 <= GDFX_TEMP_SIGNAL_13(4);
Rout13 <= GDFX_TEMP_SIGNAL_13(3);
Rout12 <= GDFX_TEMP_SIGNAL_13(2);
Rout11 <= GDFX_TEMP_SIGNAL_13(1);
Rout10 <= GDFX_TEMP_SIGNAL_13(0);

Rout7 <= GDFX_TEMP_SIGNAL_12(7);
Rout6 <= GDFX_TEMP_SIGNAL_12(6);
Rout5 <= GDFX_TEMP_SIGNAL_12(5);
Rout4 <= GDFX_TEMP_SIGNAL_12(4);
Rout3 <= GDFX_TEMP_SIGNAL_12(3);
Rout2 <= GDFX_TEMP_SIGNAL_12(2);
Rout1 <= GDFX_TEMP_SIGNAL_12(1);
Rout0 <= GDFX_TEMP_SIGNAL_12(0);

GDFX_TEMP_SIGNAL_17 <= (Rout7 & Rout6 & Rout5 & Rout4 & Rout3 & Rout2 & Rout1 & Rout0);


b2v_A_Select : mux_8_4
PORT MAP(data1 => GDFX_TEMP_SIGNAL_0,
		 data2 => GDFX_TEMP_SIGNAL_1,
		 data3 => GDFX_TEMP_SIGNAL_2,
		 data4 => GDFX_TEMP_SIGNAL_3,
		 sel => operation(3 DOWNTO 2),
		 outp => A);


b2v_ALU : alu
PORT MAP(en => ALU_ON,
		 A => A,
		 B => B,
		 sel => operation(6 DOWNTO 4),
		 outp => arr_out);


b2v_B_Select : mux_8_4
PORT MAP(data1 => GDFX_TEMP_SIGNAL_4,
		 data2 => GDFX_TEMP_SIGNAL_5,
		 data3 => GDFX_TEMP_SIGNAL_6,
		 data4 => GDFX_TEMP_SIGNAL_7,
		 sel => operation(1 DOWNTO 0),
		 outp => B);


b2v_Cycle_Counter : lpm_counter_0
PORT MAP(clock => Clock,
		 q => SYNTHESIZED_WIRE_0);


RAM_EN <= cycle(2) OR RAM_PROG;



write <= memory(6) OR ALU_ON;


SYNTHESIZED_WIRE_10 <= read OR IR(7);


b2v_inst2 : dec4
PORT MAP(sel => SYNTHESIZED_WIRE_0,
		 outp => cycle);


ALU_ON <= IR(7) AND cycle(2);



read <= NOT(memory(6));



b2v_inst7 : mux_8_4
PORT MAP(data1 => GDFX_TEMP_SIGNAL_8,
		 data2 => GDFX_TEMP_SIGNAL_9,
		 data3 => GDFX_TEMP_SIGNAL_10,
		 data4 => GDFX_TEMP_SIGNAL_11,
		 sel => memory(5 DOWNTO 4),
		 outp => GDFX_TEMP_SIGNAL_12);


b2v_inst8 : dmux_4_8
PORT MAP(Data => SYNTHESIZED_WIRE_1,
		 sel => memory(5 DOWNTO 4),
		 out1 => Rin1,
		 out2 => Rin2,
		 out3 => Rin3,
		 out4 => Rin4);


b2v_Instruction_Reg : reg
PORT MAP(clk => Clock,
		 en_r => cycle(1),
		 en_w => cycle(0),
		 turn_on => SYNTHESIZED_WIRE_2,
		 I => SYNTHESIZED_WIRE_3,
		 outp => IR);


b2v_Instruction_Decoder : dmux_2_7
PORT MAP(address => IR(7),
		 data => IR(6 DOWNTO 0),
		 outp1 => memory,
		 outp2 => operation);


b2v_Program_Counter : lpm_counter_1
PORT MAP(aclr => ROM_Program,
		 clock => Clock,
		 cnt_en => cycle(3),
		 q => PC);


b2v_R0 : reg
PORT MAP(clk => Clock,
		 en_r => SYNTHESIZED_WIRE_10,
		 en_w => write,
		 turn_on => cycle(2),
		 I => R1in,
		 outp => GDFX_TEMP_SIGNAL_13);


b2v_R0_in : dmux_2_8
PORT MAP(sel => IR(7),
		 Data1 => Rin1,
		 Data2 => Rin_op1,
		 outp => R1in);


b2v_R1 : reg
PORT MAP(clk => Clock,
		 en_r => SYNTHESIZED_WIRE_10,
		 en_w => write,
		 turn_on => cycle(2),
		 I => R2in,
		 outp => GDFX_TEMP_SIGNAL_14);


b2v_R1_in : dmux_2_8
PORT MAP(sel => IR(7),
		 Data1 => Rin2,
		 Data2 => Rin_op2,
		 outp => R2in);


b2v_R2 : reg
PORT MAP(clk => Clock,
		 en_r => SYNTHESIZED_WIRE_10,
		 en_w => write,
		 turn_on => cycle(2),
		 I => R3in,
		 outp => GDFX_TEMP_SIGNAL_15);


b2v_R2_in : dmux_2_8
PORT MAP(sel => IR(7),
		 Data1 => Rin3,
		 Data2 => Rin_op3,
		 outp => R3in);


b2v_R2_Out : dmux_4_8
PORT MAP(Data => arr_out,
		 sel => operation(1 DOWNTO 0),
		 out1 => Rin_op1,
		 out2 => Rin_op2,
		 out3 => Rin_op3,
		 out4 => Rin_op4);


b2v_R3 : reg
PORT MAP(clk => Clock,
		 en_r => SYNTHESIZED_WIRE_10,
		 en_w => write,
		 turn_on => cycle(2),
		 I => R4in,
		 outp => GDFX_TEMP_SIGNAL_16);


b2v_R3_in : dmux_2_8
PORT MAP(sel => IR(7),
		 Data1 => Rin4,
		 Data2 => Rin_op4,
		 outp => R4in);


b2v_RAM : ram
PORT MAP(clock => Clock,
		 sel => RAM_SEL,
		 en => RAM_EN,
		 Address => RAM_ADRS_IN,
		 DataIN => RAM_DATA_IN,
		 output => SYNTHESIZED_WIRE_1);


b2v_RAM_Address_Sel : busmux_2
PORT MAP(sel => RAM_PROG,
		 dataa => memory(3 DOWNTO 0),
		 datab => RAM_ADRS,
		 result => RAM_ADRS_IN);


b2v_RAM_Data_In_sel : busmux_3
PORT MAP(sel => RAM_PROG,
		 dataa => GDFX_TEMP_SIGNAL_17,
		 datab => RAM_DATA,
		 result => RAM_DATA_IN);


b2v_RAM_Write_Sel : busmux_4
PORT MAP(sel => RAM_PROG,
		 dataa(0) => memory(6),
		 datab(0) => SYNTHESIZED_WIRE_8,
		 result(0) => RAM_SEL);


b2v_ROM : rom
PORT MAP(clock => Clock,
		 Prog => ROM_Program,
		 address => SYNTHESIZED_WIRE_9,
		 DataIN => ROM_DATA,
		 output => SYNTHESIZED_WIRE_3);


b2v_ROM_Program_Selector : mux_2_4
PORT MAP(sel => ROM_Program,
		 IN1 => PC,
		 IN2 => Prog_adrs,
		 outp => SYNTHESIZED_WIRE_9);


Rout0 <= GDFX_TEMP_SIGNAL_12(0);
Rout1 <= GDFX_TEMP_SIGNAL_12(1);
Rout10 <= GDFX_TEMP_SIGNAL_13(0);
Rout11 <= GDFX_TEMP_SIGNAL_13(1);
Rout12 <= GDFX_TEMP_SIGNAL_13(2);
Rout13 <= GDFX_TEMP_SIGNAL_13(3);
Rout14 <= GDFX_TEMP_SIGNAL_13(4);
Rout15 <= GDFX_TEMP_SIGNAL_13(5);
Rout16 <= GDFX_TEMP_SIGNAL_13(6);
Rout17 <= GDFX_TEMP_SIGNAL_13(7);
Rout2 <= GDFX_TEMP_SIGNAL_12(2);
Rout20 <= GDFX_TEMP_SIGNAL_14(0);
Rout21 <= GDFX_TEMP_SIGNAL_14(1);
Rout22 <= GDFX_TEMP_SIGNAL_14(2);
Rout23 <= GDFX_TEMP_SIGNAL_14(3);
Rout24 <= GDFX_TEMP_SIGNAL_14(4);
Rout25 <= GDFX_TEMP_SIGNAL_14(5);
Rout26 <= GDFX_TEMP_SIGNAL_14(6);
Rout27 <= GDFX_TEMP_SIGNAL_14(7);
Rout3 <= GDFX_TEMP_SIGNAL_12(3);
Rout30 <= GDFX_TEMP_SIGNAL_15(0);
Rout31 <= GDFX_TEMP_SIGNAL_15(1);
Rout32 <= GDFX_TEMP_SIGNAL_15(2);
Rout33 <= GDFX_TEMP_SIGNAL_15(3);
Rout34 <= GDFX_TEMP_SIGNAL_15(4);
Rout35 <= GDFX_TEMP_SIGNAL_15(5);
Rout36 <= GDFX_TEMP_SIGNAL_15(6);
Rout37 <= GDFX_TEMP_SIGNAL_15(7);
Rout4 <= GDFX_TEMP_SIGNAL_12(4);
Rout40 <= GDFX_TEMP_SIGNAL_16(0);
Rout41 <= GDFX_TEMP_SIGNAL_16(1);
Rout42 <= GDFX_TEMP_SIGNAL_16(2);
Rout43 <= GDFX_TEMP_SIGNAL_16(3);
Rout44 <= GDFX_TEMP_SIGNAL_16(4);
Rout45 <= GDFX_TEMP_SIGNAL_16(5);
Rout46 <= GDFX_TEMP_SIGNAL_16(6);
Rout47 <= GDFX_TEMP_SIGNAL_16(7);
Rout5 <= GDFX_TEMP_SIGNAL_12(5);
Rout6 <= GDFX_TEMP_SIGNAL_12(6);
Rout7 <= GDFX_TEMP_SIGNAL_12(7);
END bdf_type;