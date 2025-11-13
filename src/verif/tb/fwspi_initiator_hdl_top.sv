`include "wishbone_macros.svh"

module fwspi_initiator_hdl_top;

  // Clock / Reset
  logic clock = 1'b0;
  logic reset = 1'b1;

  // 100MHz clock (10ns period)
  always #5 clock = ~clock;

  // Deassert reset after a few cycles
  initial begin
    reset = 1'b1;
    repeat (5) @(posedge clock);
    reset = 1'b0;
  end

  localparam int ADDR_WIDTH = 32;
  localparam int DATA_WIDTH = 32;

  // Wishbone bus wires
  wire [ADDR_WIDTH-1:0]      wb_adr;
  wire [DATA_WIDTH-1:0]      wb_dat_w;
  wire [DATA_WIDTH-1:0]      wb_dat_r;
  wire                       wb_cyc;
  wire                       wb_err;
  wire [DATA_WIDTH/8-1:0]    wb_sel;
  wire                       wb_stb;
  wire                       wb_ack;
  wire                       wb_we;

  // Verification IP: Wishbone initiator BFM
  fwvip_wb_initiator_if #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH)
  ) u_initiator (
    .clock(clock),
    .reset(reset),
    .adr(wb_adr),
    .dat_w(wb_dat_w),
    .dat_r(wb_dat_r),
    .we(wb_we),
    .stb(wb_stb),
    .sel(wb_sel),
    .ack(wb_ack),
    .err(wb_err),
    .cyc(wb_cyc)
  );

  // DUT: SPI initiator (Wishbone target)
  wire inta;
  wire tx_ready;
  wire rx_ready;
  wire sck;
  wire mosi;
  wire miso;

  // Simple default for MISO
  assign miso = 1'b0;

  fwspi_initiator u_dut (
    .clock   (clock),
    .reset   (reset),
    // Wishbone target (note: DUT has 4-bit address bus)
    .rt_adr  (wb_adr[3:0]),
    .rt_dat_w(wb_dat_w),
    .rt_dat_r(wb_dat_r),
    .rt_cyc  (wb_cyc),
    .rt_err  (wb_err),
    .rt_sel  (wb_sel),
    .rt_stb  (wb_stb),
    .rt_ack  (wb_ack),
    .rt_we   (wb_we),
    // Other DUT outputs/inputs
    .inta    (inta),
    .tx_ready(tx_ready),
    .rx_ready(rx_ready),
    .sck     (sck),
    .mosi    (mosi),
    .miso    (miso)
  );

endmodule
