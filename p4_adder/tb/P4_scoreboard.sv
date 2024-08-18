`ifndef P4_SCOREBOARD
`define	P4_SCOREBOARD

`include "P4_monitor.sv"
//import uvm_pkg::*;


class p4_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(p4_scoreboard)

    // Declare an analysis export to receive transactions from the monitor
    uvm_analysis_export #(p4_sequence_item) analysis_export;

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_export = new("analysis_export", this);
    endfunction

    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    
    virtual function void compare(p4_sequence_item trans);
        logic [nbit-1:0] expected_s;
        logic expected_cout;

        // Calculate expected outputs based on inputs
        {expected_cout, expected_s} = trans.a + trans.b + trans.cin;

        // Compare actual outputs with expected outputs
        if (trans.s !== expected_s || trans.cout !== expected_cout) begin
            `uvm_error("MISMATCH", $sformatf("Mismatch detected! Inputs: a=%h, b=%h, cin=%b | Expected: s=%h, cout=%b | Got: s=%h, cout=%b",
                                    trans.a, trans.b, trans.cin, expected_s, expected_cout, trans.s, trans.cout))
        end else begin
            `uvm_info("CHECK", $sformatf("Check passed! Inputs: a=%h, b=%h, cin=%b | Output: s=%h, cout=%b",
                                    trans.a, trans.b, trans.cin, trans.s, trans.cout), UVM_LOW)
        end
    endfunction

endclass

`endif
