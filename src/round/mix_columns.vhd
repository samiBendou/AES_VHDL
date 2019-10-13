--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 27 Octobre 2017
-- @component mix_columns
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library lib_thirdparty;
use lib_thirdparty.all;
use lib_thirdparty.crypt_pack.all;

entity mix_columns is
port (
	data_i : in state_t;
	en_i : in std_logic;
	inv_i : in std_logic;
	data_o : out state_t
	);
end entity mix_columns;

architecture mix_columns_arch of mix_columns is
	signal data_s : state_t;

	component mix_prod
	port(   
		data_i : in col_state_t;
		inv_i : in std_logic;
		data_o : out col_state_t
		);
	end component;

begin
	data_o <= data_s when en_i = '1' else data_i;

	col_prod : for j in 0 to 3 generate
		prod: mix_prod
		port map(
			data_i(0) => data_i(0)(j),
			data_i(1) => data_i(1)(j),
			data_i(2) => data_i(2)(j),
			data_i(3) => data_i(3)(j),
			inv_i => inv_i,
			data_o(0) => data_s(0)(j),
			data_o(1) => data_s(1)(j),
			data_o(2) => data_s(2)(j),
			data_o(3) => data_s(3)(j)
		);
	end generate ; -- col_prod

end architecture mix_columns_arch;
