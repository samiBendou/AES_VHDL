library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

library lib_rtl;
use lib_rtl.all;


entity AESRound_tb is
end AESRound_tb;

architecture AESRound_tb_arch of AESRound_tb is

    component AESRound
    port(
        data_i : in bit128;
        key_i : in bit128;
        en_mixcolumns_i : in std_logic;
        en_round_i : in std_logic;
        inv_i : in std_logic;
        data_o : out bit128
        );
    end component;

    signal data_is, data_os, currentkey_s : type_state;
    signal en_s, en_mixcolumns_s, resetb_s : std_logic;
    signal cond_s : boolean;
    signal clock_s : std_logic;

begin

    PUT : process
    begin
        round : for k in 0 to 10 loop
            if k = 0 then
                data_is <= std_input_c;
            end if;
            data_is <= std_round_data_c(k - 1);
            cond_s <= data_os = std_round_data_c(k);
            wait for 100 ns;
        end loop; -- round
    end process PUT;

    assert cond_s report "output differs from expected output" severity error;

end AESRound_tb_arch ; -- AESRound_tb_arch