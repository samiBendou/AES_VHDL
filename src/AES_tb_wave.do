onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /aes_tb/start_is
add wave -noupdate /aes_tb/reset_is
add wave -noupdate -radix hexadecimal /aes_tb/key_is
add wave -noupdate /aes_tb/done_os
add wave -noupdate -radix hexadecimal /aes_tb/data_os
add wave -noupdate -radix hexadecimal /aes_tb/data_is
add wave -noupdate /aes_tb/clock_is
add wave -noupdate /aes_tb/DUT/U0/Count/count_o
add wave -noupdate /aes_tb/DUT/U0/FSM/present_state
add wave -noupdate -radix hexadecimal /aes_tb/DUT/U0/Calculus/key_i
add wave -noupdate -radix hexadecimal /aes_tb/DUT/U0/Calculus/key_o
add wave -noupdate /aes_tb/DUT/U1/present_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {384 ns} 0}
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
WaveRestoreZoom {0 ns} {854 ns}
