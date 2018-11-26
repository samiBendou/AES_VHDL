--------------------------------------------------------------------------------
--@author DAHOUX Sami
--@date 23 Novembre 2018
--@component ProdBLUT
--------------------------------------------------------------------------------

library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;
library thirdparty;
use thirdparty.crypt_pack.all;

entity ProdBLUT is
    port (
        prodb_i: in bit8;
        prodb_o: out bit8);
end entity ProdBLUT;

architecture ProdBLUT_arch of ProdBLUT is
    constant prodb_c : sbox_t :=
    (
    --Table of multiplication by 0x0B
    x"00", x"0b", x"16", x"1d", x"2c", x"27", x"3a", x"31",
    x"58", x"53", x"4e", x"45", x"74", x"7f", x"62", x"69",
    x"b0", x"bb", x"a6", x"ad", x"9c", x"97", x"8a", x"81",
    x"e8", x"e3", x"fe", x"f5", x"c4", x"cf", x"d2", x"d9",
    x"7b", x"70", x"6d", x"66", x"57", x"5c", x"41", x"4a",
    x"23", x"28", x"35", x"3e", x"0f", x"04", x"19", x"12",
    x"cb", x"c0", x"dd", x"d6", x"e7", x"ec", x"f1", x"fa",
    x"93", x"98", x"85", x"8e", x"bf", x"b4", x"a9", x"a2",
    x"f6", x"fd", x"e0", x"eb", x"da", x"d1", x"cc", x"c7",
    x"ae", x"a5", x"b8", x"b3", x"82", x"89", x"94", x"9f",
    x"46", x"4d", x"50", x"5b", x"6a", x"61", x"7c", x"77",
    x"1e", x"15", x"08", x"03", x"32", x"39", x"24", x"2f",
    x"8d", x"86", x"9b", x"90", x"a1", x"aa", x"b7", x"bc",
    x"d5", x"de", x"c3", x"c8", x"f9", x"f2", x"ef", x"e4",
    x"3d", x"36", x"2b", x"20", x"11", x"1a", x"07", x"0c",
    x"65", x"6e", x"73", x"78", x"49", x"42", x"5f", x"54",
    x"f7", x"fc", x"e1", x"ea", x"db", x"d0", x"cd", x"c6",
    x"af", x"a4", x"b9", x"b2", x"83", x"88", x"95", x"9e",
    x"47", x"4c", x"51", x"5a", x"6b", x"60", x"7d", x"76",
    x"1f", x"14", x"09", x"02", x"33", x"38", x"25", x"2e",
    x"8c", x"87", x"9a", x"91", x"a0", x"ab", x"b6", x"bd",
    x"d4", x"df", x"c2", x"c9", x"f8", x"f3", x"ee", x"e5",
    x"3c", x"37", x"2a", x"21", x"10", x"1b", x"06", x"0d",
    x"64", x"6f", x"72", x"79", x"48", x"43", x"5e", x"55",
    x"01", x"0a", x"17", x"1c", x"2d", x"26", x"3b", x"30",
    x"59", x"52", x"4f", x"44", x"75", x"7e", x"63", x"68",
    x"b1", x"ba", x"a7", x"ac", x"9d", x"96", x"8b", x"80",
    x"e9", x"e2", x"ff", x"f4", x"c5", x"ce", x"d3", x"d8",
    x"7a", x"71", x"6c", x"67", x"56", x"5d", x"40", x"4b",
    x"22", x"29", x"34", x"3f", x"0e", x"05", x"18", x"13",
    x"ca", x"c1", x"dc", x"d7", x"e6", x"ed", x"f0", x"fb",
    x"92", x"99", x"84", x"8f", x"be", x"b5", x"a8", x"00"
    );

begin
    -- Convert input value into array index to acces to ProdBLUT (cf. lookup table)
    prodb_o <= prodb_c(to_integer(unsigned(prodb_i)));
end architecture ProdBLUT_arch;
