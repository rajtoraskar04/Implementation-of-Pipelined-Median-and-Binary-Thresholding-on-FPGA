library ieee;
use ieee.std_logic_1164.all;

entity ADD_SUB_8 is
port(M: in std_logic;A,B : in std_logic_vector(7 downto 0); COUT : out  std_logic; S : out std_logic_vector(7 downto 0));
end entity ADD_SUB_8;

architecture struct of ADD_SUB_8 is
signal C : std_logic_vector(7 downto 0) := "00000000";
signal xors : std_logic_vector(7 downto 0);

component FA is
port(X,Y,Z : in std_logic; Cf,Sf : out std_logic);
end component FA;

begin

process(B,M)
begin

for i in 0 to 7 loop
	xors(i) <= (B(i) xor M);
end loop;
end process;

summer_1 : FA port map(X => A(0),Y =>xors(0), Z => M,Cf=>C(0),Sf=>S(0));
	
sum : for i in 1 to 7 generate
	summer_2 : FA port map(X => A(i),Y =>xors(i), Z => C(i-1),Cf=>C(i),Sf=>S(i));
end generate;

COUT <= C(7);

end struct;