--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 21 Novembre 2017
-- @component KeyExpansion_Counter
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

entity Counter is
port (  clock_i : in std_logic;
	resetb_i : in std_logic;
	en_i : in std_logic;
	count_i : in bit4;
	count_o : out bit4);
end entity Counter;

architecture Counter_arch of Counter is

signal count_s : integer range 0 to 10;

begin
count : process(resetb_i, en_i, count_s)
begin
	count_s <= to_integer(unsigned(count_i));
	if resetb_i = '0' then
		count_s <= 1;
	elsif clock_i'event and clock_i = '1' then
		if en_i = '0' then
			count_s <= count_s;
		else
			count_s <= count_s + 1;
		end if;
	end if;
	count_o <= std_logic_vector(to_unsigned(count_s, 4));
end process count;



end architecture Counter_arch;
