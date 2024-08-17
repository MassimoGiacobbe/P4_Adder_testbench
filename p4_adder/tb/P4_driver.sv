`include "uvm_macros.svh"
`include "P4_sequencer.sv"
import uvm_pkg::*;


//Driver class
//Driver takes sequences and feeds them to the DUT 

class p4_driver extends uvm_driver #(p4_sequence_item);

	p4_sequence_item seq_item;    

	//constructor
    function new(string name, uvm_component parent);
        super.new(name,parent); 
    endfunction

    `uvm_component_utils(p4_driver);
	
    task run();
        forever begin
        seq_item_port.get_next_item(seq_item);
        #10
        seq_item_port.item_done();
        end
    endtask

endclass
