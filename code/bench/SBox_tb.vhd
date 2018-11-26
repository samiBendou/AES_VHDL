--------------------------------------------------------------------------------
--@author DAHOUX Sami
--@date 27 Octobre 2017
--@component SBox_tb
--------------------------------------------------------------------------------

library IEEE;
library lib_source;
library thirdparty;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use thirdparty.crypt_pack.all;

entity SBox_tb is
end entity SBox_tb;

architecture SBox_tb_arch of SBox_tb is
    signal sbox_is : bit8;
    signal sbox_os : bit8;

    component SBox
        port(sbox_i : in bit8;
            sbox_o : out bit8);
    end component;

    begin

    DUT : SBox
    port map(
    	sbox_i => sbox_is,
    	sbox_o => sbox_os);

    P0 : process
    	variable count  : std_logic_vector(7 downto 0) := "00000000";
    begin

      sbox_is <= std_logic_vector(count);

      wait for 2 ns;

    	if count = "11111111" then
            --Retournement de compteur
    	    count := "00000000";
    	else
    	    count := std_logic_vector(count + 1);
    	end if;

      wait for 2 ns;

    end process P0;

end architecture SBox_tb_arch;

configuration Sbox_tb_conf of Sbox_tb is
for SBox_tb_arch
    for DUT : SBox
        use entity lib_source.SBox(SBox_arch);
    end for;
end for;
end configuration;
