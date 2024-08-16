`include "P4_agent.sv"
import uvm_pkg::*;

class P4_env extends uvm_env;
    `uvm_component_utils(P4_env);

    //standard constructor
    function new(string name , uvm_component parent = null);
        super.new(name, parent);
        endfunction: new
    
    //build function, just calling the uvm build method and printing messages
    virtual function void build();
        super.build();            
        uvm_report_info(get_full_name(),"START of build ",UVM_LOW);
        
        uvm_report_info(get_full_name(),"END of build ",UVM_LOW);
        
    endfunction

    //connect function, same as before
    virtual function void connect();
        super.connect();
        uvm_report_info(get_full_name(),"START of connect ",UVM_LOW);
        
        uvm_report_info(get_full_name(),"END of connect ",UVM_LOW);
        endfunction

endclass