--------------------------------------------------------------------------------
--@author DAHOUX Sami
--@date 23 Novembre 2018
--@component Prod3LUT
--------------------------------------------------------------------------------

library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;
library thirdparty;
use thirdparty.crypt_pack.all;

entity Prod3LUT is
    port (
        prod3_i: in bit8;
        prod3_o: out bit8);
end entity Prod3LUT;

architecture Prod3LUT_arch of Prod3LUT is
    constant prod3_c : sbox_t :=
    (
    --Table of multiplication by 0x03
    x"00", x"03", x"06", x"05", x"0c", x"0f", x"0a", x"09", 
    x"18", x"1b", x"1e", x"1d", x"14", x"17", x"12", x"11",
    x"30", x"33", x"36", x"35", x"3c", x"3f", x"3a", x"39",
    x"28", x"2b", x"2e", x"2d", x"24", x"27", x"22", x"21",
    x"60", x"63", x"66", x"65", x"6c", x"6f", x"6a", x"69",
    x"78", x"7b", x"7e", x"7d", x"74", x"77", x"72", x"71",
    x"50", x"53", x"56", x"55", x"5c", x"5f", x"5a", x"59",
    x"48", x"4b", x"4e", x"4d", x"44", x"47", x"42", x"41",
    x"c0", x"c3", x"c6", x"c5", x"cc", x"cf", x"ca", x"c9",
    x"d8", x"db", x"de", x"dd", x"d4", x"d7", x"d2", x"d1",
    x"f0", x"f3", x"f6", x"f5", x"fc", x"ff", x"fa", x"f9",
    x"e8", x"eb", x"ee", x"ed", x"e4", x"e7", x"e2", x"e1",
    x"a0", x"a3", x"a6", x"a5", x"ac", x"af", x"aa", x"a9",
    x"b8", x"bb", x"be", x"bd", x"b4", x"b7", x"b2", x"b1",
    x"90", x"93", x"96", x"95", x"9c", x"9f", x"9a", x"99",
    x"88", x"8b", x"8e", x"8d", x"84", x"87", x"82", x"81",
    x"9b", x"98", x"9d", x"9e", x"97", x"94", x"91", x"92",
    x"83", x"80", x"85", x"86", x"8f", x"8c", x"89", x"8a",
    x"ab", x"a8", x"ad", x"ae", x"a7", x"a4", x"a1", x"a2",
    x"b3", x"b0", x"b5", x"b6", x"bf", x"bc", x"b9", x"ba",
    x"fb", x"f8", x"fd", x"fe", x"f7", x"f4", x"f1", x"f2",
    x"e3", x"e0", x"e5", x"e6", x"ef", x"ec", x"e9", x"ea",
    x"cb", x"c8", x"cd", x"ce", x"c7", x"c4", x"c1", x"c2",
    x"d3", x"d0", x"d5", x"d6", x"df", x"dc", x"d9", x"da",
    x"5b", x"58", x"5d", x"5e", x"57", x"54", x"51", x"52",
    x"43", x"40", x"45", x"46", x"4f", x"4c", x"49", x"4a",
    x"6b", x"68", x"6d", x"6e", x"67", x"64", x"61", x"62",
    x"73", x"70", x"75", x"76", x"7f", x"7c", x"79", x"7a",
    x"3b", x"38", x"3d", x"3e", x"37", x"34", x"31", x"32",
    x"23", x"20", x"25", x"26", x"2f", x"2c", x"29", x"2a",
    x"0b", x"08", x"0d", x"0e", x"07", x"04", x"01", x"02",
    x"13", x"10", x"15", x"16", x"1f", x"1c", x"19", x"00"
    );

begin
    -- Convert input value into array index to acces to Prod3LUT (cf. lookup table)
    prod3_o <= prod3_c(to_integer(unsigned(prod3_i)));
end architecture Prod3LUT_arch;
