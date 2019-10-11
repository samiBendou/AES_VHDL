--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 19 Novembre 2018
-- @component InvShiftRows
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

entity InvShiftRows is
    port (
        data_i: in type_state;
        data_o: out type_state);
end entity InvShiftRows;

architecture InvShiftRows_arch of InvShiftRows is

begin
	row : for i in 0 to 3 generate
		col : for j in 0 to 3 generate
      -- right shift i times
			data_o(i)((j + i) mod 4) <= data_i(i)(j);
		end generate;
	end generate;

end architecture InvShiftRows_arch;
