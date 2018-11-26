--------------------------------------------------------------------------------
--@author DAHOUX Sami
--@date 23 Novembre 2018
--@component ProdELUT
--------------------------------------------------------------------------------

library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;
library thirdparty;
use thirdparty.crypt_pack.all;

entity ProdELUT is
    port (
        prode_i: in bit8;
        prode_o: out bit8);
end entity ProdELUT;

architecture ProdELUT_arch of ProdELUT is
    constant prode_c : sbox_t :=
    (
    --Table of multiplication by 0x0E
    x"00", x"0e", x"1c", x"12", x"38", x"36", x"24", x"2a",
    x"70", x"7e", x"6c", x"62", x"48", x"46", x"54", x"5a",
    x"e0", x"ee", x"fc", x"f2", x"d8", x"d6", x"c4", x"ca",
    x"90", x"9e", x"8c", x"82", x"a8", x"a6", x"b4", x"ba",
    x"db", x"d5", x"c7", x"c9", x"e3", x"ed", x"ff", x"f1",
    x"ab", x"a5", x"b7", x"b9", x"93", x"9d", x"8f", x"81",
    x"3b", x"35", x"27", x"29", x"03", x"0d", x"1f", x"11",
    x"4b", x"45", x"57", x"59", x"73", x"7d", x"6f", x"61",
    x"ad", x"a3", x"b1", x"bf", x"95", x"9b", x"89", x"87",
    x"dd", x"d3", x"c1", x"cf", x"e5", x"eb", x"f9", x"f7",
    x"4d", x"43", x"51", x"5f", x"75", x"7b", x"69", x"67",
    x"3d", x"33", x"21", x"2f", x"05", x"0b", x"19", x"17",
    x"76", x"78", x"6a", x"64", x"4e", x"40", x"52", x"5c",
    x"06", x"08", x"1a", x"14", x"3e", x"30", x"22", x"2c",
    x"96", x"98", x"8a", x"84", x"ae", x"a0", x"b2", x"bc",
    x"e6", x"e8", x"fa", x"f4", x"de", x"d0", x"c2", x"cc",
    x"41", x"4f", x"5d", x"53", x"79", x"77", x"65", x"6b",
    x"31", x"3f", x"2d", x"23", x"09", x"07", x"15", x"1b",
    x"a1", x"af", x"bd", x"b3", x"99", x"97", x"85", x"8b",
    x"d1", x"df", x"cd", x"c3", x"e9", x"e7", x"f5", x"fb",
    x"9a", x"94", x"86", x"88", x"a2", x"ac", x"be", x"b0",
    x"ea", x"e4", x"f6", x"f8", x"d2", x"dc", x"ce", x"c0",
    x"7a", x"74", x"66", x"68", x"42", x"4c", x"5e", x"50",
    x"0a", x"04", x"16", x"18", x"32", x"3c", x"2e", x"20",
    x"ec", x"e2", x"f0", x"fe", x"d4", x"da", x"c8", x"c6",
    x"9c", x"92", x"80", x"8e", x"a4", x"aa", x"b8", x"b6",
    x"0c", x"02", x"10", x"1e", x"34", x"3a", x"28", x"26",
    x"7c", x"72", x"60", x"6e", x"44", x"4a", x"58", x"56",
    x"37", x"39", x"2b", x"25", x"0f", x"01", x"13", x"1d",
    x"47", x"49", x"5b", x"55", x"7f", x"71", x"63", x"6d", 
    x"d7", x"d9", x"cb", x"c5", x"ef", x"e1", x"f3", x"fd",
    x"a7", x"a9", x"bb", x"b5", x"9f", x"91", x"83", x"00"
    );

begin
    -- Convert input value into array index to acces to ProdELUT (cf. lookup table)
    prode_o <= prode_c(to_integer(unsigned(prode_i)));
end architecture ProdELUT_arch;
