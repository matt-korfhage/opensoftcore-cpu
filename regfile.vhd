-- ****************************************************************** 
-- * project:     regfile
-- * filename:    regfile.vhd 
-- * author:      Matthew Korfhage
-- * date:        MSOE Spring Quarter 2022 
-- * provides:    a register file for the CE1921 processor 
-- ****************************************************************** 
 
-- use library packages 
--  std_logic_1164: 9-valued logic signal voltages   
library ieee;
use ieee.std_logic_1164.all;
 
 
-- function block symbol 
-- inputs:  
--    A1,A2,A3: 4-bit addresses specifying output registers RD1, RD2, and RD3 
--    A4      : 4-bit address specifying register to write WD4 data into  
--    WD4     : 32-bit data to be stored in register addressed by A4  
--    REGWR   : control signal to determine if input WD4 data gets stored  
--    RST     : active-low synchronous reset signal 
--    CLK     : clock for synchronized register behavior  
-- outputs:  
--    RD1     : 32-bit output from register specified by address A1  
--    RD2     : 32-bit output from register specified by address A2 
--    RD3     : 32-bit output from register specified by address A3  
entity regfile is  
	port(
	--Inputs
		--Reg addresses of RD1, RD2, RD3 respectively
		A1, A2, A3: in std_logic_vector(3 downto 0); -- 3 bit register indentifier address
		--register address to write result from ALU to
		A4: in std_logic_vector(3 downto 0);
		--signal propagated back from the ALU
		WD4: in std_logic_vector(31 downto 0);
		REGWR: in std_logic;
		RST: in std_logic;
		CLK: in std_logic;
	--Outputs
		RD1, RD2, RD3: out std_logic_vector(31 downto 0)
	);
end entity regfile; 
 
-- circuit description  
architecture BEHAVIORAL of regfile is  
   -- declare 16 internal signals that will become register outputs 
   signal R0: std_logic_vector(31 downto 0);
	signal R1: std_logic_vector(31 downto 0);
	signal R2: std_logic_vector(31 downto 0);
	signal R3: std_logic_vector(31 downto 0);
	signal R4: std_logic_vector(31 downto 0);
	signal R5: std_logic_vector(31 downto 0);
	signal R6: std_logic_vector(31 downto 0);
	signal R7: std_logic_vector(31 downto 0);
	signal R8: std_logic_vector(31 downto 0);
	signal R9: std_logic_vector(31 downto 0);
	signal R10: std_logic_vector(31 downto 0);
   signal R11: std_logic_vector(31 downto 0);
	signal R12: std_logic_vector(31 downto 0);
	signal R13: std_logic_vector(31 downto 0);
	signal R14: std_logic_vector(31 downto 0);
	signal R15: std_logic_vector(31 downto 0);
   
begin 
 
  -- use A1, A2, and A3 to control three multiplexers choosing 
  -- outputs RD1, RD2, and RD3 
  with A1 select  
  RD1 <= R0  when	B"0000",
			R1  when	B"0001",
			R2  when	B"0010",
			R3  when	B"0011",
			R4  when	B"0100",
			R5  when B"0101",
			R6  when B"0110",
			R7  when B"0111",
			R8  when	B"1000",
			R9  when	B"1001",
			R10 when B"1010",
			R11 when B"1011",
			R12 when B"1100",
			R13 when B"1101",
			R14 when B"1110",
			R15 when others;
          
  with A2 select  
  RD2 <= R0  when B"0000",
			R1  when	B"0001",
			R2  when	B"0010",
			R3  when	B"0011",
			R4  when	B"0100",
			R5  when B"0101",
			R6  when B"0110",
			R7  when B"0111",
			R8  when	B"1000",
			R9  when	B"1001",
			R10 when B"1010",
			R11 when B"1011",
			R12 when B"1100",
			R13 when B"1101",
			R14 when B"1110",
			R15 when others;
          
          
  with A3 select  
  RD3 <= R0  when B"0000",
			R1  when	B"0001",
			R2  when	B"0010",
			R3  when	B"0011",
			R4  when	B"0100",
			R5  when B"0101",
			R6  when B"0110",
			R7  when B"0111",
			R8  when	B"1000",
			R9  when	B"1001",
			R10 when B"1010",
			R11 when B"1011",
			R12 when B"1100",
			R13 when B"1101",
			R14 when B"1110",
			R15 when others;
           
          
  -- implement sixteen registers with active-low synchronous reset  
  -- and active-low synchronous load  
  reg0: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R0 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"0000" then R0 <= WD4;  
        end if; 
		end if;
     end if;
  end process;
  
  reg1: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R1 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"0001" then R1 <= WD4;  
        end if;
		end if; 
	 end if;
  end process;
  
  reg2: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R2 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"0010" then R2 <= WD4;  
        end if; 
		end if;
    end if;
  end process;
  
  reg3: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R3 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"0011" then R3 <= WD4;  
        end if; 
		end if;
	 end if;
  end process;
  
  reg4: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R4 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"0100" then R4 <= WD4;  
        end if; 
		end if;
	 end if;
  end process;
  
  reg5: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R5 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"0101" then R5 <= WD4;  
        end if; 
		end if;
	 end if;
  end process;
  
  reg6: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R6 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"0110" then R6 <= WD4;  
        end if; 
		end if;
	 end if;
  end process;
  
  reg7: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R7 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"0111" then R7 <= WD4;  
        end if; 
		end if;
	 end if;
  end process;
  
  reg8: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R8 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"1000" then R8 <= WD4;  
        end if; 
		end if;
	 end if;
  end process;
  
  reg9: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R9 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"1001" then R9 <= WD4;  
        end if; 
		end if;
	 end if;
  end process;

  reg10: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R10 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"1010" then R10 <= WD4;  
        end if; 
		end if;
	 end if;
  end process;
  
  reg11: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R11 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"1011" then R11 <= WD4;  
        end if; 
		end if;
	 end if;
  end process;
  
  reg12: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R12 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"1100" then R12 <= WD4;  
        end if; 
		end if;
	 end if;
  end process;
  
  reg13: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R13 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"1101" then R13 <= WD4;  
        end if; 
		end if;
	 end if;
  end process;
  
  reg14: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R14 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"1110" then R14 <= WD4;  
        end if; 
		end if;
	 end if;
  end process;
  
  reg15: process(rst,clk)  
  begin  
    if rising_edge(clk) then  
      if RST = '0' then R15 <= X"00000000";  
      elsif REGWR = '0' then  
        if A4 = B"1111" then R15 <= WD4;  
        end if; 
		end if;
	 end if;
  end process;
  
end architecture BEHAVIORAL;