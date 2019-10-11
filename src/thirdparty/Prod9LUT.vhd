--------------------------------------------------------------------------------
-- @author DAHOUX Sami
-- @date 23 Novembre 2018
-- @component Prod9LUT
--------------------------------------------------------------------------------

library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;
library lib_thirdparty;
use lib_thirdparty.crypt_pack.all;

entity Prod9LUT is
    port (
        prod9_i: in bit8;
        prod9_o: out bit8);
end entity Prod9LUT;

architecture Prod9LUT_arch of Prod9LUT is
    constant prod9_c : sbox_t :=
    (
    --Table of multiplication by 0x09
    x"00", x"09", x"12", x"1b", x"24", x"2d", x"36", x"3f",
    x"48", x"41", x"5a", x"53", x"6c", x"65", x"7e", x"77",
    x"90", x"99", x"82", x"8b", x"b4", x"bd", x"a6", x"af",
    x"d8", x"d1", x"ca", x"c3", x"fc", x"f5", x"ee", x"e7",
    x"3b", x"32", x"29", x"20", x"1f", x"16", x"0d", x"04",
    x"73", x"7a", x"61", x"68", x"57", x"5e", x"45", x"4c",
    x"ab", x"a2", x"b9", x"b0", x"8f", x"86", x"9d", x"94",
    x"e3", x"ea", x"f1", x"f8", x"c7", x"ce", x"d5", x"dc",
    x"76", x"7f", x"64", x"6d", x"52", x"5b", x"40", x"49",
    x"3e", x"37", x"2c", x"25", x"1a", x"13", x"08", x"01",
    x"e6", x"ef", x"f4", x"fd", x"c2", x"cb", x"d0", x"d9",
    x"ae", x"a7", x"bc", x"b5", x"8a", x"83", x"98", x"91",
    x"4d", x"44", x"5f", x"56", x"69", x"60", x"7b", x"72",
    x"05", x"0c", x"17", x"1e", x"21", x"28", x"33", x"3a",
    x"dd", x"d4", x"cf", x"c6", x"f9", x"f0", x"eb", x"e2",
    x"95", x"9c", x"87", x"8e", x"b1", x"b8", x"a3", x"aa",
    x"ec", x"e5", x"fe", x"f7", x"c8", x"c1", x"da", x"d3",
    x"a4", x"ad", x"b6", x"bf", x"80", x"89", x"92", x"9b",
    x"7c", x"75", x"6e", x"67", x"58", x"51", x"4a", x"43",
    x"34", x"3d", x"26", x"2f", x"10", x"19", x"02", x"0b",
    x"d7", x"de", x"c5", x"cc", x"f3", x"fa", x"e1", x"e8",
    x"9f", x"96", x"8d", x"84", x"bb", x"b2", x"a9", x"a0",
    x"47", x"4e", x"55", x"5c", x"63", x"6a", x"71", x"78",
    x"0f", x"06", x"1d", x"14", x"2b", x"22", x"39", x"30",
    x"9a", x"93", x"88", x"81", x"be", x"b7", x"ac", x"a5",
    x"d2", x"db", x"c0", x"c9", x"f6", x"ff", x"e4", x"ed", 
    x"0a", x"03", x"18", x"11", x"2e", x"27", x"3c", x"35",
    x"42", x"4b", x"50", x"59", x"66", x"6f", x"74", x"7d",
    x"a1", x"a8", x"b3", x"ba", x"85", x"8c", x"97", x"9e",
    x"e9", x"e0", x"fb", x"f2", x"cd", x"c4", x"df", x"d6",
    x"31", x"38", x"23", x"2a", x"15", x"1c", x"07", x"0e",
    x"79", x"70", x"6b", x"62", x"5d", x"54", x"4f", x"00"
    );

begin
    -- Convert input value into array index to acces to Prod9LUT (cf. lookup table)
    prod9_o <= prod9_c(to_integer(unsigned(prod9_i)));
end architecture Prod9LUT_arch;
