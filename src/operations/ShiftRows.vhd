--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 27 Octobre 2017
-- @component ShiftRows
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

entity ShiftRows is
    port (
		data_i: in type_state;
		en_i : in std_logic;
		inv_i : in std_logic;
        data_o: out type_state);
end entity ShiftRows;

architecture ShiftRows_arch of ShiftRows is

	signal data_s, data_inv_s : type_state;

begin
    data_o <= data_s when inv_i = '0' and en_i = '1' else
                data_inv_s when inv_i = '1' and en_i = '1' else
                data_i;

	row : for i in 0 to 3 generate
		col : for j in 0 to 3 generate
      		-- left shift i times
			data_s(i)(j) <= data_i(i)((j + i) mod 4);
			data_inv_s(i)((j + i) mod 4) <= data_i(i)(j);
		end generate;
	end generate;

end architecture ShiftRows_arch;
