`ifndef P4_MONITOR
`define P4_MONITOR

`include "P4_sequence.sv"
`include "P4_interface.sv"


class p4_monitor extends uvm_monitor;
    `uvm_component_utils(p4_monitor);
     uvm_analysis_port #(p4_sequence_item) ap;
     //interface to connect to the DUT
     virtual p4_if vif;
     
    //constructor
     function new(string name, uvm_component parent);
        super.new(name,parent);
     endfunction

     function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Get the virtual interface from the configuration database
        if (!uvm_config_db#(virtual p4_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "Virtual interface not found")
        end

        ap=new("ap",this);
    endfunction

     virtual task run_phase(uvm_phase phase);
        //sequence item
        p4_sequence_item trans;

        forever begin
            //added 1 ns delay to make sure the values are checked after they are driven and not simultanously
            #1ns;
            @(posedge vif.clk);
            trans = p4_sequence_item::type_id::create("trans");
            //save the values from the dut in the sequence item
            trans.i_seq.a=vif.a;
            trans.i_seq.b=vif.b;
            trans.i_seq.cin=vif.cin;
            trans.s=vif.s;
            trans.cout=vif.cout;
            //reporting for debugging purposes
            `uvm_info("MONITOR", $sformatf("Captured: s=%h, cout=%b", vif.s, vif.cout), UVM_LOW)
            //send the saved data through the analysis port
            ap.write(trans);
        end
     endtask
endclass

`endif
