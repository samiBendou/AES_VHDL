--------------------------------------------------------------------------------
--@author DAHOUX Sami
--@date 27 Octobre 2017
--@component ShiftRows
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library thirdparty;
use thirdparty.crypt_pack.all;

entity ShiftRows is
    port (
        data_i: in type_state;
        data_o: out type_state);
end entity ShiftRows;

architecture ShiftRows_arch of ShiftRows is

begin
	row : for i in 0 to 3 generate
		col : for j in 0 to 3 generate
      -- left shift i times
			data_o(i)(j) <= data_i(i)((j + i) mod 4);
		end generate;
	end generate;

end architecture ShiftRows_arch;
