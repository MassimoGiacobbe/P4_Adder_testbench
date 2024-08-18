`ifndef P4_INTERFACE
`define P4_INTERFACE
// Import the package containing nbit and nbit_per_block values
import p4_pkg::*; 

interface p4_if(input logic clk);

   logic [nbit-1:0] a;
   logic [nbit-1:0] b;
   logic cin;
   logic [nbit-1:0] s;
   logic cout;

   // Clocking block for timing control
   clocking cb @(posedge clk);
       input a, b, cin;
       output s, cout;
   endclocking

   // Modport definitions 
   modport port(input a, b, cin, output s, cout);
  

endinterface

`endif
