`include "uvm.svh"
`include "P4_sequence_item.sv"
import uvm_pkg::*;
import p4_adder_pkg::*; // Importing package for nTrans

class p4_adder_sequence extends uvm_sequence #(p4_adder_seq_item);

    // Constructor
    function new(string name = "P4_sequence");
        super.new(name);
    endfunction

    `uvm_object_utils(p4_adder_sequence)  // Register with the factory

    virtual task body();

        // Declare the sequence item
        p4_adder_seq_item seq_item;

        //  Generate a configurable number of transactions
        for (int i = 0; i < nTrans; i++) begin  
            
            // Create a new sequence item
            seq_item = p4_adder_seq_item::type_id::create("seq_item");

            // Randomize the sequence item with constraints applied
            if (!seq_item.randomize()) begin
                `uvm_error("RANDOMIZE_FAILED", "Failed to randomize seq_item")
            end

            // Start the sequence item on the sequencer
            start_item(seq_item);

            // Finish the sequence item on the sequencer
            finish_item(seq_item);

            // print the sequence item values for debugging
            `uvm_info("P4_SEQ", $sformatf("Generated item: a = %h, b = %h, cin = %b", 
                        seq_item.a, seq_item.b, seq_item.cin), UVM_MEDIUM)
        end
    endtask

endclass
