#!/bin/bash

# Source the Questa environment
source /eda/scripts/init_questa_core_prime

# Clean previous simulation data
vdel -all

# Create a new library
vlib work

# Compile SystemVerilog and VHDL files
vcom -f compile_src.f -mixedsvvh
if [ $? -ne 0 ]; then
    echo "VHDL compilation failed."
    exit 1
fi

vlog -f compile_tb.f -mixedsvvh
if [ $? -ne 0 ]; then
    echo "SystemVerilog compilation failed."
    exit 1
fi

# If compilation succeeds, run the simulation
vsim -c -do sim.do P4_top
if [ $? -ne 0 ]; then
    echo "Simulation failed."
    exit 1
fi
