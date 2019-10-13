library IEEE;
use IEEE.std_logic_1164.all;

library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

library lib_operations;
use lib_operations.all;

entity AESRound is
port(
	data_i : in bit128;
	key_i : in bit128;
	en_mixcolumns_i : in std_logic;
	en_round_i : in std_logic;
	inv_i : in std_logic;
	data_o : out bit128
	);
end entity AESRound;

architecture AESRound_arch of AESRound is

	component AddRoundKey
	port( 
		data_i : in type_state;
		key_i : in type_state;
		en_i : in std_logic;
		data_o : out type_state
		);
	end component;
	component MixColumns
	port( 
		data_i : in type_state;
		en_i : in std_logic;
		inv_i : in std_logic;
		data_o : out type_state
		);
	end component;
	component ShiftRows
	port( 
		data_i : in type_state;
		en_i : in std_logic;
		inv_i : in std_logic;
		data_o : out type_state
		);
	end component;
	component SubBytes
	port( 
		data_i : in type_state;
		en_i : in std_logic;
		inv_i : in std_logic;
		data_o : out type_state
		);
	end component;

	signal data_s, subbytes_s, shiftrows_s, mixcolumns_s, roundkey_s : type_state;
	signal key_s : type_state;

begin
	row_conversion : for i in 0 to 3 generate
		col_conversion : for j in 0 to 3 generate
			data_s(i)(j) <= data_i(127-32*j-8*i downto 120-32*j-8*i);
			data_o(127-32*j-8*i downto 120-32*j-8*i) <= roundkey_s(i)(j);
			key_s(i)(j) <= key_i(127-32*j-8*i downto 120-32*j-8*i);
		end generate;
	end generate;

	sub_bytes : SubBytes
	port map(
		data_i => data_s,
		en_i => en_round_i,
		inv_i => inv_i,
		data_o => subbytes_s
		);

	shift_rows : ShiftRows
	port map(
		data_i => subbytes_s,
		en_i => en_round_i,
		inv_i => inv_i,
		data_o => shiftrows_s
		);

	mix_columns : MixColumns
	port map(
		data_i => shiftrows_s,
		en_i => en_mixcolumns_i,
		inv_i => inv_i,
		data_o => mixcolumns_s
		);

	add_roundkey : AddRoundkey
	port map(
		data_i => mixcolumns_s,
		key_i => key_s,
		en_i => '1',
		data_o => roundkey_s
		);

end architecture AESRound_arch;

configuration AESRound_conf of AESRound is
for AESRound_arch
	for all : SubBytes
		use entity lib_operations.SubBytes(SubBytes_arch);
	end for;
	for all : ShiftRows
		use entity lib_operations.ShiftRows(ShiftRows_arch);
	end for;
	for all : MixColumns
		use entity lib_operations.MixColumns(MixColumns_arch);
	end for;
	for all : AddRoundKey
		use entity lib_operations.AddRoundKey(AddRoundKey_arch);
	end for;
end for;
end configuration;
