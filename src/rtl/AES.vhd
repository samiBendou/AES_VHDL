library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

entity AES is
port(	
    data_i : in bit128;
	key_i : in  bit128;
	clock_i : in std_logic;
	reset_i : in std_logic;
	start_i : in std_logic;
	inv_i : in std_logic;
	data_o : out bit128;
	done_o : out std_logic
	);
end entity AES;

architecture AES_arch of AES is

	component KeyExpansion
	port ( 
		key_i : in bit128;
		clock_i : in std_logic;
		resetb_i : in std_logic;
		start_i : in std_logic;
		count_i : in bit4;
		end_o : out std_logic;
		key_o : out type_expanded_key
		);
	end component;
	component FSM_AES
	port ( 
		resetb_i : in  std_logic;
		clock_i : in  std_logic;
		start_i : in  std_logic;
		count_i : in bit4;
		end_keyexp_i : in std_logic;
		start_keyexp_o : out std_logic;
		en_mixcolumns_o : out std_logic;
		en_round_o : out std_logic;
		en_out_o : out std_logic;
		en_count_o : out std_logic;
		we_data_o : out std_logic;
		data_src_o : out std_logic;
		done_o : out std_logic
		);
	end component;
	component AESRound
	port(	
		data_i : in bit128;
		key_i : in bit128;
		en_mixcolumns_i : in std_logic;
		en_round_i : in std_logic;
		inv_i : in std_logic;
		data_o : out bit128
		);
	end component;
	component counter11
	port(
		clock_i : in std_logic;
		resetb_i : in std_logic;
		en_i : in std_logic;
		count_i : in bit4;
		count_o : out bit4
	);
	end component;
	component reg128
	port(
		data_i : in bit128;
		resetb_i : in std_logic;
		clock_i : in std_logic;
		we_i : in std_logic;
		data_o : out bit128
	);
	end component;

	signal resetb_s : std_logic;

	signal en_mixcolumns_s : std_logic;
	signal en_round_s : std_logic;
	signal en_count_s : std_logic;
	signal en_out_s : std_logic;
	signal we_data_s : std_logic;
	signal data_src_s : std_logic;

	signal start_keyexp_s : std_logic;
	signal end_keyexp_s : std_logic;

	signal count_s : bit4;
	signal data_s, round_data_s, reg_data_s : bit128;
	signal key_s : bit128;
	signal keyexp_s : type_expanded_key;
	
begin
	resetb_s <= not reset_i;
	key_s <= keyexp_s(to_integer(unsigned(count_s)));
	data_o <= reg_data_s when en_out_s = '1' else (others => '0');
	data_s <= data_i when data_src_s = '1' else round_data_s;

	reg : reg128
	port map(
		data_i => data_s,
		resetb_i => resetb_s,
		clock_i => clock_i,
		we_i => we_data_s,
		data_o => reg_data_s
	);

	keyexp : KeyExpansion
	port map(
		key_i => key_i,
		clock_i => clock_i,
		count_i => count_s,
	   	resetb_i => resetb_s,
	   	start_i => start_keyexp_s,
	   	end_o => end_keyexp_s,
	   	key_o => keyexp_s
       	);

	fsm : FSM_AES
	port map(
		resetb_i => resetb_s,
		clock_i => clock_i,
		start_i => start_i,
		count_i => count_s,
		end_keyexp_i => end_keyexp_s,
		start_keyexp_o => start_keyexp_s,
		en_mixcolumns_o => en_mixcolumns_s,
		en_round_o => en_round_s,
		en_out_o => en_out_s,
		en_count_o => en_count_s,
		we_data_o => we_data_s,
		data_src_o => data_src_s,
		done_o => done_o
		);

	round : AESRound
	port map(
		data_i => reg_data_s,
		key_i => key_s,
		en_mixcolumns_i => en_mixcolumns_s,
		en_round_i => en_round_s,
		inv_i => inv_i,
		data_o => round_data_s
		);

	count : counter11
	port map(
		clock_i => clock_i,
		resetb_i => resetb_s,
		en_i => en_count_s,
		count_i => x"0",
		count_o => count_s
		);

end architecture AES_arch;
