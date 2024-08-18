`ifndef P4_SEQUENCE_ITEM
`define P4_SEQUENCE_ITEM


`include "P4_pkg.sv"
import uvm_pkg::*;
import p4_adder_pkg::*; // Importing package for nbit
`include "uvm_macros.svh"


class p4_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(p4_sequence_item)

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
		constraint corner_case{
		//80% of cases are corner cases
		($urandom_range(0,99)<80) ->(
			a inside{32'h00000000, 32'hFFFFFFFF, 32'h00000001, 32'hFFFFFFFE} &&
			b inside{32'h00000000, 32'hFFFFFFFF, 32'h00000001, 32'hFFFFFFFE}
									);		
		}	
        // Bias for cin to be 1
		constraint cin_one{
        //cin is 1 in 70% of cases
        ($urandom_range(0, 99) < 70) ->(cin == 1);
            		 }
    

endclass

`endif
