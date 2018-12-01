vsim work.ps2_top

add wave *

#clk every 100 ns
force -deposit /ps2_top/clock 1 0, 0 {50 ns} -repeat 100

force /ps2_top/data 1 @ 1300

#set data_in to zero at the start to 'started' variable begins counting
#force /ps2_top/clock 0 @ 100
force /ps2_top/count 0 @ 0
force /ps2_top/parity 0 @ 0



#A = 0001 1100
# now include start bit (low) -> byte -> parity bit (1 becaue there is odd number of 1's in byte), stop bit (high)
#   0 0001 1100 11   
#send A key 8bits (1C hex =  11100 binary = 0 0011 1000 01 with parity/end bits )
#force /ps2_top/data_in 0 @ 200, 0 @ 300, 0 @ 400, 0 @ 500, 1 @ 600, 1 @ 700, 1 @ 800, 0 @ 900, 0 @ 1000, 1 @ 1100, 1 @ 1200
force /ps2_top/data_in 0 @ 200, 1 @ 300, 0 @ 400, 1 @ 500, 0 @ 600, 1 @ 700, 0 @ 800, 1 @ 900, 0 @ 1000, 1 @ 1100, 0 @ 1200



run 12000
