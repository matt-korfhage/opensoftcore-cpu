-- ****************************************************************** 
-- * project:     cpsr
-- * filename:    cpsr.vhd
-- * author:      Matthew Korfhage  
-- * date:        MSOE Spring Quarter 2022 
-- * provides:    a current program status register for tracking the
--                operation flags generated by the the CE1921 processor 
-- ****************************************************************** 

library ieee;
use ieee.std_logic_1164.all;

entity cpsr is
	port (
		D3, --carry out flag
		D2, --overflow flag
		D1, --negatve result flag
		D0: in std_logic; --zero reult flag
		
		Q3, -- Output current-state for each flag (Q3 is output of D3 and so forth)
		Q2,
		Q1,
		Q0: out std_logic;
		
		LD: in std_logic;		-- active-low synchronous load
		RST: in std_logic;   -- active-low asynchronous reset
		CLK: in std_logic	-- clock signal, rising edge triggered
	);
end cpsr;

architecture BEHAVIOR of cpsr is

begin

	cpsrReg: process(LD, RST, CLK)
		begin
			if RST = '0' then		-- Reset all flags to '0' (inactive state)
				Q3 <= '0';
				Q2 <= '0';
				Q1 <= '0';
				Q0 <= '0';
			elsif rising_edge(CLK) then -- on clock rise
				if LD = '0' then -- Synchronous load
					Q3 <= D3;
					Q2 <= D2;
					Q1 <= D1;
					Q0 <= D0;
				else 
					Q3 <= Q3;	  -- If no load then keep values on clock rise
					Q2 <= Q2;
					Q1 <= Q1;
					Q0 <= Q0;
				end if;
			end if;
	end process;

end architecture BEHAVIOR;