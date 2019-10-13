library ieee;
use ieee.std_logic_1164.all;

library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

library lib_round;
use lib_round.all;

entity aes_round is
port(
	data_i : in bit128;
	key_i : in bit128;
	en_mixcolumns_i : in std_logic;
	en_round_i : in std_logic;
	inv_i : in std_logic;
	data_o : out bit128
	);
end entity aes_round;

architecture aes_round_arch of aes_round is

	component add_roundkey
	port( 
		data_i : in state_t;
		key_i : in state_t;
		en_i : in std_logic;
		data_o : out state_t
		);
	end component;
	component mix_columns
	port( 
		data_i : in state_t;
		en_i : in std_logic;
		inv_i : in std_logic;
		data_o : out state_t
		);
	end component;
	component shift_rows
	port( 
		data_i : in state_t;
		en_i : in std_logic;
		inv_i : in std_logic;
		data_o : out state_t
		);
	end component;
	component sub_bytes
	port( 
		data_i : in state_t;
		en_i : in std_logic;
		inv_i : in std_logic;
		data_o : out state_t
		);
	end component;

	signal data_s, sub_bytes_s, shift_rows_s, mix_columns_s, roundkey_s : state_t;
	signal key_s : state_t;

begin
	row_conv : for i in 0 to 3 generate
		col_conv : for j in 0 to 3 generate
			data_s(i)(j) <= data_i(127-32*j-8*i downto 120-32*j-8*i);
			data_o(127-32*j-8*i downto 120-32*j-8*i) <= roundkey_s(i)(j);
			key_s(i)(j) <= key_i(127-32*j-8*i downto 120-32*j-8*i);
		end generate;
	end generate;

	subbytes : sub_bytes
	port map(
		data_i => data_s,
		en_i => en_round_i,
		inv_i => inv_i,
		data_o => sub_bytes_s
		);

	shiftrows : shift_rows
	port map(
		data_i => sub_bytes_s,
		en_i => en_round_i,
		inv_i => inv_i,
		data_o => shift_rows_s
		);

	mixcolumns : mix_columns
	port map(
		data_i => shift_rows_s,
		en_i => en_mixcolumns_i,
		inv_i => inv_i,
		data_o => mix_columns_s
		);

	addroundkey : add_roundkey
	port map(
		data_i => mix_columns_s,
		key_i => key_s,
		en_i => '1',
		data_o => roundkey_s
		);

end architecture aes_round_arch;