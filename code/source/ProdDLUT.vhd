--------------------------------------------------------------------------------
--@author DAHOUX Sami
--@date 23 Novembre 2018
--@component ProdDLUT
--------------------------------------------------------------------------------

library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;
library thirdparty;
use thirdparty.crypt_pack.all;

entity ProdDLUT is
    port (
        prodd_i: in bit8;
        prodd_o: out bit8);
end entity ProdDLUT;

architecture ProdDLUT_arch of ProdDLUT is
    constant prodd_c : sbox_t :=
    (
    --Table of multiplication by 0x0D
    x"00", x"0d", x"1a", x"17", x"34", x"39", x"2e", x"23",
    x"68", x"65", x"72", x"7f", x"5c", x"51", x"46", x"4b",
    x"d0", x"dd", x"ca", x"c7", x"e4", x"e9", x"fe", x"f3",
    x"b8", x"b5", x"a2", x"af", x"8c", x"81", x"96", x"9b",
    x"bb", x"b6", x"a1", x"ac", x"8f", x"82", x"95", x"98",
    x"d3", x"de", x"c9", x"c4", x"e7", x"ea", x"fd", x"f0",
    x"6b", x"66", x"71", x"7c", x"5f", x"52", x"45", x"48",
    x"03", x"0e", x"19", x"14", x"37", x"3a", x"2d", x"20",
    x"6d", x"60", x"77", x"7a", x"59", x"54", x"43", x"4e",
    x"05", x"08", x"1f", x"12", x"31", x"3c", x"2b", x"26",
    x"bd", x"b0", x"a7", x"aa", x"89", x"84", x"93", x"9e",
    x"d5", x"d8", x"cf", x"c2", x"e1", x"ec", x"fb", x"f6",
    x"d6", x"db", x"cc", x"c1", x"e2", x"ef", x"f8", x"f5",
    x"be", x"b3", x"a4", x"a9", x"8a", x"87", x"90", x"9d",
    x"06", x"0b", x"1c", x"11", x"32", x"3f", x"28", x"25",
    x"6e", x"63", x"74", x"79", x"5a", x"57", x"40", x"4d",
    x"da", x"d7", x"c0", x"cd", x"ee", x"e3", x"f4", x"f9",
    x"b2", x"bf", x"a8", x"a5", x"86", x"8b", x"9c", x"91",
    x"0a", x"07", x"10", x"1d", x"3e", x"33", x"24", x"29",
    x"62", x"6f", x"78", x"75", x"56", x"5b", x"4c", x"41",
    x"61", x"6c", x"7b", x"76", x"55", x"58", x"4f", x"42",
    x"09", x"04", x"13", x"1e", x"3d", x"30", x"27", x"2a",
    x"b1", x"bc", x"ab", x"a6", x"85", x"88", x"9f", x"92",
    x"d9", x"d4", x"c3", x"ce", x"ed", x"e0", x"f7", x"fa",
    x"b7", x"ba", x"ad", x"a0", x"83", x"8e", x"99", x"94",
    x"df", x"d2", x"c5", x"c8", x"eb", x"e6", x"f1", x"fc",
    x"67", x"6a", x"7d", x"70", x"53", x"5e", x"49", x"44",
    x"0f", x"02", x"15", x"18", x"3b", x"36", x"21", x"2c",
    x"0c", x"01", x"16", x"1b", x"38", x"35", x"22", x"2f",
    x"64", x"69", x"7e", x"73", x"50", x"5d", x"4a", x"47",
    x"dc", x"d1", x"c6", x"cb", x"e8", x"e5", x"f2", x"ff",
    x"b4", x"b9", x"ae", x"a3", x"80", x"8d", x"9a", x"00"
    );

begin
    -- Convert input value into array index to acces to ProdDLUT (cf. lookup table)
    prodd_o <= prodd_c(to_integer(unsigned(prodd_i)));
end architecture ProdDLUT_arch;
