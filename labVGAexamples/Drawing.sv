module Drawing(
input logic Drawingclk,
input logic [9:0] x,
input logic [9:0] y,
output logic [3:0] red,
output logic [3:0] blue, 
output logic [3:0] green,
input logic buttonup



);

/*logic r = 4'b0000;
logic b = 4'b0000;
logic g = 4'b0000;
*/


always_ff @(Drawingclk)
begin


if((x <300) && (y < 200)) /* (y < 100))*/
begin 
red <= 4'b0000;
blue <= 4'b0000;
green <= 4'b0000;
end
else if(((x < 500)&& (x> 300)) &&(((y < 400)&&(y > 200))) && (~buttonup)) /*8(y < 400)*/
begin
red <= 4'b1011;
blue <= 4'b0000;
green <= 4'b0000;
end

else if(((x < 500)&& (x> 300)) &&(((y < 400)&&(y > 200))) && (buttonup))
begin 
red <= 4'b0000;
blue <= 4'b0000;
green <= 4'b1111;
end

else if((x < 800)&& (y < 525))
begin 
red <= 4'b0000;
blue <= 4'b0000;
green <= 4'b0000;
end


/*
if(y <0) 
begin 
red <= 4'b0000;
blue <= 4'b0000;
green <= 4'b0000;
end
else if(y < 524) 
begin
red <= 4'b1010;
blue <= 4'b1111;
green <= 4'b0000;
end
else if(y < 525)
begin 
red <= 4'b0000;
blue <= 4'b0000;
green <= 4'b0000;
end
*/






end
/*
assign red = r;
assign blue = b;
assign green = g;
*/
endmodule
