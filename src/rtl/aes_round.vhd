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

	signal data_s, subbytes_s, shiftrows_s, mixcolumns_s, addroundkey_s : state_t;
	signal key_s : state_t;

begin
	key_s <= bit128_to_state(key_i);
	data_s <= bit128_to_state(data_i);
	data_o <= state_to_bit128(addroundkey_s);

	subbytes : sub_bytes
	port map(
		data_i => data_s,
		en_i => en_round_i,
		inv_i => inv_i,
		data_o => subbytes_s
		);

	shiftrows : shift_rows
	port map(
		data_i => subbytes_s,
		en_i => en_round_i,
		inv_i => inv_i,
		data_o => shiftrows_s
		);

	mixcolumns : mix_columns
	port map(
		data_i => shiftrows_s,
		en_i => en_mixcolumns_i,
		inv_i => inv_i,
		data_o => mixcolumns_s
		);

	addroundkey : add_roundkey
	port map(
		data_i => mixcolumns_s,
		key_i => key_s,
		en_i => '1',
		data_o => addroundkey_s
		);

end architecture aes_round_arch;