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
        text_i : in bit128;
        currentkey_i : in bit128;
        data_o : out bit128;
        clock_i : in std_logic;
        resetb_i : in std_logic;
        enableMixcolumns_i : in std_logic;
        enableRoundcomputing_i : in std_logic
        );
    end component;

    signal data_is, data_os, currentkey_s : bit128;
    signal en_s, en_mixcolumns_s, resetb_s : std_logic;
    signal cond_s : boolean;
    signal clock_s : std_logic;

begin

    DUT : AESRound 
    port map(
        text_i => data_is,
        currentkey_i => currentkey_s,
        data_o => data_os,
        clock_i => clock_s,
        resetb_i => resetb_s,
        enableMixcolumns_i => en_mixcolumns_s,
        enableRoundcomputing_i => en_s
    );

    PUT : process
    begin
        round : for k in 0 to 10 loop
            -- if k = 0 then
            --     data_is <= std_input_c;
            -- end if;
            -- data_is <= std_round_data_c(k - 1);
            -- cond_s <= data_os = data_round_data_c(k);
            -- wait for 100 ns;
        end loop; -- round
    end process PUT;

    assert cond_s report "output differs from expected output" severity error;

end AESRound_tb_arch ; -- AESRound_tb_arch