--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes,
--		 constants, and functions


library IEEE;
use IEEE.STD_LOGIC_1164.all;
package crypt_pack is
	subtype bit4 is std_logic_vector(3 downto 0);
	subtype bit8 is std_logic_vector(7 downto 0);
	subtype bit16 is std_logic_vector(15 downto 0);
	subtype bit32 is std_logic_vector(31 downto 0);
	subtype bit128 is std_logic_vector(127 downto 0);

	type sbox_t is array(0 to 255) of  bit8;
	type row_state is array(0 to 3) of bit8; --tableau allant de 0 à 3 (pas de 0 à 2)
	type column_state is array(0 to 3) of bit8;
	type type_state is array(0 to 3) of row_state;
	type type_shift is array(0 to 3) of integer range 0 to 3;
	type type_temp is array(0 to 3) of bit8;
	type row_key is array(0 to 3) of bit8;
	type type_key is array(0 to 3) of row_key;
	type reg_w is array(0 to 3) of bit32;
	type type_rcon is array(0 to 10) of bit8;
	type type_word is array(0 to 3) of column_state;
	type key_memory is array(0 to 10) of bit128;
	type type_expanded_key is array(0 to 10) of bit128;
	type type_test_data is array(0 to 10) of type_state;
	-- Constant rcon
	constant Rcon : type_rcon := (
		X"01", X"02", X"04", X"08", X"10", X"20", X"40", X"80", X"1b", X"36", X"00"
		);


		constant std_input_c : type_state :=
	(
		(x"32", x"88", x"31", x"e0"),
		(x"43", x"5a", x"31", x"37"),
		(x"f6", x"30", x"98", x"07"),
		(x"a8", x"8d", x"a2", x"34") 
	);

	constant std_output_c : type_state :=
	(
		(x"39", x"02", x"dc", x"19"),
		(x"25", x"dc", x"11", x"6a"),
		(x"84", x"09", x"85", x"0b"),
		(x"1d", x"fb", x"97", x"32")
	);

	constant std_round_data_c : type_test_data :=
	(
		( 
			(x"19", x"a0", x"9a", x"e9"),
			(x"3d", x"f4", x"c6", x"f8"),
			(x"e3", x"e2", x"8d", x"48"),
			(x"be", x"2b", x"2a", x"08") 
		),
		(
			(x"a4", x"68", x"6b", x"02"),
			(x"9c", x"9f", x"5b", x"6a"),
			(x"7f", x"35", x"ea", x"50"),
			(x"f2", x"2b", x"43", x"49")
		),
		(   
			(x"aa", x"61", x"82", x"68"),
			(x"8f", x"dd", x"d2", x"32"),
			(x"5f", x"e3", x"4a", x"46"),
			(x"03", x"ef", x"d2", x"9a")
		),
		(
			(x"48", x"67", x"4d", x"d6"),
			(x"6c", x"1d", x"e3", x"5f"),
			(x"4e", x"9d", x"b1", x"58"),
			(x"ee", x"0d", x"38", x"e7")
		),   
		(
			(x"e0", x"c8", x"d9", x"85"),
			(x"92", x"63", x"b1", x"b8"),
			(x"7f", x"63", x"35", x"be"),
			(x"e8", x"c0", x"50", x"01") 
		),
		(

			(x"f1", x"c1", x"7c", x"5d"),
			(x"00", x"92", x"c8", x"b5"),
			(x"6f", x"4c", x"8b", x"d5"),
			(x"55", x"ef", x"32", x"0c")
		),
		(
			(x"26", x"3d", x"e8", x"fd"),
			(x"0e", x"41", x"64", x"d2"),
			(x"2e", x"b7", x"72", x"8b"),
			(x"17", x"7d", x"a9", x"25")
		),
		(
			(x"5a", x"19", x"a3", x"7a"),
			(x"41", x"49", x"e0", x"8c"),
			(x"42", x"dc", x"19", x"04"),
			(x"b1", x"1f", x"65", x"0c")
		),
		(
			(x"ea", x"04", x"65", x"85"),
			(x"83", x"45", x"5d", x"96"),
			(x"5c", x"33", x"98", x"b0"),
			(x"f0", x"2d", x"ad", x"c5") 
		),
		(
			(x"eb", x"59", x"8b", x"1b"),
			(x"40", x"2e", x"a1", x"c3"),
			(x"f2", x"38", x"13", x"42"),
			(x"1e", x"84", x"e7", x"d2") 
		),
			(
			(x"39", x"02", x"dc", x"19"),
			(x"25", x"dc", x"11", x"6a"),
			(x"84", x"09", x"85", x"0b"),
			(x"1d", x"fb", x"97", x"32")
		)
	);

	constant std_shiftrows_data_c : type_test_data := 
	(
		(
			(x"32", x"88", x"31", x"e0"),
			(x"43", x"5a", x"31", x"37"),
			(x"f6", x"30", x"98", x"07"),
			(x"a8", x"8d", x"a2", x"34")
		),
		(
			(x"d4", x"e0", x"b8", x"1e"),
			(x"bf", x"b4", x"41", x"27"),
			(x"5d", x"52", x"11", x"98"),
			(x"30", x"ae", x"f1", x"e5")
		),
		(
			(x"49", x"45", x"7f", x"77"),
			(x"db", x"39", x"02", x"de"),
			(x"87", x"53", x"d2", x"96"),
			(x"3b", x"89", x"f1", x"1a")
		),
		(
			(x"ac", x"ef", x"13", x"45"),
			(x"c1", x"b5", x"23", x"73"),
			(x"d6", x"5a", x"cf", x"11"),
			(x"b8", x"7b", x"df", x"b5")
		),
		(
			(x"52", x"85", x"e3", x"f6"),
			(x"a4", x"11", x"cf", x"50"),
			(x"c8", x"6a", x"2f", x"5e"),
			(x"94", x"28", x"d7", x"07")
		),
		(
			(x"e1", x"e8", x"35", x"97"),
			(x"fb", x"c8", x"6c", x"4f"),
			(x"96", x"ae", x"d2", x"fb"),
			(x"7c", x"9b", x"ba", x"53")
		),
		(

			(x"a1", x"78", x"10", x"4c"),
			(x"4f", x"e8", x"d5", x"63"),
			(x"3d", x"03", x"a8", x"29"),
			(x"fe", x"fc", x"df", x"23")
		),
		(
			(x"f7", x"27", x"9b", x"54"),
			(x"83", x"43", x"b5", x"ab"),
			(x"40", x"3d", x"31", x"a9"),
			(x"3f", x"f0", x"ff", x"d3")
		),
		(
			(x"be", x"d4", x"0a", x"da"),
			(x"3b", x"e1", x"64", x"83"),
			(x"d4", x"f2", x"2c", x"86"),
			(x"fe", x"c8", x"c0", x"4d")
		),
		(
			(x"87", x"f2", x"4d", x"97"),
			(x"6e", x"4c", x"90", x"ec"),
			(x"46", x"e7", x"4a", x"c3"),
			(x"a6", x"8c", x"d8", x"95")
		),	
		(
			(x"e9", x"cb", x"3d", x"af"),
			(x"31", x"32", x"2e", x"09"),
			(x"7d", x"2c", x"89", x"07"),
			(x"b5", x"72", x"5f", x"94")
		)
	);

	constant std_mixcolumns_data_c : type_test_data :=
	(
		(
			(x"32", x"88", x"31", x"e0"),
			(x"43", x"5a", x"31", x"37"),
			(x"f6", x"30", x"98", x"07"),
			(x"a8", x"8d", x"a2", x"34")
		),
		(
			(x"04",x"e0" ,x"48" , x"28"),
			(x"66",x"cb" ,x"f8" , x"06"),
			(x"81",x"19" ,x"d3" , x"26"),
			(x"e5",x"9a" ,x"7a" , x"4c")
		),
		(
			(x"58",x"1b" ,x"db" , x"1b"),
			(x"4d",x"4b" ,x"e7" , x"6b"),
			(x"ca",x"5a" ,x"ca" , x"b0"),
			(x"f1",x"ac" ,x"a8" , x"e5")
		),
		(
			(x"75", x"20", x"53", x"bb"),
			(x"ec", x"0b", x"c0", x"25"),
			(x"09", x"63", x"cf", x"d0"),
			(x"93", x"33", x"7c", x"dc")
		),
		(
			(x"0f", x"60", x"6f", x"5e"),
			(x"d6", x"31", x"c0", x"b3"),
			(x"da", x"38", x"10", x"13"),
			(x"a9", x"bf", x"6b", x"01")
		),
		(
			(x"25", x"bd", x"b6", x"4c"),
			(x"d1", x"11", x"3a", x"4c"),
			(x"a9", x"d1", x"33", x"c0"),
			(x"ad", x"68", x"8e", x"b0")
		),
		(
			(x"4b", x"2c", x"33", x"37"),
			(x"86", x"4a", x"9d", x"d2"),
			(x"8d", x"89", x"f4", x"18"),
			(x"6d", x"80", x"e8", x"d8") 
		),
		(
			(x"14", x"46", x"27", x"34"),
			(x"15", x"16", x"46", x"2a"),
			(x"b5", x"15", x"56", x"d8"),
			(x"bf", x"ec", x"d7", x"43") 
		),
		(
			(x"00", x"b1", x"54", x"fa"),
			(x"51", x"c8", x"76", x"1b"),
			(x"2f", x"89", x"6d", x"99"),
			(x"d1", x"ff", x"cd", x"ea") 
		),
		(
			(x"47", x"40", x"a3", x"4c"),
			(x"37", x"d4", x"70", x"9f"),
			(x"94", x"e4", x"3a", x"42"),
			(x"ed", x"a5", x"a6", x"bc")
		),
		(
			(x"e9", x"cb", x"3d", x"af"),
			(x"31", x"32", x"2e", x"09"),
			(x"7d", x"2c", x"89", x"07"),
			(x"b5", x"72", x"5f", x"94")
		)
	);

	constant std_subbytes_data_c : type_test_data :=
	(
		(
			(x"32", x"88", x"31", x"e0"),
			(x"43", x"5a", x"31", x"37"),
			(x"f6", x"30", x"98", x"07"),
			(x"a8", x"8d", x"a2", x"34") 
		),
		(
			(x"d4", x"e0", x"b8", x"1e"),
			(x"27", x"bf", x"b4", x"41"),
			(x"11", x"98", x"5d", x"52"),
			(x"ae", x"f1", x"e5", x"30") 
		),
		(
			(x"49", x"45", x"7f", x"77"),
			(x"de", x"db", x"39", x"02"),
			(x"d2", x"96", x"87", x"53"),
			(x"89", x"f1", x"1a", x"3b")
		),
		(
			(x"ac", x"ef", x"13", x"45"),
			(x"73", x"c1", x"b5", x"23"),
			(x"cf", x"11", x"d6", x"5a"),
			(x"7b", x"df", x"b5", x"b8")
		),
		(
			(x"52", x"85", x"e3", x"f6"),
			(x"50", x"a4", x"11", x"cf"),
			(x"2f", x"5e", x"c8", x"6a"),
			(x"28", x"d7", x"07", x"94") 
		),
		(
			(x"e1", x"e8", x"35", x"97"),
			(x"4f", x"fb", x"c8", x"6c"),
			(x"d2", x"fb", x"96", x"ae"),
			(x"9b", x"ba", x"53", x"7c")
		),
		(
			(x"a1", x"78", x"10", x"4c"),
			(x"63", x"4f", x"e8", x"d5"),
			(x"a8", x"29", x"3d", x"03"),
			(x"fc", x"df", x"23", x"fe")
		),
		(
			(x"f7", x"27", x"9b", x"54"),
			(x"ab", x"83", x"43", x"b5"),
			(x"31", x"a9", x"40", x"3d"),
			(x"f0", x"ff", x"d3", x"3f") 
		),
		(
			(x"be", x"d4", x"0a", x"da"),
			(x"83", x"3b", x"e1", x"64"),
			(x"2c", x"86", x"d4", x"f2"),
			(x"c8", x"c0", x"4d", x"fe") 
		),
		(
			(x"87", x"f2", x"4d", x"97"),
			(x"ec", x"6e", x"4c", x"90"),
			(x"4a", x"c3", x"46", x"e7"),
			(x"8c", x"d8", x"95", x"a6") 
		),
		(
			(x"e9", x"cb", x"3d", x"af"),
			(x"09", x"31", x"32", x"2e"),
			(x"89", x"07", x"7d", x"2c"),
			(x"72", x"5f", x"94", x"b5")
		)
	);

	constant std_round_key_c : type_test_data :=
	(
		(
			(x"2b", x"28", x"ab", x"09"),
			(x"7e", x"ae", x"f7", x"cf"),
			(x"15", x"d2", x"15", x"4f"),
			(x"16", x"a6", x"88", x"3c") 
		),
		(
			(x"a0", x"88", x"23", x"2a"),
			(x"fa", x"54", x"a3", x"6c"),
			(x"fe", x"2c", x"39", x"76"),
			(x"17", x"b1", x"39", x"05") 
		),
		(
			(x"f2", x"7a", x"59", x"73"),
			(x"c2", x"96", x"35", x"59"),
			(x"95", x"b9", x"80", x"f6"),
			(x"f2", x"43", x"7a", x"7f") 
		),
		(
			(x"3d", x"47", x"1e", x"6d"),
			(x"80", x"16", x"23", x"7a"),
			(x"47", x"fe", x"7e", x"88"),
			(x"7d", x"3e", x"44", x"3b") 
		),
		(
			(x"ef", x"a8", x"b6", x"db"),
			(x"44", x"52", x"71", x"0b"),
			(x"a5", x"5b", x"25", x"ad"),
			(x"41", x"7f", x"3b", x"00") 
		),
		(
			(x"d4", x"7c", x"ca", x"11"),
			(x"d1", x"83", x"f2", x"f9"),
			(x"c6", x"9d", x"b8", x"15"),
			(x"f8", x"87", x"bc", x"bc") 
		),
		(
			(x"6d", x"11", x"db", x"ca"),
			(x"88", x"0b", x"f9", x"00"),
			(x"a3", x"3e", x"86", x"93"),
			(x"7a", x"fd", x"41", x"fd") 
		),
		(
			(x"4e", x"5f", x"84", x"4e"),
			(x"54", x"5f", x"a6", x"a6"),
			(x"f7", x"c9", x"4f", x"dc"),
			(x"0e", x"f3", x"b2", x"4f") 
		),
		(
			(x"ea", x"b5", x"31", x"7f"),
			(x"d2", x"8d", x"2b", x"8d"),
			(x"73", x"ba", x"f5", x"29"),
			(x"21", x"d2", x"60", x"2f") 
		),
		(
			(x"ac", x"19", x"28", x"57"),
			(x"77", x"fa", x"d1", x"5c"),
			(x"66", x"dc", x"29", x"00"),
			(x"f3", x"21", x"41", x"6e") 
		),
		(
			(x"d0", x"c9", x"e1", x"b6"),
			(x"14", x"ee", x"3f", x"63"),
			(x"f9", x"25", x"0c", x"0c"),
			(x"a8", x"89", x"c8", x"a6") 
		)
	);
	
	function "xor" ( L,R: column_state ) return column_state;

end crypt_pack;


package body crypt_pack is

	function "xor" ( L,R: column_state ) return column_state is
	variable result: column_state;
	begin
	  	for i in 0 to 3 loop
			result(i) := L(i) xor R(i);
		end loop;
	        return result;
	end "xor";

end crypt_pack;

package test_pack is

end package ;
