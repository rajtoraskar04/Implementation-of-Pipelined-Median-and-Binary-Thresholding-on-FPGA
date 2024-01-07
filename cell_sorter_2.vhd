library ieee;
use ieee.std_logic_1164.all;

entity cell_sorter_2 is 
port (A,B: in std_logic_vector(7 downto 0); H,L: out std_logic_vector(7 downto 0));
end entity;

architecture struct of cell_sorter_2 is

signal cout : std_logic;
signal S_var : std_logic_vector (7 downto 0);

component ADD_SUB_8 is
port(M: in std_logic;A,B : in std_logic_vector(7 downto 0); 
	COUT : out  std_logic; S : out std_logic_vector(7 downto 0));
end component ADD_SUB_8;

component mux_2_1 is 
port (A,B,C: in std_logic; output : out std_logic);
end component;

begin

add_sub : ADD_SUB_8 port map(M=>'1',A=>A,B=>B,COUT=>cout,S=>S_var);

low_mux :for i in 0 to 7 generate
	mux_low : mux_2_1 port map(A=>A(i),B=>B(i),C=>cout,output=>L(i));
-- A = 0, B=1;
end generate;

high_mux :for i in 0 to 7 generate
	mux_high : mux_2_1 port map(B=>A(i),A=>B(i),C=>cout,output=>H(i));
end generate;


end struct;
















