--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 21 Novembre 2017
-- @component KeyExpansion
--------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

entity KeyExpansion is
port (
	key_i : in bit128;
	key_o : out bit128;
	rcon_i : in bit8);
end entity KeyExpansion;

architecture KeyExpansion_arch of KeyExpansion is

signal key_i_s : type_word;
signal key_rot_s : type_word;
signal key_sub_s : type_word;
signal key_xor_s : type_word;
signal rcon_s : column_state;

--Transformation de l'entrée en tableau state_t
begin
col_in : for j in 0 to 3 generate
	raw_in : for i in 0 to 3 generate
		key_i_s(i)(j) <= key_i(127-32*i-8*j downto 120-32*i-8*j);
	end generate raw_in;
end generate col_in;

--Transformation of Rcon to column_state.
rcon_s(0) <= rcon_i;
rcon_s(1) <= x"00";
rcon_s(2) <= x"00";
rcon_s(3) <= x"00";

--RotWord
key_rot_s(0)(3) <= key_i_s(3)(0);
key_rot_s(0)(0) <= key_i_s(3)(1);
key_rot_s(0)(1) <= key_i_s(3)(2);
key_rot_s(0)(2) <= key_i_s(3)(3);

--SubBytes over 4 bytes
key_sub_s(0)(0) <= sbox_c(to_integer(unsigned(key_rot_s(0)(0))));
key_sub_s(0)(1) <= sbox_c(to_integer(unsigned(key_rot_s(0)(1))));
key_sub_s(0)(2) <= sbox_c(to_integer(unsigned(key_rot_s(0)(2))));
key_sub_s(0)(3) <= sbox_c(to_integer(unsigned(key_rot_s(0)(3))));

key_xor_s(0) <= rcon_s xor (key_sub_s(0) xor key_i_s(0));
key_xor_s(1) <= key_i_s(1) xor key_xor_s(0);
key_xor_s(2) <= key_i_s(2) xor key_xor_s(1);
key_xor_s(3) <= key_i_s(3) xor key_xor_s(2);

--Transformation de la sortie en vecteur de 128 bits
col_out : for j in 0 to 3 generate
	raw_out : for i in 0 to 3 generate
		key_o(127-32*i-8*j downto 120-32*i-8*j) <= key_xor_s(i)(j);
	end generate raw_out;
end generate col_out;

end architecture KeyExpansion_arch;
