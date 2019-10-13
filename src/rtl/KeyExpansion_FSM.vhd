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
	end_o : out std_logic;
	we_key_o : out std_logic;
	count_o : out bit4
	);
end entity KeyExpansion_FSM;

architecture KeyExpansion_FSM_arch of KeyExpansion_FSM is

	type state_type is (reset, hold, start, compute, done);

	signal current_state, next_state : state_type;
	signal count_s : integer range 0 to 11;

begin
	state_register : process ( clock_i, resetb_i ) is
	begin
		if resetb_i = '0' then
			current_state <= reset;
		elsif rising_edge(clock_i) then
			if start_i = '1' then
				count_s <= 0;
			elsif current_state = compute then
				count_s <= count_s + 1;
			end if;

			current_state <= next_state;
		end if;
	end process state_register;

	state_comb : process( current_state, start_i, count_s )
	begin
		case current_state is
			when reset =>
				next_state <= hold;
			when hold => 
				if start_i = '1' then
					next_state <= start;
				else
					next_state <= hold;
				end if;
			when start =>
					next_state <= compute;
			when compute =>
				if count_s = 10 then
					next_state <= done;
				else
					next_state <= compute;
				end if;
			when done =>
				next_state <= hold;
		end case;
	end process state_comb;

	out_comb : process( current_state, count_s )
	begin
		case current_state is
			when reset | hold =>
				end_o <= '0';
				we_key_o <= '0';
				count_o <= x"0";
			when start =>
				end_o <= '0';
				we_key_o <= '1';
				count_o <= std_logic_vector(to_unsigned(count_s, 4));
			when compute =>
				end_o <= '0';
				we_key_o <= '1';
				count_o <= std_logic_vector(to_unsigned(count_s, 4));
			when done =>
				end_o <= '1';
				we_key_o <= '0';
				count_o <= x"0";
		end case;
	end process out_comb;

end architecture KeyExpansion_FSM_arch;
