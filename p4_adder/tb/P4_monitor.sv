`include "P4_sequence.sv"
`include "P4_interface.sv"
import uvm_pkg::*;




class P4_monitor extends uvm_monitor;
    `uvm_component_utils(P4_monitor);
     uvm_analysis_port #(p4_sequence_item) ap;
     //interface to connect to the DUT
     virtual p4_adder_if pif;
     
    //constructor
     function new(string name, uvm_component parent);
        super.new(name,parent);
     endfunction

     function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Get the virtual interface from the configuration database
        if (!uvm_config_db#(virtual p4_adder_if)::get(this, "", "pif", pif)) begin
            `uvm_fatal("NOVIF", "Virtual interface not found")
        end
    endfunction

     virtual task run_phase(uvm_phase phase);
        //sequence item
        p4_sequence_item trans;

        forever begin
            trans = p4_sequence_item::type_id::create("trans");
            //save the values from the dut in the sequence item
            trans.a=pif.a;
            trans.b=pif.b;
            trans.cin=pif.cin;
            trans.s=pif.s;
            trans.cout=pif.cout;
            //send the saved data through the analysis port
            ap.write(trans);
        end
     endtask
endclass

 

            
