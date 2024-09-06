`ifndef P4_SEQUENCE_ITEM
`define P4_SEQUENCE_ITEM


//`include "P4_pkg.sv"
import uvm_pkg::*;
import p4_pkg::*; // Importing package for nbit
`include "uvm_macros.svh"


class p4_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(p4_sequence_item)

    // input variables
    typedef struct packed{
        logic [nbit-1:0] a;
        logic [nbit-1:0] b;
        logic cin;      
    } i_var;
     i_var i_seq;
     rand i_var rand_in;
     
    //outputs to be collected
    logic [nbit-1:0] s;
    logic cout;



    // Constructor
    function new(string name = "P4_sequence_item"   );
        super.new(name);
    endfunction

    // Constraints to increase the probability of corner cases
    //10x more likely to be a corner case
		constraint corner_case{
        rand_in.a  dist {
            0                 :=10, 
            (1<<nbit)-1       :=10,
            (1<<(nbit-1))-1   :=10, 
            [1:(1<<nbit)-2]   :=1
            };
        rand_in.b  dist {
                0                 :=10, 
                (1<<nbit)-1       :=10,
                (1<<(nbit-1))-1   :=10, 
                [1:(1<<nbit)-2]   :=1
                };
            };
        // Bias for cin to be 1
        //7x more likely to be 1
		constraint cin_one{
            rand_in.cin  dist {
                0                   :=7, 
                1                   :=1
                };
            };
                    

endclass

`endif
