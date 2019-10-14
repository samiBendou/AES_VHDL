library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.STD_LOGIC_UNSIGNED.ALL;

library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;
use lib_thirdparty.test_pack.all;

library lib_rtl;
use lib_rtl.all;


entity aes_round_tb is
end aes_round_tb;

architecture aes_round_tb_arch of aes_round_tb is

    component aes_round
    port(
        data_i : in bit128;
        key_i : in bit128;
        en_mixcolumns_i : in std_logic;
        en_round_i : in std_logic;
        inv_i : in std_logic;
        data_o : out bit128
        );
    end component;

    signal data_is, data_os, data_es, key_s : bit128;
    signal en_round_s, en_mixcolumns_s : std_logic;
    signal cond_s : boolean;
begin

    DUT : aes_round
    port map (
        data_i => data_is,
        key_i => key_s,
        en_mixcolumns_i => en_mixcolumns_s,
        en_round_i => en_round_s,
        inv_i => '0',
        data_o => data_os
    );
    PUT : process
    begin
        round : for k in 0 to 10 loop
            if k = 0 then
                data_is <= state_to_bit128(std_input_c);
            else
                data_is <= state_to_bit128(std_round_data_c(k - 1));
            end if;

            if k = 0 then 
                en_round_s <= '0';
                en_mixcolumns_s <= '0';
            elsif k = 10 then
                en_mixcolumns_s <= '0';
            else
                en_round_s <= '1';
                en_mixcolumns_s <= '1';
            end if;

            key_s <= state_to_bit128(std_roundkey_c(k));
            data_es <= state_to_bit128(std_round_data_c(k));
            assert cond_s report "output differs from expected output" severity error;
            wait for 100 ns;
        end loop; -- round
    end process PUT;

    cond_s <= data_es = data_os;

end aes_round_tb_arch ; -- aes_round_tb_arch