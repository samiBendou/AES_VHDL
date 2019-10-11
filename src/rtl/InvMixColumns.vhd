--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 29 Novembre 2018
-- @component InvMixColumns
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library lib_thirdparty;
use lib_thirdparty.all;
use lib_thirdparty.crypt_pack.all;

entity InvMixColumns is
port (
	data_i : in type_state;
	data_o : out type_state;
	en_i : in std_logic);
end entity InvMixColumns;

architecture InvMixColumns_arch of InvMixColumns is

--multj_s : Valeur du produit par j du bloc data_i en entrée
-- j : valeur par laquelle multiplier

type prod_type_state is array(3 downto 0) of type_state;
type mat_mixcolumn_t is array(0 to 15) of bit8;

signal mult_s : prod_type_state;
signal sub_sum_s : prod_type_state;

constant mat_c : type_state := (
	(x"09", x"0b",x"0d", x"09"),
	(x"09", x"0e",x"0b", x"0d"),
	(x"0d", x"09",x"0e", x"0b"),
	(x"0b", x"0d",x"09", x"0e")
);

component Prod9LUT
	port(	prod9_i : in bit8;
				prod9_o : out bit8);
end component;

component ProdBLUT
	port(	prodb_i : in bit8;
				prodb_o : out bit8);
end component;

component ProdDLUT
	port(	prodd_i : in bit8;
				prodd_o : out bit8);
end component;

component ProdELUT
	port(	prode_i : in bit8;
				prode_o : out bit8);
end component;

begin

-- Generating subterms of matrix product : AikBkj
row_prod : for i in 0 to 3 generate
	col_prod : for j in 0 to 3 generate
		prod : for k in 0 to 3 generate
			prod9 : if(mat_c(i)(k) = x"09") generate
				prod9_lut: Prod9LUT port map (
					prod9_i => data_i(k)(j),
					prod9_o => mult_s(k)(i)(j));
			end generate prod9;

			prodb : if(mat_c(i)(k) = x"0b") generate
				prodb_lut: ProdBLUT port map (
					prodb_i => data_i(k)(j),
					prodb_o => mult_s(k)(i)(j));
			end generate prodb;

			prodd : if(mat_c(i)(k) = x"0d") generate
				prodd_lut: ProdDLUT port map (
					prodd_i => data_i(k)(j),
					prodd_o => mult_s(k)(i)(j));
			end generate prodd;

			prode : if(mat_c(i)(k) = x"0e") generate
				prode_lut: ProdELUT port map (
					prode_i => data_i(k)(j),
					prode_o => mult_s(k)(i)(j));
			end generate prode;

			prod1 : if(mat_c(i)(k) = x"01") generate
				mult_s(k)(i)(j) <= data_i(k)(j);
			end generate prod1;

		end generate prod;
	end generate col_prod;
end generate row_prod;

-- Generating sum of AiBkj => ∑AiBkj
row_sum : for i in 0 to 3 generate
	col_sum : for j in 0 to 3 generate
		sub_sum_s(0)(i)(j) <= mult_s(0)(i)(j);
		sum : for k in 1 to 3 generate
			sub_sum_s(k)(i)(j) <= mult_s(k)(i)(j) xor sub_sum_s(k - 1)(i)(j);
		end generate sum;
		data_o(i)(j) <= sub_sum_s(3)(i)(j);
	end generate col_sum;
end generate row_sum;

end architecture InvMixColumns_arch;
