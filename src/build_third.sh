export PROJECT_ROOT="."

rm -rf $PROJECT_ROOT/lib/lib_thirdparty

vlib $PROJECT_ROOT/lib/lib_thirdparty
vmap lib_thirdparty $PROJECT_ROOT/lib/lib_thirdparty

vcom -work lib_thirdparty $PROJECT_ROOT/lib_thirdpartylibrary/CryptPack.vhd
