`ifndef P4_COV_SV
`define P4_COV_SV
    // Include the sequence item
    `include "P4_sequence_item.sv"
    `include "P4_interface.sv"
    // Coverage subscriber class

class p4_coverage extends uvm_subscriber #(p4_sequence_item);
    
    `uvm_component_utils(p4_coverage)
    // Sequence item object
    p4_sequence_item item;
    virtual p4_if vif;
    real cov;
    // Coverage collector variables
    covergroup cg_a_b_cin @(posedge vif.clk )        // Sampling the coverage on the positive edge of the clock

        // Coverpoint for input a
        coverpoint  item.rand_in.a  iff (vif !== null && item !== null){
            bins full_range[] = {0, [1:(1<<nbit)-2], (1<<nbit)-1};
        }

        // Coverpoint for input b
        coverpoint item.rand_in.b iff (vif !== null && item !== null){
            bins full_range[] = {0, [1:(1<<nbit)-2], (1<<nbit)-1};
        }

        // Coverpoint for input cin
        coverpoint item.rand_in.cin iff (vif !== null && item !== null){
            bins low = {0};
            bins high = {1};
        }

        // Cross coverage for a, b, and cin
        cross item.rand_in.a, item.rand_in.b, item.rand_in.cin;

    endgroup

    // Constructor
    function new(string name = "p4_coverage", uvm_component parent);
        super.new(name, parent);
        cg_a_b_cin = new;
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Retrieve the virtual interface from the UVM config DB
        if (!uvm_config_db#(virtual p4_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("CFGDB", "Failed to get virtual interface from Config DB")
        end
    endfunction

    // Write function to sample the coverage
    virtual function void write(p4_sequence_item t);
        if (t == null) begin
            `uvm_error("WRITE", "Null sequence item passed to coverage")
            return;
        end
        item = t;
        if (cg_a_b_cin != null) begin
            cg_a_b_cin.sample();
        end
    endfunction


    //extract phase
    function void extract_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Extracting coverage...", UVM_MEDIUM);
       cov=cg_a_b_cin.get_coverage(); // Write the coverage to the database
    endfunction

    // Report phase
    function void report_phase(uvm_phase phase);
        `uvm_info(get_full_name(),$sformatf("Coverage is 
        %d",cov),UVM_MEDIUM);
    endfunction


endclass

`endif