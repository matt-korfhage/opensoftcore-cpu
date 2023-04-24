-- ****************************************************************** 
-- * project:     controller
-- * filename:    controller.vhd
-- * author:      Matthew Korfhage  
-- * date:        MSOE Spring Quarter 2022 
-- * provides:    a master controller for the CE1921 processor 
-- ****************************************************************** 

library ieee;
use ieee.std_logic_1164.all;

entity controller is
	port(
--**************** INPUTS **************************
		IBUS: in std_logic_vector(31 downto 0);
		BIT4: in std_logic;
		--flags
		C,	-- Carry out
		V,	-- overflow
		N, -- ngeative
		Z: in std_logic; --zero
		
--**************** OUTPUTS **************************		
		PCSEL: out std_logic; --Chooses between PC+4 (usual command) and PC+8 (branch instrcutions)
		A3SEL: out std_logic; --Active to select register Rd for load and store oprations
		ROTSEL: out std_logic; --used when rotating an immediate value in data processing mode
		SHAMTSEL: out std_logic; --selects between a value shifted by an immediate or a register
		SRC2SEL: out std_logic; --Picks between a register value and an immediate to pass to execute stage
		REGWR: out std_logic; --Active when storing a value into the register file on a writeback command
		ALUS: out std_logic_vector(2 downto 0); --Chooses between the operations performed by the ALU (ADD, SUB, AND, etc...)
		CPSRWR: out std_logic; --Active when updating the status of the CVNZ flags for branch and compare operations
		MEMWR, MEMRD: out std_logic; --Active when we're reading/writing a value into memory on a load-store command
		WD4SEL: out std_logic --Chooses between data memory and ALU result to store into register Rd on writeback
	);
end entity controller;

architecture DATAFLOW of controller is

signal COND: std_logic_vector(3 downto 0); --IBUS[31..28]
signal OP: std_logic_vector(1 downto 0); --IBUS[27..26]	 
signal I: std_logic; --IBUS[25]
signal CMD: std_logic_vector(3 downto 0); --IBUS[24..21]
signal S: std_logic; --IBUS[20]
signal SHTYPE: std_logic_vector(1 downto 0); --IBUS[6..5]
signal B: std_logic;
signal L: std_logic;

begin

COND <= IBUS(31 downto 28); -- Usually 0xE when data processing but 0 and 1 on branch commands
OP <= IBUS(27 downto 26);	 -- Opcode, 0 on data processing, 1 on load store, 2 on branches
I <= IBUS(25);				    -- Selects whether or not we are using an immediate mode in data processing
CMD <= IBUS(24 downto 21);  -- Command to execute, such as add, subtract, bitwise and, etc...
S <= IBUS(20);					 -- Triggered high on a comparison operation in data processing
SHTYPE <= IBUS(6 downto 5); -- If shifting a value loaded by a register selects between L & R shift (logical & arith.)
B <= IBUS(22);              -- For load-store commands, selects whether there the command is 1 byte
L <= IBUS(20);					 -- On load-store specifies whether we are loading or not from data memory


PCSEL <= '0' when (COND = 4X"E" AND OP = 2X"2")
		   else '0' when (COND = 4X"0" AND OP = 2X"2" AND Z = '1')
			else '0' when (COND = 4X"1" AND OP = 2X"2" AND Z = '0')
			else '1';
	
A3SEL <= '1' when (COND = 4X"E" AND OP = 2X"1" AND L = '0')
			else '0';
			
ROTSEL <= '0' when I = '1' else '1';

SHAMTSEL <= '1' when BIT4 = '1' else '0';

SRC2SEL <= '0' when I = '0' else '1';
	
REGWR <= '0' when (COND = 4X"E" AND OP = 2X"0" AND S = '0') else
			'0' when (COND = 4X"E" AND OP = 2X"1" AND L = '1') else
			'1';

ALUS <= 3X"0" when CMD = 4X"4" else --ADD
		  3X"2" when CMD = 4X"0" else --AND
		  3X"1" when CMD = 4X"A" else --CMP
		  3X"4" when CMD = 4X"1" else --EOR
		  3X"6" when CMD = 4X"D" else --MOV
		  3X"7" when CMD = 4X"F" else --MVN
		  3X"3" when CMD = 4X"3" else --ORR
		  3X"1" when (CMD = 4X"2" OR CMD = 4X"A") else --SUB (also CMP)
		  3X"0";

CPSRWR <= '0' when (S = '1' AND COND = 4X"E" AND OP = 2X"0")
			     else '1';

MEMWR <= '0' when (L = '0' AND COND = 4X"E" AND OP = 2X"1") else '1';

MEMRD <= '0' when (L = '1' AND COND = 4x"E" AND OP = 2X"1") else '1'; --We won't be implementing a "read enable" signal, so non-active all the time

WD4SEL <= '0' when OP = 2X"1" else '1';

end architecture DATAFLOW;