library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

entity AES is
port(	clock_i : in std_logic;
	reset_i : in std_logic;
	start_i : in std_logic;
	key_i : in  bit128;
        data_i : in bit128;
	data_o : out bit128;
	aes_on_o : out std_logic);
end entity AES;

architecture AES_arch of AES is
component KeyExpansion_I_O
    Port ( key_i : in  bit128;
	   clock_i : in std_logic;
	   resetb_i : in std_logic;
	   start_i : in std_logic;
	   round_i : in bit4;
	   end_o : out std_logic;
           key_o : out type_expanded_key);
end component;
component FSM_AES
    Port ( resetb_i : in  STD_LOGIC;
           clock_i : in  STD_LOGIC;
           start_i : in  STD_LOGIC;
	   reset_key_expander_o : out std_logic;
	   start_key_expander_o : out std_logic;
	   round_key_expander_o : out bit4;
	   end_key_expander_i : in std_logic;
	   enableMixcolumns_o : out std_logic;
	   enableRoundcomputing_o : out std_logic;
	   enableOutput_o : out std_logic;
	   done_o : out std_logic;
	   we_DataRegister_o : out std_logic);
end component;
component AESRound
port(	text_i : in bit128;
	currentkey_i : in bit128;
	data_o : out bit128;
	clock_i : in std_logic;
	resetb_i : in std_logic;
	enableMixcolumns_i : in std_logic;
	enableRoundcomputing_i : in std_logic);
end component;

signal resetb_s : std_logic;
signal reset_keyexpander_s : std_logic;
signal start_keyexpander_s : std_logic;
signal round_keyexpander_s : bit4;
signal end_keyexpander_s : std_logic;
signal data_is, data_os : bit128;
signal outputKeyExpander_s : type_expanded_key;
signal enableMixcolumns_s : std_logic;
signal enableRoundcomputing_s : std_logic;
signal currentkey_s : bit128;
signal we_DataRegister_s : std_logic;

signal enableOutput_s : std_logic;

begin
	-- positive reset
	resetb_s <= not reset_i;
	data_o <= data_is when enableOutput_s = '1' else (others => '0');
	currentkey_s <= outputKeyExpander_s(to_integer(unsigned(round_keyexpander_s)));
	-- key expander component
	U0 : KeyExpansion_I_O
	port map(
	   clock_i => clock_i,
	   resetb_i => reset_keyexpander_s,
	   start_i => start_keyexpander_s,
	   round_i => round_keyexpander_s,
	   key_i => key_i,
	   key_o => outputKeyExpander_s,
	   end_o => end_keyexpander_s
       );

	U1 : FSM_AES
	Port map(
		resetb_i => resetb_s,
		clock_i => clock_i,
		start_i => start_i,
		reset_key_expander_o => reset_keyexpander_s,
		start_key_expander_o => start_keyexpander_s,
		round_key_expander_o => round_keyexpander_s,
		end_key_expander_i => end_keyexpander_s,
		enableMixcolumns_o => enableMixColumns_s,
		enableRoundComputing_o => enableRoundComputing_s,
        enableOutput_o => enableOutput_s,
		done_o => aes_on_o,
		we_DataRegister_o => we_DataRegister_s);

	U2 : AESRound
	port map(
		text_i => data_is,
		currentkey_i => currentkey_s,
		data_o => data_os,
		clock_i => clock_i,
		resetb_i => resetb_s,
		enableMixcolumns_i => enableMixColumns_s,
		enableRoundcomputing_i => enableRoundComputing_s);

	data_register : process( clock_i, reset_i )
	begin
		if reset_i = '1' then
			data_is <= data_i;
		elsif rising_edge(clock_i) then -- rising edge
			if start_i = '1' then
				data_is <= data_i;
			elsif we_DataRegister_s = '1' then
				data_is <= data_os;
			end if;
		end if;
	end process ; -- data_register

end architecture AES_arch;
