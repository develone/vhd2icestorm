module TOP_TB ();

parameter BIT_WIDTH = 11;
parameter BAUD_RATE = 9600;
parameter CLOCK_FREQ_HZ = 100000000;
parameter [31:0] uarts=2;
reg clk;
wire [uarts - 1:0] rx;
wire [uarts - 1:0] tx;
wire [3:0] led;

main main_ins0 #(.BIT_WIDTH(BIT_WIDTH),.BAUD_RATE(BAUD_RATE),.CLOCK_FREQ_HZ(CLOCK_FREQ_HZ),.uarts(uarts))
(
.clk(clk),
.[uarts - 1:0] rx(rx),
.[uarts - 1:0] tx(tx),
.[3:0] led([3:0] led)
);


initial
begin 
clk = 0;
forever begin
#10 clk = !clk;
end
end

initial
begin
#6920000
$finish();
end

 initial 
    begin
      // Required to dump signals to EPWave
      $dumpfile("dump.vcd");
      $dumpvars(0);
    end
endmodule
