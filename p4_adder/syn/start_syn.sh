#!/bin/bash

# Define the top-level design and output netlist name
TOP_LEVEL="p4_adder"
OUTPUT_NETLIST="p4_netlist.vhdl"
WORK_DIR="work"

# Remove previous synthesis files
if [ -d "$WORK_DIR" ]; then
    rm -r -f "$WORK_DIR"
fi

mkdir "$WORK_DIR"

if [ -f "$OUTPUT_NETLIST" ]; then
    rm "$OUTPUT_NETLIST"
fi

# List of VHDL files in hierarchical order
FILES=(
    pkg_graph.vhd
    pkg_imath.vhd
    mux21.vhd
    fa.vhd
    rca.vhd
    group_G.vhd
    group_PG.vhd
    pg_network.vhd
    sparse_tree.vhd
    sum_generator.vhd
    carry_generator.vhd
    p4_adder.vhd
)

# Set environment
source /eda/scripts/init_design_vision

# Run the Design Vision tool with commands directly in bash
dc_shell-xg-t << EOF
# Set search path to the current directory
set search_path [getenv PWD]

# Create a new work library in the WORK_DIR
define_design_lib WORK_DIR -path ./work

# Set the current library to WORK_DIR
set_lib_path -work WORK_DIR

# Set the current working library to WORK_DIR
set_current_lib WORK_DIR

# Set the top-level design
set_top TOP_LEVEL

# Read and analyze all VHDL files
foreach file [list ${FILES[@]}] {
    analyze -format vhdl \$file -work WORK_DIR
}

# Elaborate the design
elaborate \TOP_LEVEL -architecture  structural -library WORK_DIR

# Perform synthesis
compile -exact_map

# Write the synthesized netlist to the specified VHDL file
write -format vhdl -hierarchy -output ${OUTPUT_NETLIST}

# Exit Design Vision
quit
EOF
