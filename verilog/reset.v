// reset.vhd
// no timescale needed

module reset(
input wire preset,
input wire clk,
output wire rst_out
);

parameter [31:0] LENGTH=3;



//------------------------------------------------------------------------------
// SIGNAL DECLARATIONS
//------------------------------------------------------------------------------
reg [LENGTH:0] sig_rst;

  assign rst_out = sig_rst[0];
  assign sig_rst[LENGTH] = 1'b0;
  genvar i;
  generate for (i=0; i <= LENGTH - 1; i = i + 1) begin: GEN_FF
      always @(posedge clk, posedge preset) begin
      if((preset == 1'b1)) begin
        sig_rst[i] <= 1'b1;
      end else begin
        sig_rst[i] <= sig_rst[i + 1];
      end
    end

  end
  endgenerate

endmodule
