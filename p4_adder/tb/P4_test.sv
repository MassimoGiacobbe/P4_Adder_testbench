`ifndef P4_TEST
`define	P4_TEST

`include "P4_env.sv"


class p4_test extends uvm_test;

    `uvm_component_utils(p4_test)
    
    P4_env env;
    
    
    function new (string name="p4_test", uvm_component parent=null);
        super.new (name, parent);
    endfunction : new
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = P4_env::type_id::create("env", this);
    endfunction : build_phase
    

    virtual task run_phase(uvm_phase phase);
        

        p4_sequence seq;
        uvm_report_info(get_full_name(), "START of run_phase", UVM_LOW);
        
        seq = p4_sequence::type_id::create("seq");
        
        if (!seq) begin
            `uvm_fatal("SEQ_NULL", "Failed to create sequence")
        end
        

        // Raise objection to keep the simulation running
        phase.raise_objection(this);

        // Start the sequence on the agent's sequencer
        seq.start(env.agent.seqr);
        uvm_report_info("SEQ_START", "Starting p4_sequence", UVM_HIGH);


        // Simulate for some time or wait for conditions, then drop the objection
        #10ns; 

        // Drop objection to allow simulation to end
        phase.drop_objection(this);
        
        uvm_report_info(get_full_name(), "END of run_phase", UVM_LOW);
    endtask : run_phase
    
endclass

`endif
