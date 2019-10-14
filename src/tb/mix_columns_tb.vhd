--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 16 Décembre 2017
-- @component mix_columns_tb
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.STD_LOGIC_UNSIGNED.ALL;

library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;
use lib_thirdparty.test_pack.all;

library lib_round;
use lib_round.all;

entity mix_columns_tb is
end entity;

architecture mix_columns_tb_arch of mix_columns_tb is

    component mix_columns
    port(
        data_i : in state_t;
        data_o : out state_t;
        en_i : in std_logic;
        inv_i : in std_logic
        );
    end component;

    signal data_is : state_t;
    signal data_os : state_t;
    signal data_es : state_t;
    signal en_s : std_logic;
    signal cond_s : boolean;

begin
    DUT : mix_columns 
    port map(
        data_i => data_is,
        data_o => data_os,
        en_i => en_s,
        inv_i => '0'
        );

    PUT : process
    begin
        round : for k in 0 to 10 loop
            if k = 0 or k = 10 then
                en_s <= '0';
            else   
                en_s <= '1';
            end if;
            data_is <= std_shift_rows_data_c(k);
            data_es <= std_mix_columns_data_c(k);
            assert cond_s report "output differs from expected output" severity error;
            wait for 100 ns;
        end loop; -- round
    end process PUT;
    
    cond_s <= data_os = data_es;

end architecture;

configuration mix_columns_tb_conf of mix_columns_tb is
for mix_columns_tb_arch
    for DUT : mix_columns
        use entity lib_round.mix_columns(mix_columns_arch);
    end for;
end for;
end configuration;
