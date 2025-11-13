`include "uvm_macros.svh"

package fwspi_initiator_env_pkg;
    import uvm_pkg::*;
    import fwvip_wb_pkg::*;

    class fwspi_initiator_env extends uvm_env;
        `uvm_component_utils(fwspi_initiator_env)

        fwvip_wb_initiator m_init;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            m_init = fwvip_wb_initiator::type_id::create("m_init", this);
        endfunction
    endclass

endpackage
