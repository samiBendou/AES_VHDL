--------------------------------------------------------------------------------
--@author DAHOUX Sami
--@date 27 Octobre 2017
--@component SubBytes
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library thirdparty;
use thirdparty.crypt_pack.all;

entity SubBytes is
    port (
        data_i: in type_state;
        data_o: out type_state);
end entity SubBytes;

architecture SubBytes_arch of SubBytes is

component SBox
    port(sbox_i : in bit8;
        sbox_o : out bit8);
end component;

begin
    row : for i in 0 to 3 generate
        col : for j in 0 to 3 generate
		    inter: SBOX port map (
		        sbox_i => data_i(i)(j),
		        sbox_o => data_o(i)(j));
        end generate col;
    end generate row;
end SubBytes_arch;
