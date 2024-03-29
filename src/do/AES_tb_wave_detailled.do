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
add wave -noupdate /aes_tb/DUT/U1/present_state
add wave -noupdate -expand /aes_tb/DUT/U2/textState_s
add wave -noupdate /aes_tb/data_os
add wave -noupdate -expand /aes_tb/DUT/U2/data_s
add wave -noupdate -expand /aes_tb/DUT/U2/currentStateKey_s
add wave -noupdate /aes_tb/DUT/enableMixcolumns_s
add wave -noupdate /aes_tb/DUT/enableRoundcomputing_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2501 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 238
configure wave -valuecolwidth 173
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
WaveRestoreZoom {2253 ns} {2724 ns}
