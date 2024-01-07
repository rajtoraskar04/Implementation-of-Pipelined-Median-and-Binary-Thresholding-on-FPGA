library ieee;
use ieee.std_logic_1164.all;

entity cell_sorter_3 is 
port (A,B,C: in std_logic_vector(7 downto 0); H,M,L: out std_logic_vector(7 downto 0));
end entity;

architecture struct of cell_sorter_3 is
signal x1,x2,x3 : std_logic_vector(7 downto 0);

component cell_sorter_2 is 
port (A,B: in std_logic_vector(7 downto 0); H,L: out std_logic_vector(7 downto 0));
end component;

begin

cell_1 : cell_sorter_2 port map(A=>A,B=>B,H=>x1,L=>x2);
cell_2 : cell_sorter_2 port map(A=>x2,B=>C,H=>x3,L=>L);
cell_3 : cell_sorter_2 port map(A=>x3,B=>x1,H=>H,L=>M);

end struct;
















