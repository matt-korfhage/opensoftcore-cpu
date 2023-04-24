-- ****************************************************************** 
-- * project:     adder 
-- * filename:    adder.vhd
-- * author:      Matthew Korfhage  
-- * date:        MSOE Spring Quarter 2022 
-- * provides:    a fetch adder for the CE1921 processor 
-- ****************************************************************** 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
	port(
		A: in std_logic_vector(31 downto 0);
		B: in std_logic_vector(31 downto 0);
		S: out std_logic_vector(31 downto 0)
	);
end adder;

architecture DATAFLOW of adder is
-- Make this integer values 
--(unsigned works fine, there are not negative PC values)
signal INTA: unsigned(31 downto 0);
signal INTB: unsigned(31 downto 0);
signal INTS: unsigned(31 downto 0);

begin

INTA <= unsigned(A);
INTB <= unsigned(B);
INTS <= INTA + INTB;
S <= std_logic_vector(INTS);

end architecture DATAFLOW;
