library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

entity reg128 is
	port (
		data_i : in bit128;
		resetb_i : in std_logic;
		clock_i : in std_logic;
		we_i : in std_logic;
		data_o : out bit128
	) ;
end reg128;

architecture reg128_arch of reg128 is

	signal data_s : bit128;

begin
	data_o <= data_s;

	data_register: process( clock_i, resetb_i )
	begin
		if resetb_i = '0' then
			data_s <= (others => '0');
		elsif rising_edge(clock_i) and we_i = '1' then
			if we_i = '1' then
				data_s <= data_i;
			else
				data_s <= data_s;
			end if;
		end if;
	end process ; -- register

end reg128_arch ; -- reg128_arch