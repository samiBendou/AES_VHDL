library IEEE;
use IEEE.std_logic_1164.all;
library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;
library lib_rtl;
use lib_rtl.all;

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
port( data_i : in type_state;
      key_i : in type_state;
      data_o : out type_state);
end component;
component MixColumns
port( data_i : in type_state;
      data_o : out type_state;
	  en_i : in std_logic);
end component;
component ShiftRows
port( data_i : in type_state;
      data_o : out type_state);
end component;
component SubBytes
port( data_i : in type_state;
      data_o : out type_state);
end component;
signal data_s : type_state;
signal textState_s : type_state;
signal currentStateKey_s : type_state;
signal inputAddRoundkey_s : type_state;
signal outputAddRoundKey_s : type_state;
signal inputSubBytes_s : type_state;
signal outputSubBytes_s : type_state;
signal outputShiftRows_s : type_state;
signal outputMixColumns_s : type_state;
signal vectorAddRoundkey_s : bit128;
begin
	U0 : SubBytes
	port map(
		data_i => textState_s,
		data_o => outputSubBytes_s);

	U1 : ShiftRows
	port map(
		data_i => outputSubBytes_s,
		data_o => outputShiftRows_s);

	U2 : MixColumns
	port map(
		data_i => outputShiftRows_s,
		en_i => enableMixColumns_i,
		data_o => outputMixColumns_s);

	U3 : AddRoundkey
	port map(
		data_i => inputAddRoundKey_s,
		key_i => currentStateKey_s,
		data_o => data_s);

	-- convert text on 128bits to type state
	F0 : for i in 0 to 3 generate
		F1 : for j in 0 to 3 generate
			textState_s(i)(j) <= text_i(127-32*j-8*i downto 120-32*j-8*i);
		end generate;
	end generate;

	-- convert type state in 128bits vector
	F2 : for i in 0 to 3 generate
		F3 : for j in 0 to 3 generate
			data_o(127-32*j-8*i downto 120-32*j-8*i) <= data_s(i)(j);
		end generate;
	end generate;

	-- convert current key to type state
	F4 : for i in 0 to 3 generate
		F5 : for j in 0 to 3 generate
			currentStateKey_s(i)(j) <= currentKey_i(127-32*j-8*i downto 120-32*j-8*i);
		end generate;
	end generate;

	-- select AddRoundKey function input according to round computing (initial or next others)
	inputAddRoundKey_s <= outputMixColumns_s when enableRoundcomputing_i = '1' else textState_s;

end architecture AESRound_arch;

configuration AESRound_configuration of AESRound is
for AESRound_arch
	for U0 : SubBytes
		use entity lib_rtl.SubBytes(SubBytes_arch);
	end for;
	for U1 : ShiftRows
		use entity lib_rtl.ShiftRows(ShiftRows_arch);
	end for;
	for U2 : MixColumns
		use entity lib_rtl.MixColumns(MixColumns_arch);
	end for;
	for U3 : AddRoundKey
		use entity lib_rtl.AddRoundKey(AddRoundKey_arch);
	end for;
end for;
end configuration;
