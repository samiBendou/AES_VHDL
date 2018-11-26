--------------------------------------------------------------------------------
--@author DAHOUX Sami
--@date 21 Novembre 2017
--@component KeyExpansion_I_O
--------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library thirdparty;
use thirdparty.crypt_pack.all;

entity KeyExpansion_I_O is
	port( clock_i : in std_logic;
		resetb_i : in std_logic;
		start_i : in std_logic;
		end_o : out std_logic;
		round_i : in bit4;
		round_o : out bit4;
		key_i : in bit128;
		key_o : out bit128);
end entity KeyExpansion_I_O;

architecture KeyExpansion_I_O_arch of KeyExpansion_I_O is

component Counter
	port (clock_i : in std_logic;
		resetb_i : in std_logic;
		en_i : in std_logic;
		count_i : in bit4;
		count_o : out bit4);
end component;

component KeyExpansion_FSM
port (
	clock_i : in std_logic;
	resetb_i : in std_logic;
	start_i : in std_logic;
	count_i : in bit4;

	end_o : out std_logic;
	en_cpt_o : out std_logic;
	init_cpt_o : out std_logic);
end component;

component KeyExpansion
port (
	key_i : in bit128;
	key_o : out bit128;
	rcon_i : in bit8);
end component;

signal en_s : std_logic;
signal init_s : std_logic;

signal count_s : bit4;
signal rcon_s : bit8;


begin

Count: Counter port map (
	clock_i => clock_i,
	resetb_i => init_s,
	en_i => en_s,
	count_i => round_i,
	count_o => count_s);

FSM: KeyExpansion_FSM port map (
	clock_i => clock_i,
	resetb_i => resetb_i,
	start_i => start_i,
	count_i => count_s,
	end_o => end_o,
	init_cpt_o => init_s,
	en_cpt_o => en_s);

Calculus: KeyExpansion port map (
	key_i => key_i,
	key_o => key_o,
	rcon_i => rcon_s);

round_o <= count_s;
rcon_s <= Rcon(to_integer(unsigned(count_s)));

end architecture KeyExpansion_I_O_arch;
