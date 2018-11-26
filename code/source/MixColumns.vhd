--------------------------------------------------------------------------------
--@author DAHOUX Sami
--@date 27 Octobre 2017
--@component MixColumns
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library thirdparty;
use thirdparty.crypt_pack.all;

entity MixColumns is
port (
	data_i : in type_state;
	data_o : out type_state;
	en_i : in std_logic);
end entity MixColumns;

architecture MixColumns_arch of MixColumns is

--multj_s : Valeur du produit par j du bloc data_i en entrée
-- j : valeur par laquelle multiplier

type prod_type_state is array(3 downto 0) of type_state;
type mat_mixcolumn_t is array(0 to 15) of bit8;

signal mult_s : prod_type_state;
signal sub_sum_s : prod_type_state;

constant mat_c : type_state := (
	(x"02", x"03",x"01", x"01"),
	(x"01", x"02",x"03", x"01"),
	(x"01", x"01",x"02", x"03"),
	(x"03", x"01",x"01", x"02")
);

component Prod2LUT
	port(	prod2_i : in bit8;
				prod2_o : out bit8);
end component;

component Prod3LUT
	port(	prod3_i : in bit8;
				prod3_o : out bit8);
end component;

begin

-- Generating subterms of matrix product : AikBkj
row_prod : for i in 0 to 3 generate
	col_prod : for j in 0 to 3 generate
		prod : for k in 0 to 3 generate
			prod2 : if(mat_c(i)(k) = x"02") generate
				prod2_lut: Prod2LUT port map (
					prod2_i => data_i(k)(j),
					prod2_o => mult_s(k)(i)(j));
			end generate prod2;

			prod3 : if(mat_c(i)(k) = x"03") generate
				prod3_lut: Prod3LUT port map (
					prod3_i => data_i(k)(j),
					prod3_o => mult_s(k)(i)(j));
			end generate prod3;

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

end architecture MixColumns_arch;
