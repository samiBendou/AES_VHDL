--------------------------------------------------------------------------------
--@author DAHOUX Sami
--@date 13 Novembre 2018
--@component InvSBox_tb
--------------------------------------------------------------------------------

library IEEE;
library lib_source;
library thirdparty;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use thirdparty.crypt_pack.all;

entity InvSBox_tb is
end entity InvSBox_tb;

architecture InvSBox_tb_arch of InvSBox_tb is
    signal inv_sbox_is : bit8;
    signal inv_sbox_os : bit8;

    component InvSBox
        port( inv_sbox_i : in bit8;
              inv_sbox_o : out bit8);
    end component;

    begin

    DUT : InvSBox
    port map(
    	inv_sbox_i => inv_sbox_is,
    	inv_sbox_o => inv_sbox_os);

    P0 : process
    	variable count  : std_logic_vector(7 downto 0) := "00000000";
    begin

      inv_sbox_is <= std_logic_vector(count);

      wait for 2 ns;

    	if count = x"FF" then
            --Retournement de compteur
    	    count := x"00";
    	else
    	    count := std_logic_vector(count + 1);
    	end if;

    end process P0;

end architecture InvSBox_tb_arch;

configuration InvSBox_tb_conf of InvSBox_tb is
for InvSBox_tb_arch
    for DUT : InvSBox
        use entity lib_source.InvSBox(InvSBox_arch);
    end for;
end for;
end configuration;
