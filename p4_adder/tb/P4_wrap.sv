`ifndef P4_WRAP
`define P4_WRAP
//wrapper to interface the VHDL design to the sv tb

`include "P4_interface.sv"
//import p4_pkg::*; 

module p4_wrap #(nbit, nbit_per_block)(p4_if.port uvm_if);
   
   
   p4_adder #(nbit, nbit_per_block)
    p4_u(
    .a(uvm_if.a),
    .b(uvm_if.b),
    .cin(uvm_if.cin),
    .s(uvm_if.s),
    .cout(uvm_if.cout)    
);



// Property to check data propagation
/*
property check_data_propagation;
    @(posedge uvm_if.clk)
    (uvm_if.a == p4_u.a) && (uvm_if.b == p4_u.b) && (uvm_if.cin == p4_u.cin);
endproperty

// Assert the property
assert property (check_data_propagation)
    else $error("Data mismatch: Inputs to DUT do not match those from the interface.");
*/

endmodule

`endif
