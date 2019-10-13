 --------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 16 Décembre 2017
-- @component AddRoundKey
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

entity AddRoundKey is
    port (
        data_i: in type_state;
        key_i: in type_state;
        en_i: in std_logic;
        data_o: out type_state);
end entity AddRoundKey;

architecture AddRoundKey_arch of AddRoundKey is

    signal data_s : type_state;
begin
    data_o <= data_s when en_i = '1' else data_i;
        
    raw : for i in 0 to 3 generate
        col : for j in 0 to 3 generate
            data_s(i)(j) <= data_i(i)(j) xor key_i(i)(j);
        end generate;
    end generate;

end architecture AddRoundKey_arch;
