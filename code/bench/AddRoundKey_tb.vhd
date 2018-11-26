--------------------------------------------------------------------------------
--@author DAHOUX Sami
--@date 16 Décembre 2017
--@component AddRoundKey_tb
--------------------------------------------------------------------------------

library IEEE;
library lib_source;
library thirdparty;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use thirdparty.crypt_pack.all;
use lib_source.all;

entity AddRoundKey_tb is
end entity;

architecture AddRoundKey_tb_arch of AddRoundKey_tb is
    signal data_is : type_state;
    signal data_os : type_state;
    signal key_is : type_state;

    component AddRoundKey
        port(
            data_i: in type_state;
            data_o: out type_state;
            key_i: in type_state);
    end component;

    begin

    DUT: AddRoundKey port map(
        data_i => data_is,
        data_o => data_os,
        key_i => key_is);

    P0 : process
    begin
    for i in 0 to 3 loop
        for j in 0 to 3 loop
            data_is(i)(j) <= x"FF";
            key_is(i)(j) <= x"FF";
        end loop;
    end loop;
    wait;
    end process P0;

end architecture AddRoundKey_tb_arch;


configuration AddRoundKey_tb_conf of AddRoundKey_tb is
for AddRoundKey_tb_arch
    for DUT : AddRoundKey
        use entity lib_source.AddRoundKey(AddRoundKey_arch);
    end for;
end for;
end configuration;
