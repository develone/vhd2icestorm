module TOP_TB ();

parameter BIT_WIDTH = 11;
parameter BAUD_RATE = 9600;
parameter CLOCK_FREQ_HZ = 100000000;
parameter [31:0] uarts=5;
reg r_clk;
wire [uarts - 1:0] rx;
wire [uarts - 1:0] tx;
wire [4:0] led;
//top top_ins(
//.clk(r_clk),
//.[uarts - 1:0] rx([uarts - 1:0] rx),
//.[uarts - 1:0] tx([uarts - 1:0] tx),
//.[4:0] led([4:0] led)
//);


initial
begin 
r_clk = 0;
forever begin
#10 r_clk = ~r_clk;
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
