library ieee;
use ieee.std_logic_1164.all;

entity HA is
port(A,B : in std_logic; C,S : out  std_logic);
end entity HA;

architecture struct of HA is

 begin
C <= A and B;
S <= A xor B;
end struct;
