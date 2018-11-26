export PROJECT_ROOT="."

rm -rf $PROJECT_ROOT/lib/thirdparty

vlib $PROJECT_ROOT/lib/thirdparty
vmap thirdparty $PROJECT_ROOT/lib/thirdparty

vcom -work thirdparty $PROJECT_ROOT/thirdpartylibrary/CryptPack.vhd
