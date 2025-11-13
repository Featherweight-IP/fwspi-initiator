
 Implement the content of the testbench modules (src/verif/tb). The 'hdl' module must contain an instance of the fwspi_initiator design along with a clock generator, reset generator, and instance of the fwvip_wb_initiator_if verification IP. Update the hvl module to register the wb transactor using the registration macro. Have a look at packages/fwvip-wb/src/verif to see
    tests of fwvip-wb 
