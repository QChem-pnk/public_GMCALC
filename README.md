# GMCALC

## Description

GMCALC is a program in BASH SHELL designed to make life easier between Gaussview, Gaussian and MOPAC programs.
It realizes several functions:
- Prepare a gaussian input directly from a gaussview gjf file.
- Launch said gaussian input.
- Prepare a MOPAC input directly from gaussian .log outut file.
- Launch said MOPAC input.
- Check status of outputs.

## Requeriments

Linux, Bash. Gaussian and MOPAC.

## Configuration

Paths, methods, and command for launching can be modified in the config.sh file in the main directory.

## Running

Commands are as follow:

- `./gmcalc --check`      Check files.
- `./gmcalc --init`        Initialize the program. Shows initial configuration.
- `./gmcalc --reset`      Reset the program to default.

- In general:
  - `./gmcalc [--startup_option] [molecule [method_for_gaussian [method_for_mopac] ] ]`
  
Examples:
- `./gmcalc --init ch2clf MP2 AM1`
- `./gmcalc ch4 MP2 AM1`

## To do

- [x] Functional program
- [x] Modules
- [x] More Gaussian options
