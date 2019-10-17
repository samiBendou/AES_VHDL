onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /aes_tb/DUT/round_data_s
add wave -noupdate /aes_tb/DUT/reg_data_s
add wave -noupdate /aes_tb/DUT/keyexp/expander/key_o
add wave -noupdate /aes_tb/DUT/key_s
add wave -noupdate /aes_tb/DUT/keyexp/expander/key_s
add wave -noupdate -expand /aes_tb/DUT/keyexp/expander/xor_s
add wave -noupdate /aes_tb/DUT/keyexp/expander/mix_s
add wave -noupdate /aes_tb/DUT/keyexp/expander/xor_state_s
add wave -noupdate /aes_tb/DUT/keyexp/expander/key_i
add wave -noupdate -expand /aes_tb/DUT/keyexp_s
add wave -noupdate /aes_tb/DUT/round/data_s
add wave -noupdate /aes_tb/DUT/round/subbytes_s
add wave -noupdate /aes_tb/DUT/round/shiftrows_s
add wave -noupdate /aes_tb/DUT/round/mixcolumns_s
add wave -noupdate /aes_tb/DUT/round/addroundkey_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {710 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 238
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1959 ns} {2003 ns}
