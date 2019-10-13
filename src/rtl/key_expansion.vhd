--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 21 Novembre 2017
-- @component key_expansion
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;
use lib_thirdparty.all;

entity key_expansion is
	port( 
		key_i : in bit128;
		clock_i : in std_logic;
		resetb_i : in std_logic;
		start_i : in std_logic;
		count_i : in bit4;
		end_o : out std_logic;
		key_o : out keyexp_t
		);
end entity key_expansion;

architecture key_expansion_arch of key_expansion is

	component key_expansion_fsm
	port (
		clock_i : in std_logic;
		resetb_i : in std_logic;
		start_i : in std_logic;
		count_i : in bit4;
		end_o : out std_logic;
		we_key_o : out std_logic
		);
	end component;
	component key_expander
	port (
		key_i : in bit128;
		key_o : out bit128;
		rcon_i : in bit8
		);
	end component;
	component state_reg
	port (
		data_i : in bit128;
		resetb_i : in std_logic;
		clock_i : in std_logic;
		we_i : in std_logic;
		data_o : out bit128
		);
	end component;

	signal en_s : std_logic;
	signal we_key_s : std_logic;

	signal rcon_s : bit8;
	signal expander_is, expander_os : bit128;
	signal key_s : keyexp_t;
	signal we_s : bit11;

begin
	rcon_s <= rcon_c(to_integer(unsigned(count_i)));
	expander_is <= key_s(to_integer(unsigned(count_i)));
	key_o <= key_s;

	we_s(0) <= '1' and we_key_s when count_i = x"0" else '0';
	we_seq : for k in 1 to 10 generate
		we_s(k) <= '1' and we_key_s when count_i = std_logic_vector(to_unsigned(k - 1, 4)) else '0';	
    end generate ; -- we_seq

	fsm: key_expansion_fsm port map (
		clock_i => clock_i,
		resetb_i => resetb_i,
		start_i => start_i,
		count_i => count_i,
		end_o => end_o,
		we_key_o => we_key_s
		);

	expander: key_expander 
	port map (
		key_i => expander_is,
		rcon_i => rcon_s,
		key_o => expander_os
		);
		
	key_register : for k in 0 to 10 generate
		key_register0: if k = 0 generate
			reg0: state_reg
			port map(
				data_i => key_i,
				clock_i => clock_i,
				resetb_i => resetb_i,
				we_i => we_s(0),
				data_o => key_s(0)
				);
		end generate;
		key_registern : if k > 0 generate
			reg: state_reg
			port map(
				data_i => expander_os,
				clock_i => clock_i,
				resetb_i => resetb_i,
				we_i => we_s(k),
				data_o => key_s(k)
				);
		end generate;
	end generate ; -- key_register
end architecture key_expansion_arch;