#!/bin/bash

#simple script to run a new vsim simulation


source /eda/scripts/init_questa_core_prime

vdel -all
vlib work

vcom -f compile_src.f -mixedsvvh

vlog -f compile.f -mixedsvvh

vsim -c -do sim.do p4_adder.vhd

