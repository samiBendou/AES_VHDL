--------------------------------------------------------------------------------
--@author DAHOUX Sami
--@date 21 Novembre 2017
--@component KeyExpansion_FSM
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library thirdparty;
use thirdparty.crypt_pack.all;

entity KeyExpansion_FSM is
port (
	clock_i : in std_logic;
	resetb_i : in std_logic;
	start_i : in std_logic;
	count_i : in bit4;

	end_o : out std_logic;
	en_cpt_o : out std_logic;
	init_cpt_o : out std_logic);
end entity KeyExpansion_FSM;

architecture KeyExpansion_FSM_arch of KeyExpansion_FSM is

type state_keyexp_t is (init, reset, done, compute);
signal present_state, next_state : state_keyexp_t;

begin
C0 : process(present_state, start_i, count_i)
begin
	case present_state is
		when reset =>
			next_state <= init;
		when init =>
			if start_i = '1' then
				next_state <= compute;
			else
				next_state <= init;
			end if;
		when compute =>
			if to_integer(unsigned(count_i)) = 9 then
				next_state <= done;
			else
				next_state <= compute;
			end if;
		when done =>
				next_state <= done;
	end case;
end process C0;


C1 : process(present_state, next_state)
begin
	case present_state is
		when reset =>
			end_o <= '0';
			en_cpt_o <= '0';
			init_cpt_o <= '1';
		when init =>
			end_o <= '0';
			en_cpt_o <= '1';
			init_cpt_o <= '0';
		when compute =>
			end_o <= '0';
			en_cpt_o <= '1';
			init_cpt_o <= '0';
		when done =>
			end_o <= '1';
			en_cpt_o <= '0';
			init_cpt_o <= '1';
	end case;
end process C1;
end architecture KeyExpansion_FSM_arch;
