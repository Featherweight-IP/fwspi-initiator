`include "uvm_macros.svh"
`include "fwvip_wb_macros.svh"

module fwspi_initiator_hvl_top;
    import uvm_pkg::*;
    import fwvip_wb_pkg::*;
    import fwspi_initiator_tests_pkg::*;

    fwspi_initiator_hdl_top u_top();

`ifdef TRACE_EN
    initial begin
        $dumpfile("sim.vcd");
        $dumpvars;
    end
`endif

    initial begin
        `fwvip_wb_initiator_register(
            32,
            32,
            u_top.u_initiator,
            "uvm_test_top.m_env.m_init*")
        run_test("fwspi_initiator_base_test");
    end

endmodule
