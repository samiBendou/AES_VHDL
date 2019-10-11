library IEEE;
library lib_rtl;
library lib_thirdparty;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use lib_thirdparty.crypt_pack.all;
use lib_rtl.all;

entity AES_tb is
end entity AES_tb;

architecture AES_tb_arch of AES_tb is
component AES
port(	clock_i : in std_logic;
	reset_i : in std_logic;
	start_i : in std_logic;
	key_i : in  bit128;
        data_i : in bit128;
	data_o : out bit128;
	aes_on_o : out std_logic);
end component;
signal data_is : bit128;
signal key_is : bit128;
signal data_os : bit128;
signal done_os : std_logic;
signal reset_is : std_logic;
signal clock_is : std_logic;
signal start_is : std_logic;
begin
	DUT : AES
	port map(
		clock_i => clock_is,
		reset_i => reset_is,
		start_i => start_is,
		key_i => key_is,
		data_i => data_is,
		data_o => data_os,
		aes_on_o => done_os);

	P0 : process
	begin
		data_is <= X"526573746f20656e2076696c6c65203f";
		key_is <= X"2b7e151628aed2a6abf7158809cf4f3c";
		wait for 2500 ns;
		data_is <= X"3243f6a8885a308d313198a2e0370734";
		wait;
	end process P0;

	P1 : process
	begin
		reset_is <= '1';
		wait for 10 ns;
		reset_is <= '0';
		wait;
	end process P1;

	P2 : process
	begin
		start_is <= '0';
		wait for 100 ns;
		start_is <= '1';
		wait for 120 ns;
		start_is <= '0';
		wait for 3000 ns;
		start_is <= '1';
		wait for 120 ns;
		start_is <= '0';
		wait;
	end process P2;

	Pclk : process
	begin
		clock_is <= '0';
		wait for 50 ns;
		clock_is <= '1';
		wait for 50 ns;
	end process Pclk;

end architecture AES_tb_arch;

configuration AES_tb_configuration of AES_tb is
for AES_tb_arch
	for DUT : AES
		for AES_arch
			for U0 : KeyExpansion_I_O
				use entity lib_rtl.KeyExpansion_I_O(KeyExpansion_I_O_arch);
			end for;
			for U1 : FSM_AES
				use entity lib_rtl.FSM_AES(FSM_AES_arch);
			end for;
			for U2 : AESRound
				use entity lib_rtl.AESRound(AESRound_arch);
			end for;
		end for;
	end for;
end for;
end configuration AES_tb_configuration;
