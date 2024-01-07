library ieee;
use ieee.std_logic_1164.all;

entity register_16bit is
	port(Clk, Reset, reg_w : in std_logic;
	data_in : in std_logic_vector(7 downto 0);
	data_out : out std_logic_vector(7 downto 0));
end entity;

architecture struct of register_16bit is 

	signal reg : std_logic_vector (7 downto 0) := (others => '0');

begin

	p1 : process (clk)
	begin
		if(Reset = '1') then
			reg <= "00000000";
			
		elsif (clk'event and clk = '1') then
		
			if (reg_w = '1') then
				reg <= data_in;
			else
				reg <= reg;
			end if;
		end if;
	end  process p1;
	
		data_out<= reg;
		
end struct;