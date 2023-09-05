onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Gold -itemcolor Gold -radix binary /Caching_system_tb/DUT/Caching_controller/clk
add wave -noupdate -color Gold -itemcolor Gold -radix binary /Caching_system_tb/DUT/Caching_controller/reset
add wave -noupdate -color Gold -itemcolor Gold -radix binary /Caching_system_tb/DUT/Caching_controller/mem_read
add wave -noupdate -color Gold -itemcolor Gold -radix binary /Caching_system_tb/DUT/Caching_controller/mem_write
add wave -noupdate -color Gold -itemcolor Gold -radix binary /Caching_system_tb/DUT/Caching_controller/stall
add wave -noupdate -color Gold -itemcolor Gold -radix binary /Caching_system_tb/DUT/Caching_controller/current_state
add wave -noupdate -color Gold -itemcolor Gold -radix binary /Caching_system_tb/DUT/Caching_controller/next_state
add wave -noupdate -color Coral -itemcolor Coral -radix decimal /Caching_system_tb/DUT/Cache/write_data
add wave -noupdate -color Coral -itemcolor Coral -radix decimal /Caching_system_tb/DUT/Cache/write_ablock
add wave -noupdate -color Coral -itemcolor Coral -radix binary /Caching_system_tb/DUT/Cache/index
add wave -noupdate -color Coral -itemcolor Coral -radix binary /Caching_system_tb/DUT/Cache/tag
add wave -noupdate -color Coral -itemcolor Coral -radix binary /Caching_system_tb/DUT/Cache/offset
add wave -noupdate -color Coral -itemcolor Coral -radix binary /Caching_system_tb/DUT/Cache/refill
add wave -noupdate -color Coral -itemcolor Coral -radix binary /Caching_system_tb/DUT/Cache/update
add wave -noupdate -color Coral -itemcolor Coral -radix binary /Caching_system_tb/DUT/Cache/hit
add wave -noupdate -color Coral -itemcolor Coral -radix decimal /Caching_system_tb/DUT/Cache/read_data
add wave -noupdate -color Coral -itemcolor Coral -radix decimal /Caching_system_tb/DUT/Cache/k
add wave -noupdate -radix binary /Caching_system_tb/DUT/Main_Memory_U0/address
add wave -noupdate -radix binary /Caching_system_tb/DUT/Main_Memory_U0/write_en
add wave -noupdate -radix binary /Caching_system_tb/DUT/Main_Memory_U0/read_en
add wave -noupdate -radix decimal /Caching_system_tb/DUT/Main_Memory_U0/write_data
add wave -noupdate -radix binary /Caching_system_tb/DUT/Main_Memory_U0/ready
add wave -noupdate -radix decimal /Caching_system_tb/DUT/Main_Memory_U0/read_data
add wave -noupdate -radix binary /Caching_system_tb/DUT/Main_Memory_U0/count
add wave -noupdate -radix binary /Caching_system_tb/DUT/Main_Memory_U0/k
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {210186 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 381
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
WaveRestoreZoom {45044 ps} {460788 ps}
