module xyCounter(

input logic Counterclock,
output logic hsync,
output logic vsync,
output logic[9:0] x = 0,
output logic[9:0] y = 0

);



always_ff @(posedge Counterclock)
begin
x <= (x +1);

if(x < 96)
begin
hsync <= 0;
end

else if(x < 799)
begin
hsync <= 1;
end


else 
begin
x <= 0;
y <= y + 1;
hsync <= 0;
end

if(y < 2)
begin
vsync <= 0;
end

else if(y < 524)
begin
vsync <= 1;
end

else
begin
y <= 0;
vsync <= 0;
end








end
/*
assign x = hcounter;
assign y = vcounter;
assign hsync = synch;
assign vsync = syncv;
*/


endmodule
