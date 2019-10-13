onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /aes_tb/clock_s
add wave -noupdate /aes_tb/reset_s
add wave -noupdate /aes_tb/start_s
add wave -noupdate /aes_tb/done_s
add wave -noupdate /aes_tb/text_s
add wave -noupdate /aes_tb/key_s
add wave -noupdate /aes_tb/cipher_s
add wave -noupdate -expand /aes_tb/DUT/keyexp_s
add wave -noupdate -expand /aes_tb/DUT/keyexp/we_s
add wave -noupdate /aes_tb/DUT/keyexp/fsm/clock_i
add wave -noupdate /aes_tb/DUT/keyexp/fsm/count_s
add wave -noupdate /aes_tb/DUT/keyexp/fsm/current_state
add wave -noupdate /aes_tb/DUT/keyexp/fsm/we_key_o
add wave -noupdate /aes_tb/DUT/keyexp/fsm/resetb_i
add wave -noupdate /aes_tb/DUT/keyexp/fsm/start_i
add wave -noupdate /aes_tb/DUT/keyexp/count_s
add wave -noupdate /aes_tb/DUT/keyexp/fsm/count_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {791 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 217
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
WaveRestoreZoom {191 ns} {892 ns}
