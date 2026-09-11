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
-- use the following when compiling in Quartus Prime
--LIBRARY lpm;
--USE lpm.lpm_components.all; 

-- use the following when compiling in third party tools --
-- add lpm_pack.vhd from the Quartus Prime library
LIBRARY work;
USE work.lpm_components.all;

ENTITY lpm_counter_1 IS 
PORT 
( 
	aclr	:	IN	 STD_LOGIC;
	clock	:	IN	 STD_LOGIC;
	cnt_en	:	IN	 STD_LOGIC;
	q	:	OUT	 STD_LOGIC_VECTOR(3 DOWNTO 0)
); 
END lpm_counter_1;

ARCHITECTURE bdf_type OF lpm_counter_1 IS 
BEGIN 

-- instantiate LPM macrofunction 

b2v_Program_Counter : lpm_counter
GENERIC MAP(LPM_DIRECTION => "UP",
			LPM_WIDTH => 4)
PORT MAP(aclr => aclr,
		 clock => clock,
		 cnt_en => cnt_en,
		 q => q);

END bdf_type; 