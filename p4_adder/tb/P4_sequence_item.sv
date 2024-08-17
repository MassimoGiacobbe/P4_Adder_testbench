//`include "uvm.svh"
import uvm_pkg::*;
import p4_adder_pkg::*; // Importing package for nbit

class p4_adder_seq_item extends uvm_sequence_item;
    `uvm_object_utils(p4_adder_seq_item)

    // Random variables
    rand logic [nbit-1:0] a;
    rand logic [nbit-1:0] b;
    rand logic cin;
    
    //outputs to be collected
    logic [nbit-1:0] s;
    logic cout;



    // Constructor
    function new(string name = "P4_sequence_item"   );
        super.new(name);
    endfunction

    // Constraints to increase the probability of corner cases
    constraint corner_case {
        //corner cases are 80% of cases
        if ($urandom_range(0, 99) < 80) begin
            a inside {32'h00000000, 32'hFFFFFFFF, 32'h00000001, 32'hFFFFFFFE}; 
            b inside {32'h00000000, 32'hFFFFFFFF, 32'h00000001, 32'hFFFFFFFE};
        end

        // Bias for cin to be 1
        //cin is 1 in 70% of cases
        if ($urandom_range(0, 99) < 70) begin
            cin == 1;
        end
    }

endclass
