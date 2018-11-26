--------------------------------------------------------------------------------
--@author DAHOUX Sami
--@date 27 Octobre 2017
--@component ShiftRows_tb
--------------------------------------------------------------------------------

library IEEE;
library lib_source;
library thirdparty;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use thirdparty.crypt_pack.all;
use lib_source.all;

entity ShiftRows_tb is
end entity ShiftRows_tb;

architecture ShiftRows_tb_arch of ShiftRows_tb is
    signal data_is : type_state;
    signal data_os : type_state;

    component ShiftRows port(
        data_i : in type_state;
        data_o : out type_state);
    end component;

    begin
    DUT: ShiftRows
    port map(
    	data_i => data_is,
    	data_o => data_os);

    P0 : process
    begin

        data_is(0) <= (x"01", x"00", x"00", x"00");
        data_is(1) <= (x"00", x"01", x"00", x"00");
        data_is(2) <= (x"00", x"00", x"01", x"00");
        data_is(3) <= (x"00", x"00", x"00", x"01");
    wait;
    end process P0;

end architecture ShiftRows_tb_arch;

configuration ShiftRows_tb_conf of ShiftRows_tb is
for ShiftRows_tb_arch
    for DUT : ShiftRows
        use entity lib_source.ShiftRows(ShiftRows_arch);
    end for;
end for;
end configuration;
