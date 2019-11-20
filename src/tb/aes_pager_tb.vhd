library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;
use lib_thirdparty.test_pack.all;

library lib_rtl;
use lib_rtl.all;

entity aes_pager_tb is
end aes_pager_tb;

architecture aes_pager_tb_arch of aes_pager_tb is

    component aes_pager
    port (
        clock_i : in std_logic;
        reset_i : in std_logic;
        start_i : in std_logic;
        inv_i : in std_logic;
        sel_data_i : in bit4;
        page_data_o : out bit8
    );
    end component;

    signal clock_s : std_logic := '1';
    signal reset_s : std_logic := '1';
    signal start_s : std_logic;
    signal inv_s : std_logic := '0';
    signal sel_data_s : bit4;
    signal page_data_s : bit8;
    signal page_data_es : bit8;
    signal cond_s : boolean;
begin
    clock_s <= not clock_s after 50 ns;
    reset_s <= '0' after 200 ns;

	DUT : aes_pager
	port map(
		clock_i => clock_s,
		reset_i => reset_s,
        start_i => start_s,
        inv_i => inv_s,
		sel_data_i => sel_data_s,
		page_data_o => page_data_s
        );
        
    PUT : process
    begin
        start_s <= '0';
        wait for 200 ns;
        start_s <= '1';
        wait for 200 ns;
        start_s <= '0';
        page_data_es <= x"00";

        wait for 1400 ns;

        page_expect : for k in 0 to 15 loop
            sel_data_s <= std_logic_vector(to_unsigned(k, 4));
            if inv_s = '0' then
                page_data_es <= std_output_c(8 * (k + 1) - 1 downto 8 * k);
            else
                page_data_es <= std_input_c(8 * (k + 1) - 1 downto 8 * k);
            end if;
            wait for 100 ns;
        end loop ; -- page_expect

        inv_s <= not inv_s;

    end process ; -- PUT

	cond_s <= page_data_es = page_data_s;
	assert cond_s report "output differs from expected output" severity error;

end aes_pager_tb_arch ; -- aes_pager_tb_arch