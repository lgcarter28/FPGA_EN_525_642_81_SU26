# FPGA Coursework and VHDL Utilities

This repository contains FPGA coursework, lab submissions, board references, and reusable VHDL modules developed for a graduate FPGA design course.

## Repository Layout

- `module_1/` through `module_14/`: course modules, lecture material, lab assignments, and completed lab work.
- `utils/rtl/src/`: reusable VHDL building blocks intended to be shared across labs and future projects.
- `docs/`: board manuals, installation notes, and other general reference material.
- `deps/`: board-file dependencies and local constraint references, including the Digilent XDC submodule and locally maintained XDC variants.

## Reusable RTL

The shared RTL library currently includes seven-segment display support and small utility blocks:

- `seg7_hex.vhd`
- `seg7_controller.vhd`
- `seg7_anode_decode.vhd`
- `char_mux_8to1.vhd`
- `char_shift_register_8.vhd`
- `pulseGenerator.vhd`

These modules are kept separate from individual Vivado projects so they can be reused and improved over time.

## Coursework Artifacts

Lab submission folders such as `Lab1_Carter/`, `Lab2_Carter/`, and `Lab3_Carter/` keep the files required for grading, including final VHDL, constraints, bitstreams, and utilization reports.

Vivado-generated project output such as `.runs/`, `.cache/`, `.sim/`, `.hw/`, and intermediate implementation files is ignored. Final reports and bitstreams should be copied into the appropriate lab submission folder before being committed.

## Tooling Notes

The projects target Xilinx Vivado and Digilent Nexys-class development boards. Exact board constraints are stored with each lab submission when required.
