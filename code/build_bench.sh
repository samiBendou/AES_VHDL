#BENCHES SOURCES FILES

export PROJECT_ROOT="."

#delete lib_source
vdel -lib $PROJECT_ROOT/lib/lib_bench -all

vlib $PROJECT_ROOT/lib/lib_bench
vmap bench $PROJECT_ROOT/lib/lib_bench

#Test benches des composants

vcom -work lib_bench $PROJECT_ROOT/bench/SBox_tb.vhd
vcom -work lib_bench $PROJECT_ROOT/bench/SubBytes_tb.vhd
vcom -work lib_bench $PROJECT_ROOT/bench/ShiftRows_tb.vhd
vcom -work lib_bench $PROJECT_ROOT/bench/AddRoundKey_tb.vhd
vcom -work lib_bench $PROJECT_ROOT/bench/MixColumns_tb.vhd
vcom -work lib_bench $PROJECT_ROOT/bench/AES_tb.vhd
vcom -work lib_bench $PROJECT_ROOT/bench/InvShiftRows_tb.vhd


#Test benches des composants inverses

vcom -work lib_bench $PROJECT_ROOT/bench/InvSBox_tb.vhd
vcom -work lib_bench $PROJECT_ROOT/bench/InvMixColumns_tb.vhd
