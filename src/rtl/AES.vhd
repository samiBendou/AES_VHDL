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
		end_o : out std_logic;
		key_o : out type_expanded_key
		);
	end component;
	component FSM_AES
	port ( 
		resetb_i : in  std_logic;
		clock_i : in  std_logic;
		start_i : in  std_logic;
		end_keyexp_i : in std_logic;
		round_o : out bit4;
		resetb_keyexp_o : out std_logic;
		start_keyexp_o : out std_logic;
		en_mixcolumns_o : out std_logic;
		en_round_o : out std_logic;
		we_data_o : out std_logic;
		en_out_o : out std_logic;
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

	signal resetb_s : std_logic;
	signal en_mixcolumns_s : std_logic;
	signal en_round_s : std_logic;
	signal we_data_s : std_logic;
	signal round_s : bit4;

	signal start_keyexp_s : std_logic;
	signal resetb_keyexp_s : std_logic;
	signal end_keyexp_s : std_logic;

	signal data_is, data_os : bit128;
	signal key_s : bit128;
	signal keyexp_s : type_expanded_key;

	signal en_s : std_logic;

begin
	resetb_s <= not reset_i;
	key_s <= keyexp_s(to_integer(unsigned(round_s)));
	data_o <= data_is when en_s = '1' else (others => '0');

	data_register : process( clock_i, reset_i )
	begin
		if reset_i = '1' then
			data_is <= data_i;
		elsif rising_edge(clock_i) then
			if start_i = '1' then
				data_is <= data_i;
			elsif we_data_s = '1' then
				data_is <= data_os;
			end if;
		end if;
	end process ; -- data_register

	keyexp : KeyExpansion
	port map(
		key_i => key_i,
	   	clock_i => clock_i,
	   	resetb_i => resetb_keyexp_s,
	   	start_i => start_keyexp_s,
	   	end_o => end_keyexp_s,
	   	key_o => keyexp_s
       	);

	fsm : FSM_AES
	port map(
		resetb_i => resetb_s,
		clock_i => clock_i,
		start_i => start_i,
		end_keyexp_i => end_keyexp_s,
		round_o => round_s,
		resetb_keyexp_o => resetb_keyexp_s,
		start_keyexp_o => start_keyexp_s,
		en_mixcolumns_o => en_mixcolumns_s,
		en_round_o => en_round_s,
        en_out_o => en_s,
		done_o => done_o,
		we_data_o => we_data_s
		);

	round : AESRound
	port map(
		data_i => data_is,
		key_i => key_s,
		en_mixcolumns_i => en_mixcolumns_s,
		en_round_i => en_round_s,
		inv_i => inv_i,
		data_o => data_os
		);

end architecture AES_arch;
