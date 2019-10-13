library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.ALL;

library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

library lib_rtl;
use lib_rtl.all;

entity AES_tb is
end entity AES_tb;

architecture AES_tb_arch of AES_tb is

	component AES
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
	end component;
		
	signal clock_s : std_logic := '1';
	signal reset_s : std_logic;
	signal start_s : std_logic;
	signal done_s : std_logic;

	signal text_s : bit128;
	signal key_s : bit128;
	signal cipher_s : bit128;
	
begin
	text_s <= X"3243f6a8885a308d313198a2e0370734";
	key_s <= X"2b7e151628aed2a6abf7158809cf4f3c";
	reset_s <= '1', '0' after 100 ns;
	clock_s <= not clock_s after 50 ns;

	DUT : AES
	port map(
		clock_i => clock_s,
		reset_i => reset_s,
		start_i => start_s,
		key_i => key_s,
		inv_i => '0',
		data_i => text_s,
		data_o => cipher_s,
		done_o => done_s
		);

	PUT : process
	begin
		start_s <= '0';
		wait for 200 ns;
		start_s <= '1';
		wait for 200 ns;
		start_s <= '0';
		wait for 3000 ns;
		start_s <= '1';
		wait for 120 ns;
	end process PUT;

end architecture AES_tb_arch;

configuration AES_tb_configuration of AES_tb is
for AES_tb_arch
	for DUT : AES
		for AES_arch
			for all : KeyExpansion
				use entity lib_rtl.KeyExpansion(KeyExpansion_arch);
			end for;
			for all : FSM_AES
				use entity lib_rtl.FSM_AES(FSM_AES_arch);
			end for;
			for all : AESRound
				use entity lib_rtl.AESRound(AESRound_arch);
			end for;
		end for;
	end for;
end for;
end configuration AES_tb_configuration;
