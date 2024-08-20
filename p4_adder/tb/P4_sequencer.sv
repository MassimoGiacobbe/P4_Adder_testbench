//sequencer class, should arbitrate beetwen sequence and driver
`ifndef P4_SEQUENCER
`define P4_SEQUENCER

`include "P4_sequence.sv"
import uvm_pkg::*;

class p4_sequencer extends uvm_sequencer #(p4_sequence_item); 

    //constructor
    function new(string name, uvm_component parent);
        super.new(name,parent);
        //this line is deprecated, apparently the sequencer should know what the sequence item is from the parameter
       // `uvm_update_sequence_lib_and_item(p4_sequence_item);  
    endfunction

    `uvm_component_utils(p4_sequencer)//register to the factory

endclass

`endif
