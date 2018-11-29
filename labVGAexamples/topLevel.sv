module topLevel(
input logic toplevelclk,
input logic topbuttonup,
output logic[3:0] r,
output logic [3:0]b,
output  logic [3:0]g,
output logic tophsync,
output logic topvsync
);

logic outclock;
logic[9:0] x;
logic[9:0] y;
/*Lab6ClockScaleExamples clock(
.clk(CLOCK),
.halfclk(outclock)
);
*/

Lab6ClockScaleExamples half(
.clk(toplevelclk),
.halfclk(outclock)

);

xyCounter count(
.Counterclock(outclock),
.hsync(tophsync),
.vsync(topvsync),
.x(x),
.y(y)



);

Drawing draw(
.Drawingclk(outclock),
.buttonup(topbuttonup),
.x(x),
.y(y),
.red(r),
.blue(b),
.green(g)

);



endmodule 