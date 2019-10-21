library ieee;
use ieee.std_logic_1164.all;

library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;
use lib_thirdparty.test_pack.all;

entity aes_pager is
    port ( 
        clock_i : in std_logic;
        reset_i : in std_logic;
        start_i : in std_logic;
        inv_i : in std_logic;
        sel_data_i : in bit4;
        page_data_o : out bit8
        );
end aes_pager;

architecture aes_pager_arch of aes_pager is
    component aes
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
    
    signal current_data_s, next_data_s, data_s : bit128;
    signal clock_s : std_logic;
begin
    clock_s <= clock_i; -- to change when implementing DCM
    data_s <= std_input_c when inv_i = '0' else std_output_c;

    cipher : aes
    port map (
        reset_i => reset_i,
        clock_i => clock_s,
        start_i => start_i,
        inv_i => inv_i,
        data_i => data_s,
        key_i => std_input_key_c,
        data_o => next_data_s
    );

    page_data_o <=  current_data_s(7 downto 0) when sel_data_i = "0000" else
                    current_data_s(15 downto 8) when sel_data_i = "0001" else
                    current_data_s(23 downto 16) when sel_data_i = "0010" else
                    current_data_s(31 downto 24) when sel_data_i = "0011" else
                    current_data_s(39 downto 32) when sel_data_i = "0100" else
                    current_data_s(47 downto 40) when sel_data_i = "0101" else
                    current_data_s(55 downto 48) when sel_data_i = "0110" else
                    current_data_s(63 downto 56) when sel_data_i = "0111" else
                    current_data_s(71 downto 64) when sel_data_i = "1000" else
                    current_data_s(79 downto 72) when sel_data_i = "1001" else
                    current_data_s(87 downto 80) when sel_data_i = "1010" else
                    current_data_s(95 downto 88) when sel_data_i = "1011" else
                    current_data_s(103 downto 96) when sel_data_i = "1100" else
                    current_data_s(111 downto 104) when sel_data_i = "1101" else
                    current_data_s(119 downto 112) when sel_data_i = "1110" else
                    current_data_s(127 downto 120) when sel_data_i = "1111" else 
                    (others => '0');

    
    data_out_reg : process(clock_s, reset_i)
    begin
        if reset_i = '1' then
            current_data_s <= (others => '0');
        elsif rising_edge(clock_s) then
            current_data_s <= next_data_s;
        end if;
    end process;

end aes_pager_arch;
