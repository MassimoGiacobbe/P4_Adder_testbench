`include "P4_test.sv"
`include "P4_interface.sv"
`include "P4_wrap.sv"
import uvm_pkg::*;


module P4_top;

    // Declare signals
    logic clk;

    // Instantiate the DUT interface
    p4_adder_if dut_if (clk); //clk is used for timing purposes since the design is asynchronous

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    // Instantiate the SystemVerilog wrapper around the VHDL DUT
    p4_adder_wrapper dut_wrapper (
            .a    (dut_if.a),    // Connect interface signals to wrapper
            .b    (dut_if.b),
            .cin  (dut_if.cin),
            .s    (dut_if.s),
            .cout (dut_if.cout)
    );


    initial begin
        uvm_config_db#(virtual p4_adder_if)::set(null, "env.agent.*", "vif", dut_if);
        run_test("test1");    

    end

endmodule