//sequencer class, should arbitrate beetwen sequence and driver
`include "P4_sequence.sv"
import uvm_pkg::*;

class P4_sequencer extends uvm_sequencer #(p4_sequence_item); 

    //constructor
    function new(string name, uvm_component parent);
        super.new(name,parent);
        `uvm_update_sequence_lib_and_item(p4_sequence_item);
    endfunction

    `uvm_sequencer_utils(P4_sequencer)//register to the factory

endclass
