library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;

entity line_buffer is 
port (wr_en,r_upd,clock,rst: in std_logic;
data_in: in std_logic_vector(7 downto 0);
data_out: out std_logic_vector(7 downto 0));
end entity;

architecture struct of line_buffer is

type mem_array is array(127 downto 0) of std_logic_vector(7 downto 0);

signal mem : mem_array;
signal r_ptr : std_logic_vector(6 downto 0):=(others=>'0');
signal w_ptr : std_logic_vector(6 downto 0):=(others=>'0');


begin

wr_proc:process(clock,wr_en)
begin
	if clock='1' and clock'event then
	
		if rst = '1' then
			w_ptr <= "0000000";
			mem <= (others=>(others=>'0'));
		elsif wr_en = '1' then
			mem(to_integer(unsigned(w_ptr))) <= data_in;
			w_ptr <= std_logic_vector(to_unsigned(to_integer(unsigned(w_ptr))+1, 7));
		end if;
		
	end if;	
end process;

p1 :process(clock) 
begin 
	if clock ='1' and clock'event then
		if rst = '1' then
			r_ptr <= "0000000";
		elsif r_upd = '1' then 
			r_ptr <= std_logic_vector(to_unsigned(to_integer(unsigned(r_ptr))+1, 7));
		end if;
	end if;
end process;

data_out <= mem(to_integer(unsigned(r_ptr))); 

end struct;





























