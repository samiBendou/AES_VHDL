library IEEE;
use IEEE.std_logic_1164.all;
library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

library lib_operations;
use lib_operations.all;

entity AESRound is
port(
	text_i : in bit128;
	currentkey_i : in bit128;
	data_o : out bit128;
	clock_i : in std_logic;
	resetb_i : in std_logic;
	enableMixcolumns_i : in std_logic;
	enableRoundcomputing_i : in std_logic
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
	signal currentkey_s : type_state;

begin
	sub_bytes : SubBytes
	port map(
		data_i => data_s,
		en_i => enableRoundcomputing_i,
		inv_i => '0',
		data_o => subbytes_s
		);

	shift_rows : ShiftRows
	port map(
		data_i => subbytes_s,
		en_i => enableRoundcomputing_i,
		inv_i => '0',
		data_o => shiftrows_s
		);

	mix_columns : MixColumns
	port map(
		data_i => shiftrows_s,
		en_i => enableMixColumns_i,
		inv_i => '0',
		data_o => mixcolumns_s
		);

	add_roundkey : AddRoundkey
	port map(
		data_i => mixcolumns_s,
		key_i => currentkey_s,
		en_i => '1',
		data_o => roundkey_s
		);

	-- convert text on 128bits to type state
	row_i : for i in 0 to 3 generate
		col_i : for j in 0 to 3 generate
			data_s(i)(j) <= text_i(127-32*j-8*i downto 120-32*j-8*i);
		end generate;
	end generate;

	-- convert type state in 128bits vector
	row_o : for i in 0 to 3 generate
		col_o : for j in 0 to 3 generate
			data_o(127-32*j-8*i downto 120-32*j-8*i) <= roundkey_s(i)(j);
		end generate;
	end generate;

	-- convert current key to type state
	row_key : for i in 0 to 3 generate
		col_key : for j in 0 to 3 generate
			currentkey_s(i)(j) <= currentkey_i(127-32*j-8*i downto 120-32*j-8*i);
		end generate;
	end generate;

end architecture AESRound_arch;

configuration AESRound_configuration of AESRound is
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
