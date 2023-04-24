-- ******************************************************** 
-- * project:     extender
-- * filename:    extender.vhd 
-- * author:      Matthew Korfhage
-- * date:        MSOE Spring Quarter 2022 
-- * provides:    a component to convert 8, 12, or 24-bit 
-- *              ARMV4 constants to 32-bit ALU values  
-- * approach:    use a multiplexer to choose 32-bit values 
-- *              created from smaller values 
-- ******************************************************** 
 
-- library packages  
--   std_logic_1164: 9-valued logic signal voltages  
library ieee;
use ieee.std_logic_1164.all;
 
-- function block symbol  
-- IMM8 is the 8-bit arithmetic immediate field input 
-- IMM12 is the 12-bit load-store immediate field input 
-- IMM24 is the 24-bit branch immediate field input 
-- EXTS selects the size of extension based on instruction 
-- IMM32 is the extended constant output for use by the ALU 
entity extender is  
port(
		IMM8:  in std_logic_vector(7 downto 0); 
		IMM12: in std_logic_vector(11 downto 0); 
		IMM24: in std_logic_vector(23 downto 0); 
		EXTS:  in std_logic_vector(1 downto 0); 
		IMM32: out std_logic_vector(31 downto 0)
	 ); 
end extender; 
 
-- circuit description  
architecture DATAFLOW of extender is  
 
   -- declare three internal 32-bit signals 
   -- one signal per EXTS choice 
   -- call them SIG_EXT8, SIG_EXT12, SIG_EXT24  
   signal SIG_EXT8: std_logic_vector(31 downto 0);
	signal SIG_EXT12: std_logic_vector(31 downto 0);
	signal SIG_EXT24: std_logic_vector(31 downto 0);
	
begin 
 
   -- truth table  
   -- EXTS  SELECTS THIS BEHAVIOR                                      
   -- 0     put IMM8 into the lower 8-bits of IMM32 
   -- 1     put IMM12 into the lower 12 bits of IMM32 
   -- 2     put IMM24 into IMM32(25 downto 2) 
   --       and set IMM32(31 downto 26) = IMM24(23)  
   -- 3     unused: output IMM32 = 0 
   
   -- create internal signals  
   SIG_EXT8(7 downto 0) <= IMM8;  
   SIG_EXT12(11 downto 0) <= IMM12;
	SIG_EXT24 <= 	IMM24(23) &
						IMM24(23) &
						IMM24(23) &
						IMM24(23) &
						IMM24(23) &
						IMM24(23) &
						IMM24(23 downto 0) &
						"00";
   
   -- use a multiplexer to pass the correct internal signal 
   -- to the output port  
   with EXTS select  
   IMM32 <= SIG_EXT8 when B"00",  -- data processing 
				SIG_EXT12 when B"01", -- load-store 
				SIG_EXT24 when B"10", -- branch 
            32X"0" when others; -- reserved 
    
 end architecture DATAFLOW;