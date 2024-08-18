`ifndef P4_WRAP
`define P4_WRAP
//wrapper to interface the VHDL design to the sv tb


import p4_pkg::*; 

module p4_wrap #(nbit, nbit_per_block)(p4_if.port uvm_if);
   
   
   p4_adder #(nbit, nbit_per_block)
p4_u(
    .a(uvm_if.a),
    .b(uvm_if.b),
    .cin(uvm_if.cin),
    .s(uvm_if.s),
    .cout(uvm_if.cout)
   
);

endmodule

`endif
