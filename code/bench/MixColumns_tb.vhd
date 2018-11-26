--------------------------------------------------------------------------------
--@author DAHOUX Sami
--@date 16 Décembre 2017
--@component MixColumns_tb
--------------------------------------------------------------------------------

library IEEE;
library lib_source;
library thirdparty;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use thirdparty.crypt_pack.all;
use lib_source.all;

entity MixColumns_tb is
end entity;

architecture MixColumns_tb_arch of MixColumns_tb is
signal data_is : type_state;
signal data_os : type_state;
signal en_s : std_logic;

component MixColumns
port(
    data_i : in type_state;
    data_o : out type_state;
    en_i : in std_logic);
end component;

begin
DUT : MixColumns port map(
    data_i => data_is,
    data_o => data_os,
    en_i => en_s);

P0 : process
begin
data_is(0) <= (x"01", x"00", x"00", x"00");
data_is(1) <= (x"00", x"01", x"00", x"00");
data_is(2) <= (x"00", x"00", x"01", x"00");
data_is(3) <= (x"00", x"00", x"00", x"01");
en_s <= '1';
wait;
end process P0;

end architecture;

configuration MixColumns_tb_conf of MixColumns_tb is
for MixColumns_tb_arch
    for DUT : MixColumns
        use entity lib_source.MixColumns(MixColumns_arch);
    end for;
end for;
end configuration;
