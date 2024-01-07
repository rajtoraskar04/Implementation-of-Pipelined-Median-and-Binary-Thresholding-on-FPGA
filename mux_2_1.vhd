library ieee;
use ieee.std_logic_1164.all;

entity mux_2_1 is 
port (A,B,C: in std_logic; output : out std_logic);
end entity;

-- c=0 chooses A

architecture struct of mux_2_1 is

begin 

output <= (A and (not C))or(B and (C));

end struct; 