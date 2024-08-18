`ifndef P4_TEST
`define	P4_TEST

`include "P4_env.sv"
import uvm_pkg::*;

class test1 extends uvm_test;

    `uvm_component_utils(test1)
    
    P4_env env;
    
    
    function new (string name="test1", uvm_component parent=null);
        super.new (name, parent);
        //i see online that is is not recommended to instantiate here the enviroment, but a build phase should be written, i'll leave it like this for the time being
        //since i am following testbench.in
        env = new("t_env",this);
    endfunction : new
    
    virtual task run_phase(uvm_phase phase);
        //uvm_report_info(get_full_name(), "START of run_phase", UVM_LOW);

        p4_sequence seq;
        seq = p4_sequence::type_id::create("seq");

        // Raise objection to keep the simulation running
        phase.raise_objection(this);

        // Start the sequence on the agent's sequencer
        seq.start(env.agent.seqr);

        // Simulate for some time or wait for conditions, then drop the objection
        #1000ns; 

        // Drop objection to allow simulation to end
        phase.drop_objection(this);
        
        uvm_report_info(get_full_name(), "END of run_phase", UVM_LOW);
    endtask : run_phase
    
endclass

`endif
