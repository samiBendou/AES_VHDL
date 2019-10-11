--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 19 Novembre 2018
-- @component InvMixColumns_tb
--------------------------------------------------------------------------------

library IEEE;
library lib_rtl;
library lib_thirdparty;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use lib_thirdparty.crypt_pack.all;
use lib_rtl.all;

entity InvMixColumns_tb is
end entity;

architecture InvMixColumns_tb_arch of InvMixColumns_tb is
signal data_is : type_state;
signal data_os : type_state;
signal en_s : std_logic;

component InvMixColumns
port(
    data_i : in type_state;
    data_o : out type_state;
    en_i : in std_logic);
end component;

begin
DUT : InvMixColumns port map(
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

configuration InvMixColumns_tb_conf of InvMixColumns_tb is
for InvMixColumns_tb_arch
    for DUT : InvMixColumns
        use entity lib_rtl.InvMixColumns(InvMixColumns_arch);
    end for;
end for;
end configuration;
