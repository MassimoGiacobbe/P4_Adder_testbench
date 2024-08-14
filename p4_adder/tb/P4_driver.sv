`include "uvm.svh"
import uvm_pkg::*;

//Driver class
//Driver takes sequences and feeds them to the DUT 

class P4_driver extends uvm_driver #(p4_adder_seq_item);
    //constructor
    function new(string name, uvm_component parent);
        super.new(name,parent); 
    endfunction

    `uvm_component_utils(P4_driver);

    task run();
        forever begin
        seq_item_port.get_next_item(seq_item);
        $display("0:driving instruction ", $time,seq_item.name());
        #10
        seq_item_port.item_done();
        end
    endtask

endclass