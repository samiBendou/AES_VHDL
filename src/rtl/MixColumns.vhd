--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 27 Octobre 2017
-- @component MixColumns
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library lib_thirdparty;
use lib_thirdparty.all;
use lib_thirdparty.crypt_pack.all;

entity MixColumns is
port (
	data_i : in type_state;
	en_i : in std_logic;
	data_o : out type_state
	);
end entity MixColumns;

architecture MixColumns_arch of MixColumns is
	signal data_s : type_state;

	component MatrixMultiplier
	port(   
		data_i : in column_state;
		inv_i : in std_logic;
		data_o : out column_state
		);
	end component;

begin
	data_o <= data_s when en_i = '1' else data_i;

	col_prod : for j in 0 to 3 generate
		multiplier: MatrixMultiplier
		port map(
			data_i(0) => data_i(0)(j),
			data_i(1) => data_i(1)(j),
			data_i(2) => data_i(2)(j),
			data_i(3) => data_i(3)(j),
			inv_i => '0',
			data_o(0) => data_s(0)(j),
			data_o(1) => data_s(1)(j),
			data_o(2) => data_s(2)(j),
			data_o(3) => data_s(3)(j)
		);
	end generate ; -- col_prod

end architecture MixColumns_arch;
