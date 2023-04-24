-- ******************************************************************
-- * project:     reg32
-- * filename:    scp-fpga.vhd
-- * author:      Matthew Korfhage
-- * date:        MSOE Spring Quarter 2022
-- * provides:    a seven-segment decoder for the CE1921 computer
-- ******************************************************************

library ieee;
use ieee.std_logic_1164.all;

entity REG32 is 
	port(
		D: in std_logic_vector(31 downto 0);  --Next state
		Q: out std_logic_vector(31 downto 0); --Current state
		LD, RST, CLK: in std_logic            --Self documenting
	);
end entity REG32;

architecture BEHAVIOR of REG32 is

begin

	process(LD, RST, CLK)
	begin
		if RST = '0' then
			Q <= 32X"0";
		elsif rising_edge(CLK) then
			if LD = '0' then 
				Q <= D;
			end if;
		else
			Q <= Q;
		end if;
	end process;
	
end architecture BEHAVIOR;