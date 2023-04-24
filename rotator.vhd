-- ******************************************************** 
-- * project:     rotator
-- * filename:    rotator.vhd 
-- * author:      Matthew Korfhage 
-- * date:        MSOE Spring Quarter 2022 
-- * provides:    a component to right rotate a 32-bit  
-- *              number a specified number of 2-bit  
-- *              rotations 
-- * approach:    use a multiplexer to route bits 
-- ******************************************************** 
 
-- use library packages  
-- std_logic_1164: 9-valued logic signal voltages  
library ieee; 
use ieee.std_logic_1164.all; 
 
-- function block symbol  
-- NUM is the input 32-bit number 
-- ROT4 is a 4-bit number encoding the number of 2-bit right rotates 
-- B is the rotated output for use by the ALU 
entity rotator is  
port(NUM:  in std_logic_vector(31 downto 0); 
     ROT:  in std_logic_vector(3 downto 0); 
     B:    out std_logic_vector(31 downto 0)); 
end entity rotator; 
 
-- circuit description  
architecture DATAFLOW of rotator is  
begin 
 
   -- USE CONCATENATION (&) TO FORM ROTATED OUTPUT 
   -- HINT: make a paper table of bits labled 31 downto 0 
   --       then start rotating right by two-bit rotations  
   --       remember that rotation wraps bits around to the other end 
   with ROT select  
         
        -- rotate right 15 two-bit rotations  
   B <= NUM(29 downto 0)&B"00" 	when B"1111", 
        -- rotate right 14 two-bit rotations 
        NUM(27 downto 0)&B"0000" when B"1110",  
        -- << complete other rotations >> 
        NUM(25 downto 0)&6X"0" 	when B"1101",
		  NUM(23 downto 0)&8X"0" 	when B"1100",
		  NUM(21 downto 0)&10X"0" 	when B"1011",
		  NUM(19 downto 0)&12X"0" 	when B"1010",
		  NUM(17 downto 0)&14X"0" 	when B"1001",
		  NUM(15 downto 0)&16X"0" 	when B"1000",
		  NUM(13 downto 0)&18X"0" 	when B"0111",
		  NUM(11 downto 0)&20X"0" 	when B"0110",
		  NUM(9 downto 0)&22X"0" 	when B"0101",
		  NUM(7 downto 0)&24X"0"	when B"0100",
        -- rotate right 3 two-bit rotations 
        NUM(5 downto 0)&B"000000000000000000000000"&NUM(7 downto 6) when B"0011",  
        NUM(3 downto 0)&24X"0"&NUM(7 downto 4) when B"0010",
		  NUM(1 downto 0)&24X"0"&NUM(7 downto 2) when B"0001",
        -- rotate right zero two-bit rotations 
        NUM when others;   
         
 end architecture DATAFLOW;