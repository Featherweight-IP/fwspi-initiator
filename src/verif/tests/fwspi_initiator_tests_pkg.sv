`include "uvm_macros.svh"

package fwspi_initiator_tests_pkg;
    import uvm_pkg::*;
    import fwvip_wb_pkg::*;
    import fwspi_initiator_env_pkg::*;

    class fwspi_initiator_base_test extends uvm_test;
        `uvm_component_utils(fwspi_initiator_base_test)

        fwspi_initiator_env m_env;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            m_env = fwspi_initiator_env::type_id::create("m_env", this);
        endfunction

        task run_phase(uvm_phase phase);
            phase.raise_objection(this);
            // For now, just wait some time. Sequences can be added later.
            #1000ns;
            phase.drop_objection(this);
        endtask
    endclass

endpackage
