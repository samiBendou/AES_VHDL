--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 27 Octobre 2017
-- @component SubBytes_tb
--------------------------------------------------------------------------------

library IEEE;
library lib_operations;
library lib_thirdparty;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use lib_thirdparty.crypt_pack.all;
use lib_operations.all;

entity SubBytes_tb is
end entity;

architecture SubBytes_tb_arch of SubBytes_tb is

	component SubBytes
	port (
		data_i : in type_state;
		en_i : in std_logic;
		inv_i : in std_logic;
		data_o : out type_state
		);
	end component;

	signal data_is, data_os : type_state;

begin
	DUT : SubBytes
	port map (
		data_i => data_is,
		en_i => '1',
		inv_i => '0',
		data_o => data_os
		);

	PUT : process
		variable count  : std_logic_vector(7 downto 0) := "00000000";
	begin
		wait for 100 ns;
		if count = "11111111" then
		    count := "00000000";
		else
		    count := std_logic_vector(count + 1);
		end if;
		for i in 0 to 3 loop
			for j in 0 to 3 loop
				data_is(i)(j) <= std_logic_vector(count);
			end loop;
		end loop;
	end process PUT;

end architecture SubBytes_tb_arch;

configuration SubBytes_tb_conf of SubBytes_tb is
for SubBytes_tb_arch
    for DUT : SubBytes
        use entity lib_operations.SubBytes(SubBytes_arch);
    end for;
end for;
end configuration;
