library ieee;
use ieee.std_logic_1164.all;

entity FA is
port(X,Y,Z : in std_logic; Cf,Sf : out  std_logic);
end entity FA;

architecture struct of FA is
signal S1,C1,C2: std_logic;

component HA is
port(A,B : in std_logic; C,S : out  std_logic);
end component HA;

 begin
ha1: HA port map(A => X,B =>Y, C => C1,S=>S1);
ha2: HA port map(A => S1,B =>Z, C => C2,S=>Sf);
Cf <= C1 or C2;
end struct;
