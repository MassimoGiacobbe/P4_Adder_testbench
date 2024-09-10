# P4 adder


# Pentium 4 Adder UVM Testbench

## Project Overview

This repository contains the UVM-based testbench for the **Pentium 4 Adder**, developed as part of the SoC Verification workshop. The Pentium 4 Adder uses a carry-select adder structure with a propagate-generate network to enhance speed and performance. This UVM testbench verifies the functionality and correctness of the adder across various input conditions.

## Features

- **Scalable and Configurable**: The testbench supports scalability with parameters for adjusting the number of transactions and the parallelism of the adder.
- **Constrained Random Stimuli**: Focus on testing critical inputs such as corner cases and boundary conditions. Constraints ensure higher probability for testing edge cases like 0, max values, and alternating bit patterns.
- **Coverage Analysis**: Collects both functional and code coverage, with bins defined for full-range values, edge cases, and cross-coverage for input combinations.
- **Modular Components**: The testbench utilizes UVM components like sequences, drivers, monitors, and scoreboards, all connected through a reusable UVM agent and environment.

## Structure

- `pkg`: Defines the scalable parameters for the testbench.
- `sequence_item`: Contains the input and output data structure, including random constraints for generating stimuli.
- `driver`: Drives the stimuli to the Device Under Test (DUT) via an interface.
- `monitor`: Passively collects outputs from the DUT for comparison with the expected results.
- `scoreboard`: Compares actual vs. expected outputs and reports mismatches.
- `coverage`: Measures code and functional coverage.

## Usage

1. Clone the repository:
2. Go into the sim folder and give permissions to the "start_sim.sh" script
3. run the script
