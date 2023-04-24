-- ****************************************************************** 
-- * project:     pc
-- * filename:    pc.vhd
-- * author:      Matthew Korfhage  
-- * date:        MSOE Spring Quarter 2022 
-- * provides:    a program counter for the CE1921 processor 
-- ****************************************************************** 

library ieee;
use ieee.std_logic_1164.all;

entity pc is
	port(
		D: in std_logic_vector(31 downto 0);
		LD: in std_logic; -- load enable
		RST: in std_logic; -- reset program ocunter
		CLK: in std_logic; -- clock pulse (tick-tock!)
		--current program counter instruction
		Q: out std_logic_vector(31 downto 0) 
	);
end pc;

architecture BEHAVIOR of pc is

begin

	process(CLK, LD, RST)
	begin
		if RST = '0' then --active low asynchronous reset
			Q <= 32X"0"; --reset program counter to address 0
		elsif rising_edge(CLK) then
			if LD = '0' then --active synchronous load
				Q <= D; --Q takes next value after clock pulse
			else 
				Q <= Q; --If no load then Q stays the same
			end if;
		end if;
	end process;
	
end architecture BEHAVIOR;