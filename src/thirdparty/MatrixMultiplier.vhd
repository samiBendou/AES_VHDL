library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

entity MatrixMultiplier is
port(   
	data_i : in column_state;
	inv_i : in std_logic;
	data_o : out column_state
	);
end MatrixMultiplier;

architecture MatrixMultiplier_arch of MatrixMultiplier is
signal data2_s : column_state;
signal data4_s : column_state;
signal data8_s : column_state;
signal data3_s : column_state;
signal data9_s : column_state;
signal datab_s : column_state;
signal datad_s : column_state;
signal datae_s : column_state;

signal data_s, data_inv_s : column_state;

begin
	data_o <= data_s when inv_i = '0' else data_inv_s;

	even_prod : for j in 0 to 3 generate
		data2_s(j) <= (data_i(j)(6 downto 0) & '0') xor "00011011" when data_i(j)(7) = '1'  else data_i(j)(6 downto 0) & '0';
		data4_s(j) <= (data2_s(j)(6 downto 0) & '0') xor "00011011" when data2_s(j)(7) = '1'  else data2_s(j)(6 downto 0) & '0';
		data8_s(j) <= (data4_s(j)(6 downto 0) & '0') xor "00011011" when data4_s(j)(7) = '1'  else data4_s(j)(6 downto 0) & '0';	
	end generate;

	odd_prod : for j in 0 to 3 generate
		data3_s(j) <= data2_s(j) xor data_i(j);
		data9_s(j) <= data8_s(j) xor data_i(j);
		datab_s(j) <= (data8_s(j) xor data2_s(j)) xor data_i(j);
		datad_s(j) <= (data8_s(j) xor data4_s(j)) xor data_i(j);
		datae_s(j) <= (data8_s(j) xor data4_s(j)) xor data2_s(j);
	end generate;

	data_s(0) <= data2_s(0) xor data3_s(1) xor data_i(2) xor data_i(3);
	data_s(1) <= data_i(0) xor data2_s(1) xor data3_s(2) xor data_i(3);
	data_s(2) <= data_i(0) xor data_i(1) xor data2_s(2) xor data3_s(3);
	data_s(3) <= data3_s(0) xor data_i(1) xor data_i(2) xor data2_s(3);

	data_inv_s(0) <= datae_s(0) xor datab_s(1) xor datad_s(2) xor data9_s(3);
	data_inv_s(1) <= data9_s(0) xor datae_s(1) xor datab_s(2) xor datad_s(3);
	data_inv_s(2) <= datad_s(0) xor data9_s(1) xor datae_s(2) xor datab_s(3);
	data_inv_s(3) <= datab_s(0) xor datad_s(1) xor data9_s(2) xor datae_s(3);
	
end architecture MatrixMultiplier_arch;

