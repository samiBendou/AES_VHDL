--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 27 Octobre 2017
-- @component ShiftRows_tb
--------------------------------------------------------------------------------

library IEEE;
library lib_operations;
library lib_thirdparty;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use lib_thirdparty.crypt_pack.all;
use lib_operations.all;

entity ShiftRows_tb is
end entity ShiftRows_tb;

architecture ShiftRows_tb_arch of ShiftRows_tb is
    signal data_is : type_state;
    signal data_os : type_state;

    component ShiftRows 
    port(
        data_i : in type_state;
        en_i : in std_logic;
        inv_i : in std_logic;
        data_o : out type_state
        );
    end component;

begin
    DUT: ShiftRows
    port map(
        data_i => data_is,
        en_i => '1',
        inv_i => '0',
        data_o => data_os
        );

    PUT : process
    begin
        data_is(0) <= (x"01", x"00", x"00", x"00");
        data_is(1) <= (x"00", x"01", x"00", x"00");
        data_is(2) <= (x"00", x"00", x"01", x"00");
        data_is(3) <= (x"00", x"00", x"00", x"01");
    wait;
    end process PUT;

end architecture ShiftRows_tb_arch;

configuration ShiftRows_tb_conf of ShiftRows_tb is
for ShiftRows_tb_arch
    for DUT : ShiftRows
        use entity lib_operations.ShiftRows(ShiftRows_arch);
    end for;
end for;
end configuration;
