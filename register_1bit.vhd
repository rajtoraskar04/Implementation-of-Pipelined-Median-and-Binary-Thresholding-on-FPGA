library ieee;
use ieee.std_logic_1164.all;

entity register_1bit is
	port(Clk, Reset, reg_w : in std_logic;
	data_in : in std_logic;
	data_out : out std_logic);
end entity;

architecture struct of register_1bit is 

	signal reg : std_logic:='0';

begin

	p1 : process (clk)
	begin
		if(Reset = '1') then
			reg <= '0';
			
		elsif (clk'event and clk = '0') then
		
			if (reg_w = '1') then
				reg <= data_in;
			else
				reg <= reg;
			end if;
		end if;
	end  process p1;
	
		data_out<= reg;
end struct;