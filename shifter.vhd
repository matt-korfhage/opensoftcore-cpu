library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter is
port(
		RD2: in std_logic_vector(31 downto 0);
		SHAMT: in std_logic_vector(4 downto 0);
		SHTYPE: in std_logic_vector(1 downto 0);
		RD2SHIFTED: out std_logic_vector(31 downto 0));
end entity shifter;

architecture DATAFLOW of shifter is
	signal U_RD2VALUE: unsigned(31 downto 0);
	signal S_RD2VALUE: signed(31 downto 0);
	signal AMOUNT: integer range 0 to 31;
	signal U_RESULT: unsigned(31 downto 0);
	signal S_RESULT: signed(31 downto 0);
begin
	U_RD2VALUE <= unsigned(RD2);
	S_RD2VALUE <= signed(RD2);
	AMOUNT <= to_integer(unsigned(SHAMT));
	with SHTYPE select
		U_RESULT <= shift_left(U_RD2VALUE,AMOUNT) when B"00",
      shift_right(U_RD2VALUE,AMOUNT) when B"01",
		rotate_right(U_RD2VALUE,AMOUNT) when others;

with SHTYPE select
		S_RESULT <= shift_right(S_RD2VALUE,AMOUNT) when B"10",
		32X"0" when others;
		
with SHTYPE select
		RD2SHIFTED <= std_logic_vector(S_RESULT) when B"10",
		std_logic_vector(U_RESULT) when others;
		
end architecture DATAFLOW;