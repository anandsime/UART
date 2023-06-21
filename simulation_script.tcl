# Create a new project
create_project -force my_project ./my_project -part xcku025-ffva1156-2-e

# Add design and testbench files
add_files ./uart.v
add_files ./uart_tb.v

# Set the top-level design
set_property top uart_tb [current_fileset]

# Set the simulator to use XSIM

# set_property simulator_language Verilog [current_project]
# set_property target_simulator Vivado Simulator [current_fileset]

# Compile design and testbench
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# Run simulation
launch_simulation

# Wait for simulation to complete
wait_on_simulation

# Generate waveform
open_waveform_file ./sim_1/behav/xsim/my_project_tb.wcfg
add_wave -position insertpoint sim:/my_project_tb/uut/*
run 500 ns
waveform zoom full
waveform save ./my_project_tb_waveform.vcd
close_waveform

# Exit Vivado
exit
