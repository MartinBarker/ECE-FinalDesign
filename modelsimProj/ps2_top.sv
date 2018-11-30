module ps2_top(
	input logic clock,	//clock input from keyboard
	input logic data_in,	// ps2 keyboard data input
	output logic [2:0] data	//3 bits logic type variable data output
);

//bit literals: 8'b00011101 means 8 bit Binary number that is 00011101

//declaring things to use in this file

	logic [10:0] current;	//11 bits
	logic [7:0] stored;	//8 bits
	logic [7:0] prev;	//8 bits
	logic [3:0] count;	//4 bits
	logic started;  	//1 bit
	logic parity;   	//1 bit

//logic for getting data input and returning int based on which key is pressed (W/A/S/D)

//begin accepting data bits data on first low edge of clock
always_ff @ (negedge clock) begin

	if(((~data_in) || started)) begin  //if data_in is low OR started is high (indicating something has already begun)
		started <= 1;  //set started to high : nonblocking, sequential, executes in parallel, line below does not rely on this line.
		current[count] <= data_in; //add most recently read in bit from data_in inpupt into the current variable in the 'count' index (count is initially zero)
		
		//check for if this first bit from data_in being read is parity bit
		if(data_in == 1 && count > 0 && count < 9) begin  //if first bit of input data being read in is 1, and count is valid
			parity <= parity + 1; //increment parity_check by 1, nonblocking
		end
		count <= count + 1; //increment count, nonblocking

	

		if(count == 11)begin //if count is out of our pre-determined range (10 bits, [10:0] as we defined above)
			//count is out of range, reset our two values 'started' and 'count'	
			started <= 0; //set started to 0, nonblocking
			count <= 0; //set count to 0, nonblocking 

			//if parity bit is correct, reading of ps2 keyboard input has been successfull, and we can now store our read value in a new variable
			if(current[9] == parity % 2) begin
				prev <= stored;		//move stored byte into previous
				stored <= current[8:1]; //move newly completed fully read in new input byte into stored, but without the 1st starting parity bit and the parity/stop last 2 bits. 
				current <= 0; 		//set current to zero, reseting it. 				
			end

		end		
		
			
	end

end //at this point stored and prev should hold valid bytes

//automatically executes at time zero, sensitive to changes within the contents of a function.
always_comb begin
	//bit literal 8'h1D means it is an 8bit hexadecimal value of 1D,  1D hex = 11101 binary = 29 dec
	//bit literal 8'hF0 means it is an 8bit hexadecimal value of F0,  F0 hex = 11110000 binary = 240 dec
	if(stored == 8'h1D && prev != 8'hF0) begin //if stored value = hex 1D and the key was not just released, it is the W key being pressed
		data <= 3; //set output data to equal 3 which indicates a W
	end

	if(stored == 8'h1C && prev != 8'hF0) begin //if stored value = hex 1C and the key was not just released, it is the A key being pressed
		data <= 1; //set output data to equal 1 which indicates a A
	end

	if(stored == 8'h1B && prev != 8'hF0) begin //if stored value = hex 1B and the key was not just released, it is the S key being pressed
		data <= 4; //set output data to equal 4 which indicates a S
	end

	if(stored == 8'h23 && prev != 8'hF0) begin //if stored value = hex 23 and the key was not just released, it is the D key being pressed
		data <= 2; //set output data to equal 2 which indicates a D
	end
	else begin
		data <= 0; //if input is not W, A, S, or D then set data = 0
	end


end


endmodule;