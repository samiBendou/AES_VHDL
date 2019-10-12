--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 16 Décembre 2017
-- @component MixColumns_tb
--------------------------------------------------------------------------------

library IEEE;
library lib_rtl;
library lib_thirdparty;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use lib_thirdparty.crypt_pack.all;
use lib_rtl.all;

entity MixColumns_tb is
end entity;

architecture MixColumns_tb_arch of MixColumns_tb is

signal data_is : type_state;
signal data_os : type_state;
signal data_es : type_state;
signal en_s : std_logic;

component MixColumns
port(
    data_i : in type_state;
    data_o : out type_state;
    en_i : in std_logic);
end component;

signal cond_s : boolean;

begin
    DUT : MixColumns port map(
        data_i => data_is,
        data_o => data_os,
        en_i => en_s);

    PUT : process
    begin
        round : for k in 0 to 10 loop
            if k = 0 or k = 10 then
                en_s <= '0';
            else   
                en_s <= '1';
            end if;
            data_is <= std_shiftrows_data_c(k);
            data_es <= std_mixcolumns_data_c(k);
            assert cond_s report "output differs from expected output" severity error;
            wait for 100 ns;
        end loop; -- round
    end process PUT;
    
    cond_s <= data_os = data_es;

end architecture;

configuration MixColumns_tb_conf of MixColumns_tb is
for MixColumns_tb_arch
    for DUT : MixColumns
        use entity lib_rtl.MixColumns(MixColumns_arch);
    end for;
end for;
end configuration;
