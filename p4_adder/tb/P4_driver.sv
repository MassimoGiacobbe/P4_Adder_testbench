`ifndef P4_DRIVER
`define P4_DRIVER

`include "uvm_macros.svh"
`include "P4_sequence_item.sv"
import uvm_pkg::*;

// Driver class
// Driver takes sequences and feeds them to the DUT 
class p4_driver extends uvm_driver #(p4_sequence_item);

    // Virtual interface handle
    virtual p4_if vif;

    // Transaction handle
    p4_sequence_item seq_item;    

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name,parent); 
    endfunction

    `uvm_component_utils(p4_driver);

    // Build phase to grab the virtual interface
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(virtual p4_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "Virtual interface not found")
        end
    endfunction

    // Task to drive signals to the DUT
    task run();
        forever begin
            
            // Get the next transaction
            seq_item_port.get_next_item(seq_item);
            // Drive the signals to the DUT using the interface
            vif.a = seq_item.rand_in.a;
            vif.b = seq_item.rand_in.b;
            vif.cin=seq_item.rand_in.cin;
            //reporting for debiugging purposes
            `uvm_info("DRIVER", $sformatf("driving signals  a=%h, b=%h, cin=%b", vif.a,vif.b,vif.cin), UVM_LOW)
            // Wait for one clock cycle to drive new signals
            @(posedge vif.clk);
            // Complete the item
            seq_item_port.item_done();
        end
    endtask

endclass

`endif
