--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 23 Novembre 2018
-- @component Prod2LUT
--------------------------------------------------------------------------------

library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;
library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

entity Prod2LUT is
    port (
        prod2_i: in bit8;
        prod2_o: out bit8);
end entity Prod2LUT;

architecture Prod2LUT_arch of Prod2LUT is
    constant prod2_c : sbox_t :=
    (
    --Table of multiplication by 0x02
    x"00", x"02", x"04", x"06", x"08", x"0a", x"0c", x"0e",
    x"10", x"12", x"14", x"16", x"18", x"1a", x"1c", x"1e",
    x"20", x"22", x"24", x"26", x"28", x"2a", x"2c", x"2e",
    x"30", x"32", x"34", x"36", x"38", x"3a", x"3c", x"3e",
    x"40", x"42", x"44", x"46", x"48", x"4a", x"4c", x"4e",
    x"50", x"52", x"54", x"56", x"58", x"5a", x"5c", x"5e",
    x"60", x"62", x"64", x"66", x"68", x"6a", x"6c", x"6e",
    x"70", x"72", x"74", x"76", x"78", x"7a", x"7c", x"7e",
    x"80", x"82", x"84", x"86", x"88", x"8a", x"8c", x"8e",
    x"90", x"92", x"94", x"96", x"98", x"9a", x"9c", x"9e",
    x"a0", x"a2", x"a4", x"a6", x"a8", x"aa", x"ac", x"ae",
    x"b0", x"b2", x"b4", x"b6", x"b8", x"ba", x"bc", x"be",
    x"c0", x"c2", x"c4", x"c6", x"c8", x"ca", x"cc", x"ce",
    x"d0", x"d2", x"d4", x"d6", x"d8", x"da", x"dc", x"de",
    x"e0", x"e2", x"e4", x"e6", x"e8", x"ea", x"ec", x"ee",
    x"f0", x"f2", x"f4", x"f6", x"f8", x"fa", x"fc", x"fe",
    x"1b", x"19", x"1f", x"1d", x"13", x"11", x"17", x"15",
    x"0b", x"09", x"0f", x"0d", x"03", x"01", x"07", x"05",
    x"3b", x"39", x"3f", x"3d", x"33", x"31", x"37", x"35",
    x"2b", x"29", x"2f", x"2d", x"23", x"21", x"27", x"25",
    x"5b", x"59", x"5f", x"5d", x"53", x"51", x"57", x"55",
    x"4b", x"49", x"4f", x"4d", x"43", x"41", x"47", x"45",
    x"7b", x"79", x"7f", x"7d", x"73", x"71", x"77", x"75",
    x"6b", x"69", x"6f", x"6d", x"63", x"61", x"67", x"65",
    x"9b", x"99", x"9f", x"9d", x"93", x"91", x"97", x"95",
    x"8b", x"89", x"8f", x"8d", x"83", x"81", x"87", x"85",
    x"bb", x"b9", x"bf", x"bd", x"b3", x"b1", x"b7", x"b5",
    x"ab", x"a9", x"af", x"ad", x"a3", x"a1", x"a7", x"a5",
    x"db", x"d9", x"df", x"dd", x"d3", x"d1", x"d7", x"d5",
    x"cb", x"c9", x"cf", x"cd", x"c3", x"c1", x"c7", x"c5",
    x"fb", x"f9", x"ff", x"fd", x"f3", x"f1", x"f7", x"f5",
    x"eb", x"e9", x"ef", x"ed", x"e3", x"e1", x"e7", x"00"
    );

begin
    -- Convert input value into array index to acces to Prod2LUT (cf. lookup table)
    prod2_o <= prod2_c(to_integer(unsigned(prod2_i)));
end architecture Prod2LUT_arch;
