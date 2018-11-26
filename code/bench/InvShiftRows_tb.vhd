--------------------------------------------------------------------------------
--@author DAHOUX Sami
--@date 19 Novembre 2018
--@component InvShiftRows_tb
--------------------------------------------------------------------------------

library IEEE;
library lib_source;
library thirdparty;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use thirdparty.crypt_pack.all;
use lib_source.all;

entity InvShiftRows_tb is
end entity InvShiftRows_tb;

architecture InvShiftRows_tb_arch of InvShiftRows_tb is
    signal data_is : type_state;
    signal data_os : type_state;

    component InvShiftRows port(
        data_i : in type_state;
        data_o : out type_state);
    end component;

    begin
    DUT: InvShiftRows
    port map(
    	data_i => data_is,
    	data_o => data_os);

    P0 : process
    begin
        data_is(0) <= (x"01", x"00", x"00", x"00");
        data_is(1) <= (x"01", x"00", x"00", x"00");
        data_is(2) <= (x"01", x"00", x"00", x"00");
        data_is(3) <= (x"01", x"00", x"00", x"00");
    wait;
    end process P0;

end architecture InvShiftRows_tb_arch;

configuration InvShiftRows_tb_conf of InvShiftRows_tb is
for InvShiftRows_tb_arch
    for DUT : InvShiftRows
        use entity lib_source.InvShiftRows(InvShiftRows_arch);
    end for;
end for;
end configuration;
