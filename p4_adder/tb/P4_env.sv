`ifndef P4_ENV
`define P4_ENV

`include "P4_agent.sv"
`include "P4_scoreboard.sv"
import uvm_pkg::*;

class P4_env extends uvm_env;
    `uvm_component_utils(P4_env)

    // Declare the agent and scoreboard
    p4_agent agent;
    p4_scoreboard scoreboard;

    // Constructor
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        uvm_report_info(get_full_name(), "START of build_phase", UVM_LOW);

        // Instantiate the agent
        agent = p4_agent::type_id::create("agent", this);

        // Instantiate the scoreboard
        scoreboard = p4_scoreboard::type_id::create("scoreboard", this);

        uvm_report_info(get_full_name(), "END of build_phase", UVM_LOW);
    endfunction: build_phase

    // Connect phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        uvm_report_info(get_full_name(), "START of connect_phase", UVM_LOW);

        // Connect the monitor's analysis port to the scoreboard's analysis export
        if (agent.mon != null && scoreboard != null) begin
            agent.mon.ap.connect(scoreboard.analysis_export);
        end

        uvm_report_info(get_full_name(), "END of connect_phase", UVM_LOW);
    endfunction: connect_phase

endclass

`endif
