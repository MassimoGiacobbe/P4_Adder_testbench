`include "P4_sequencer.sv"
`include "P4_driver.sv"
`include "P4_monitor.sv"
`include "uvm.svh"
import uvm_pkg::*;


class p4_adder_agent extends uvm_agent;
    `uvm_component_utils(p4_adder_agent)

    // Declare  the agent's components
    p4_adder_sequencer seqr;
    p4_adder_driver drv;
    p4_adder_monitor mon;

    // Agent mode
    bit is_active;

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(bit)::get(this, "", "is_active", is_active))
            is_active = 1; // Default to active

        // Instantiate components based on the agent's mode
        if (is_active) begin
            seqr = p4_adder_sequencer::type_id::create("seqr", this);
            drv = p4_adder_driver::type_id::create("drv", this);
        end

        mon = p4_adder_monitor::type_id::create("mon", this);
    endfunction

    // Connect phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        // Connect the driver and sequencer in active mode
        if (is_active) begin
            drv.seq_item_port.connect(seqr.seq_item_export);
        end

        // Connect the monitor to the DUT interface
        if (mon != null && drv != null) begin
            mon.vif = drv.vif; // Use the same interface for monitoring and driving
        end
    endfunction

endclass
