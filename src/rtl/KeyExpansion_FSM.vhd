--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 21 Novembre 2017
-- @component KeyExpansion_FSM
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

entity KeyExpansion_FSM is
port (
	clock_i : in std_logic;
	resetb_i : in std_logic;
	start_i : in std_logic;
	count_i : in bit4;

	end_o : out std_logic;
	en_cpt_o : out std_logic);
end entity KeyExpansion_FSM;

architecture KeyExpansion_FSM_arch of KeyExpansion_FSM is

type state_keyexp_t is (reset, hold, compute, done);
signal present_state, next_state : state_keyexp_t;

begin
	sequentiel : process (clock_i, resetb_i) is
	begin
		if(resetb_i = '0') then
			present_state <= reset;
		elsif rising_edge(clock_i) then -- rising edge
			present_state <= next_state;
		end if;
	end process sequentiel;

	C0 : process(present_state, start_i, count_i)
	begin
		case present_state is
			when reset =>
				next_state <= hold;
			when hold => 
				if start_i = '1' then
					next_state <= compute;
				else
					next_state <= hold;
				end if;
			when compute =>
				if to_integer(unsigned(count_i)) = 9 then
					next_state <= done;
				else
					next_state <= compute;
				end if;
			when done =>
				next_state <= hold;
		end case;
	end process C0;

	C1 : process(present_state, next_state)
	begin
		case present_state is
			when reset =>
				end_o <= '0';
				en_cpt_o <= '0';
			when hold =>
				end_o <= '0';
				en_cpt_o <= '0';
			when compute =>
				end_o <= '0';
				en_cpt_o <= '1';
			when done =>
				end_o <= '1';
				en_cpt_o <= '0';
		end case;
	end process C1;

end architecture KeyExpansion_FSM_arch;
