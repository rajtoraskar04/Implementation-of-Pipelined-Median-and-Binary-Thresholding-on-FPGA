library ieee;
use ieee.std_logic_1164.all;

entity matrix_median is
	port(a,b,c : in std_logic_vector(7 downto 0);
	clock: in std_logic ; 
	data_out : out std_logic_vector(7 downto 0));
end entity;

architecture struct of matrix_median is

type signal_array is array (0 to 14) of std_logic_vector (7 downto 0);

signal x : signal_array := (others=>(others=>'0'));

component cell_sorter_3 is 
port (A,B,C: in std_logic_vector(7 downto 0); H,M,L: out std_logic_vector(7 downto 0));
end component;

component register_16bit is
	port(Clk, Reset, reg_w : in std_logic;
	data_in : in std_logic_vector(7 downto 0);
	data_out : out std_logic_vector(7 downto 0));
end component;

begin

r1 : register_16bit port map(Clk=>clock, Reset=>'0', reg_w=>'1',data_in=>x(12),data_out=>x(0));
r2 : register_16bit port map(Clk=>clock, Reset=>'0', reg_w=>'1',data_in=>x(13),data_out=>x(3));
r3 : register_16bit port map(Clk=>clock, Reset=>'0', reg_w=>'1',data_in=>x(14),data_out=>x(6));
r4 : register_16bit port map(Clk=>clock, Reset=>'0', reg_w=>'1',data_in=>x(0),data_out=>x(1));
r5 : register_16bit port map(Clk=>clock, Reset=>'0', reg_w=>'1',data_in=>x(1),data_out=>x(2));
r6 : register_16bit port map(Clk=>clock, Reset=>'0', reg_w=>'1',data_in=>x(3),data_out=>x(4));
r7 : register_16bit port map(Clk=>clock, Reset=>'0', reg_w=>'1',data_in=>x(4),data_out=>x(5));
r8 : register_16bit port map(Clk=>clock, Reset=>'0', reg_w=>'1',data_in=>x(6),data_out=>x(7));
r9 : register_16bit port map(Clk=>clock, Reset=>'0', reg_w=>'1',data_in=>x(7),data_out=>x(8));

sort1 : cell_sorter_3 port map(A=>a,B=>b,C=>c,H=>x(14),M=>x(13),L=>x(12));
sort2 : cell_sorter_3 port map(A=>x(0),B=>x(1),C=>x(2),H=>x(9),M=>open,L=>open);
sort3 : cell_sorter_3 port map(A=>x(3),B=>x(4),C=>x(5),H=>open,M=>x(10),L=>open);
sort4 : cell_sorter_3 port map(A=>x(6),B=>x(7),C=>x(8),H=>open,M=>open,L=>x(11));
sort5 : cell_sorter_3 port map(A=>x(9),B=>x(10),C=>x(11),H=>open,M=>data_out,L=>open);

end struct;
















