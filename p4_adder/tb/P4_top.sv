`ifndef P4_TOP
`define	P4_TOP

`include "P4_test.sv"
`include "P4_wrap.sv"


    module P4_top;

        // Declare signals
        logic clk;

        // Instantiate the DUT interface
        p4_if dut_if (clk); //clk is used for timing purposes since the design is asynchronous

        // Clock generation
        initial begin
            clk = 0;
            forever #5 clk = ~clk; // 100 MHz clock
        end

        // Instantiate the SystemVerilog wrapper around the VHDL DUT
        p4_wrap #(nbit,nbit_per_block) dut_wrapper (dut_if.port);


        initial begin
            uvm_config_db#(virtual p4_if)::set(null, "*", "vif", dut_if);
            //run P4_test
            run_test("p4_test");    

        end

endmodule

`endif
