--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 27 Octobre 2017
-- @component SubBytes
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

library lib_operations;
use lib_operations.all;

entity SubBytes is
    port (
        data_i: in type_state;
        en_i: in std_logic;
        inv_i: in std_logic;
        data_o: out type_state);
end entity SubBytes;

architecture SubBytes_arch of SubBytes is

    component SBox
        port(sbox_i : in bit8;
            sbox_o : out bit8);
    end component;

    signal data_s, data_inv_s : type_state;

begin
    data_o <= data_s when inv_i = '0' and en_i = '1' else
                data_inv_s when inv_i = '1' and en_i = '1' else
                data_i;

    row : for i in 0 to 3 generate
        col : for j in 0 to 3 generate
            data_s(i)(j) <= sbox_c(to_integer(unsigned(data_i(i)(j))));
            data_inv_s(i)(j) <= inv_sbox_c(to_integer(unsigned(data_i(i)(j))));
        end generate col;
    end generate row;
end SubBytes_arch;
