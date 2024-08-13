//wrapper to interface the VHDL design to the sv tb


import p4_adder_pkg::*; 

module p4_adder_wrapper (
    input  logic clk,
    input  logic rst,
    p4_adder_if uvm_if
);

   // Interface with the VHDL design
   p4_adder
   #(
       .nbit(nbit),
       .nbit_per_block(nbit_per_block)
   )
   p4_adder_inst (
       .a(uvm_if.a),
       .b(uvm_if.b),
       .cin(uvm_if.cin),
       .s(uvm_if.s),
       .cout(uvm_if.cout)
   );

endmodule
