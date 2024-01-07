library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity threshold is
port (inp,th:in std_logic_vector(7 downto 0); 
outp:out std_logic_vector(7 downto 0));
end entity;

architecture struct of threshold is 

begin

process(inp)
begin
if ((to_integer(unsigned(inp))) > (to_integer(unsigned(th)))) then
	outp <= (others=>'1');
elsif ((to_integer(unsigned(inp))) = (to_integer(unsigned(th)))) then
	outp <= (others=>'1');
else 
	outp <= (others=>'0');
end if;
end process;

end struct;