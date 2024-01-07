library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;

entity controller is
port (clock,rst:in std_logic;
	data_in: in std_logic_vector(7 downto 0);
	data_a: out std_logic_vector(7 downto 0);
	data_b: out std_logic_vector(7 downto 0);
	data_c: out std_logic_vector(7 downto 0));
end entity;

architecture struct of controller is 

component line_buffer is 
port (wr_en,r_upd,clock,rst: in std_logic;
data_in: in std_logic_vector(7 downto 0);
data_out: out std_logic_vector(7 downto 0));
end component;

signal pixel_ctr,total_ctr : integer:=-1;
signal flag,flag_2 : std_logic:='0';
--these flags are just to create certain timedelays to properly synchronize the simulations
signal r_en,wr_en : std_logic_vector(3 downto 0) :="0000";
signal wr_ptr : std_logic_vector(1 downto 0) :="00";
signal r_ptr : std_logic_vector(1 downto 0) :="11";
signal i_lb_1,i_lb_2,i_lb_3,i_lb_4 : std_logic_vector(7 downto 0) :="00000000";
signal o_lb_1,o_lb_2,o_lb_3,o_lb_4 : std_logic_vector(7 downto 0) :="00000000";

begin 

lb1 : line_buffer port map(wr_en=>wr_en(0),clock=>clock,rst=>rst,r_upd=>r_en(0),
			data_in=>i_lb_1,data_out=>o_lb_1);
lb2 : line_buffer port map(wr_en=>wr_en(1),clock=>clock,rst=>rst,r_upd=>r_en(1),
			data_in=>i_lb_2,data_out=>o_lb_2);
lb3 : line_buffer port map(wr_en=>wr_en(2),clock=>clock,rst=>rst,r_upd=>r_en(2),
			data_in=>i_lb_3,data_out=>o_lb_3);
lb4 : line_buffer port map(wr_en=>wr_en(3),clock=>clock,rst=>rst,r_upd=>r_en(3),
			data_in=>i_lb_4,data_out=>o_lb_4);

data_out_process: process(clock)
begin
	if clock = '1' and clock'event then
		if rst = '1' then
			r_en <= "0000";
			r_ptr <= "11";
			pixel_ctr <= -1;
			total_ctr <= -1;
			wr_ptr <= "00";	
			
		elsif total_ctr < 384 then
			r_en <= "0000"; 
			if pixel_ctr = 127 then
				wr_ptr <= std_logic_vector(to_unsigned(to_integer(unsigned(wr_ptr))+1, 2));
				pixel_ctr <= 0;
			else
				pixel_ctr <= pixel_ctr + 1;
				total_ctr <= total_ctr + 1;
			end if;
			
		elsif pixel_ctr = 127 then
			flag <= '1';
			pixel_ctr <= 0;
		else 
			pixel_ctr <= pixel_ctr + 1;
		end if;
--		elsif total_ctr < 384 then
--			pixel_ctr <= pixel_ctr + 1;
--			total_ctr <= total_ctr + 1;
--		else
--			pixel_ctr <= pixel_ctr + 1;
--		end if;
		
	
		if flag = '1' then
			r_ptr <= std_logic_vector(to_unsigned(to_integer(unsigned(r_ptr))+1,2));
			wr_ptr <= std_logic_vector(to_unsigned(to_integer(unsigned(wr_ptr))+1, 2));
			flag <= '0';
		end if;
	
		if total_ctr > 381 then
			if r_ptr = "11" then
				r_en <="0111";
			  data_a <= o_lb_3;
			  data_b <= o_lb_2;
			  data_c <= o_lb_1;
			elsif r_ptr = "00" then
				r_en <="1110";
			  data_a <= o_lb_4;
			  data_b <= o_lb_3;
			  data_c <= o_lb_2;
			elsif r_ptr = "01" then
				r_en <="1101";	
			  data_a <= o_lb_1;
			  data_b <= o_lb_4;
			  data_c <= o_lb_3;
			elsif r_ptr = "10" then
				r_en <="1011";
			  data_a <= o_lb_2;
			  data_b <= o_lb_1;
			  data_c <= o_lb_4;
			end if;
		 end if;
	end if;
end process; 

write_proc :process(clock)
begin
	if clock = '1' and clock'event then
		if rst = '1' then
			wr_en <= "0000";
		elsif flag_2 = '0' then 
			flag_2 <= '1';
		elsif wr_ptr = "00" and flag_2 ='1' then
			wr_en <= "0001";
			i_lb_1 <= data_in;
			i_lb_2 <= "00000000";
			i_lb_3 <= "00000000";
			i_lb_4 <= "00000000";
		elsif wr_ptr = "01" and flag_2 ='1'then
			wr_en <= "0010";
			i_lb_1 <= "00000000";
			i_lb_2 <= data_in;
			i_lb_3 <= "00000000";
			i_lb_4 <= "00000000";
		elsif wr_ptr = "10" and flag_2 ='1'then
			wr_en <= "0100";
			i_lb_1 <= "00000000";
			i_lb_2 <= "00000000";
			i_lb_3 <= data_in;
			i_lb_4 <= "00000000";
		elsif wr_ptr = "11" and flag_2 ='1'then
			wr_en <= "1000";
			i_lb_1 <= "00000000";
			i_lb_2 <= "00000000";
			i_lb_3 <= "00000000";
			i_lb_4 <= data_in;
		end if;
	end if;
end process;

end struct;


















