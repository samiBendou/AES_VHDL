#SOURCE FILES

export PROJECT_ROOT="."

#delete lib_rtl
vdel -lib $PROJECT_ROOT/lib/lib_rtl -all

#Create source libs
vlib $PROJECT_ROOT/lib/lib_rtl
vmap source $PROJECT_ROOT/lib/lib_rtl

#Cryptpack library
vcom -work lib_thirdparty $PROJECT_ROOT/lib_thirdpartylibrary/CryptPack.vhd

#Lookup tables
vcom -work lib_rtl $PROJECT_ROOT/source/Prod2LUT.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/Prod3LUT.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/Prod9LUT.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/ProdBLUT.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/ProdDLUT.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/ProdELUT.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/SBox.vhd

#Components
vcom -work lib_rtl $PROJECT_ROOT/source/SubBytes.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/ShiftRows.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/AddRoundKey.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/MixColumns.vhd

#Inverse Component
vcom -work lib_rtl $PROJECT_ROOT/source/InvSBox.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/InvShiftRows.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/InvMixColumns.vhd

#KeyExpansion
vcom -work lib_rtl $PROJECT_ROOT/source/KeyExpansion.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/KeyExpansion_FSM.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/KeyExpansion_Counter.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/KeyExpansion_I_O.vhd

#Top level
vcom -work lib_rtl $PROJECT_ROOT/source/AESRound.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/AES.vhd
vcom -work lib_rtl $PROJECT_ROOT/source/FSM_AES.vhd
