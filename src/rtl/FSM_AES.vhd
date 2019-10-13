library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

entity FSM_AES is
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
end FSM_AES;

architecture FSM_AES_arch  of FSM_AES is

	type state_type is (reset, hold, init, start_keyexpand, wait_keyexpand, round0, roundn, lastround, done);
	signal current_state, next_state : state_type;
	signal count_s : integer range 0 to 10;
	signal round_s : bit4;

begin
	state_register : process(clock_i, resetb_i, count_s)
	begin
		if resetb_i = '0' then
			current_state <= reset;
		elsif rising_edge(clock_i) then
			current_state <= next_state;
			if current_state = round0 then
				count_s <= 1;
			elsif current_state = roundn then
				count_s <= count_s + 1;
			end if;
		end if;
	end process state_register;

	state_comb : process( current_state, count_s, start_i, end_keyexp_i )
	begin
		case current_state is
			when reset =>
					next_state <= hold;
			when hold =>
					if start_i = '1' then
						next_state <= init;
					else
						next_state <= hold;
					end if;
			when init =>
					if (end_keyexp_i = '1') then
						next_state <= round0;
					else
						next_state <= start_keyexpand;
					end if;
			when start_keyexpand =>
					next_state <= wait_keyexpand;
			when wait_keyexpand =>
					if (end_keyexp_i = '1') then
						next_state <= round0;
					else
						next_state <= wait_keyexpand;
					end if;
			when round0 =>
					next_state <= roundn;
			when roundn =>
					if count_s = 9 then
						next_state <= lastround;
					else
						next_state <= roundn;
					end if;
			when lastround =>
					next_state <= done;
			when done =>
					next_state <= hold;
		end case;
	end process state_comb;

	out_comb : process( current_state, count_s )
	begin
		case current_state is
			when reset =>
				resetb_keyexp_o <= '0';
				start_keyexp_o <= '0';
				round_o <= x"0";
				en_mixcolumns_o <= '0';
				en_round_o <= '0';
				en_out_o <= '0';
				we_data_o <= '0';
				done_o <= '0';
			when hold =>
				resetb_keyexp_o <= '1';
				start_keyexp_o <= '0';
				round_o <= x"0";
				en_mixcolumns_o <= '0';
				en_round_o <= '0';
				en_out_o <= '1';
				done_o <= '0';
				we_data_o <= '0';
			when init =>
				resetb_keyexp_o <= '1';
				start_keyexp_o <= '0';
				round_o <= x"0";
				en_mixcolumns_o <= '0';
				en_round_o <= '0';
				en_out_o <= '0';
				done_o <= '0';
				we_data_o <= '0';
			when start_keyexpand =>
				resetb_keyexp_o <= '1';
				start_keyexp_o <= '1';
				round_o <= x"0";
				en_mixcolumns_o <= '0';
				en_round_o <= '0';
				en_out_o <= '0';
				done_o <= '0';
				we_data_o <= '0';
			when wait_keyexpand =>
				resetb_keyexp_o <= '1';
				start_keyexp_o <= '0';
				round_o <= x"0";
				en_mixcolumns_o <= '0';
				en_round_o <= '0';
				en_out_o <= '0';
				done_o <= '0';
				we_data_o <= '0';
			when round0 =>
				resetb_keyexp_o <= '1';
				start_keyexp_o <= '0';
				round_o <= x"0";
				en_mixcolumns_o <= '0';
				en_round_o <= '0';
				en_out_o <= '0';
				done_o <= '0';
				we_data_o <= '1';
			when roundn =>
				resetb_keyexp_o <= '1';
				start_keyexp_o <= '0';
				round_o <= std_logic_vector(to_unsigned(count_s, 4));
				en_mixcolumns_o <= '1';
				en_round_o <= '1';
				en_out_o <= '0';
				done_o <= '0';
				we_data_o <= '1';
			when lastround =>
				resetb_keyexp_o <= '1';
				start_keyexp_o <= '0';
				round_o <= std_logic_vector(to_unsigned(count_s, 4));
				en_mixcolumns_o <= '0';
				en_round_o <= '1';
				en_out_o <= '0';
				done_o <= '0';
				we_data_o <= '1';
			when done =>
				resetb_keyexp_o <= '1';
				start_keyexp_o <= '0';
				round_o <= x"0";
				en_mixcolumns_o <= '0';
				en_round_o <= '1';
				en_out_o <= '1';
				done_o <= '1';
				we_data_o <= '0';
		end case;
	end process out_comb;

end FSM_AES_arch;
