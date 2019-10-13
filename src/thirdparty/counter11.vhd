library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

entity counter11 is
  port (
    clock_i : in std_logic;
    resetb_i : in std_logic;
    en_i : in std_logic;
    count_i : in bit4;
    count_o : out bit4
  );
end counter11;

architecture counter11_arch of counter11 is

  signal count_s : integer range 0 to 11;

begin

  count_o <= std_logic_vector(to_unsigned(count_s, 4));

  count : process( clock_i, resetb_i )
  begin
    if (resetb_i = '0') then
      count_s <= 0;
    elsif rising_edge(clock_i) then
      if en_i = '0' or count_s = to_integer(unsigned(count_i)) + 10 then
        count_s <= to_integer(unsigned(count_i));
      elsif en_i = '1' then
        count_s <= count_s + 1;
      end if;
    end if;
  end process ; -- count

end counter11_arch ; -- counter11_arch