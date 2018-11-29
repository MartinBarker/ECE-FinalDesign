vsim work.SPI_PS2KB
add wave *

#clk every 100 ns
#force -deposit /ps2_Top/clk_15khz 1 0, 0 {50 ns} -repeat 100

#reset at begin
#force /ps2_Top/reset 1 @ 100, 0 @ 200

#keep sending 1 at begin
#force /ps2_Top/ps2_data_in 1 @ 340

run 12000
