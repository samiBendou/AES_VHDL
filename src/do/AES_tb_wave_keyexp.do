onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /aes_tb/clock_s
add wave -noupdate /aes_tb/reset_s
add wave -noupdate /aes_tb/start_s
add wave -noupdate /aes_tb/done_s
add wave -noupdate /aes_tb/inv_s
add wave -noupdate /aes_tb/key_s
add wave -noupdate /aes_tb/DUT/key_s
add wave -noupdate /aes_tb/data_is
add wave -noupdate /aes_tb/data_os
add wave -noupdate /aes_tb/data_es
add wave -noupdate /aes_tb/DUT/round_data_s
add wave -noupdate /aes_tb/DUT/reg_data_s
add wave -noupdate -expand /aes_tb/DUT/keyexp_s
add wave -noupdate /aes_tb/DUT/keyexp/key_register(10)/key_registern/reg/data_i
add wave -noupdate /aes_tb/DUT/keyexp/key_register(10)/key_registern/reg/data_o
add wave -noupdate /aes_tb/DUT/keyexp/expander/mix_s
add wave -noupdate /aes_tb/DUT/keyexp/expander/xor_state_s
add wave -noupdate /aes_tb/DUT/keyexp/fsm/current_state
add wave -noupdate /aes_tb/DUT/fsm/current_state
add wave -noupdate /aes_tb/DUT/count_s
add wave -noupdate /aes_tb/cond_s
add wave -noupdate /aes_tb/DUT/keyexp/en_mix_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4531 ns} 0}
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
WaveRestoreZoom {4228 ns} {4808 ns}
