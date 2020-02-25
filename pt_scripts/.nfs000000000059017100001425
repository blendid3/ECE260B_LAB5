### read all timing libraries

read_lib ./tsmc65bc.lib

set link_path [ list * tsmc65bc ]

read_verilog aes_cipher_top.v
current_design aes_cipher_top
link_design aes_cipher_top

set_operating_conditions -analysis_type single BCCOM -library tsmc65bc

read_sdc aes_cipher_top.sdc
set_propagated_clock clk

read_parasitics ./aes_cipher_top.spef

set report_default_significant_digits 6

update_timing -full

# max_delay
report_timing -slack_lesser_than 1.0 -nworst 10 -sig 6 -path_type full_clock -transition_time -nets -capacitance > bc_setup.rpt
set endpoints [add_to_collection [all_registers -data_pins] [all_outputs]]
report_timing -slack_lesser_than 1.0 -to $endpoints -max_paths [sizeof_collection $endpoints] -path_type end -nosplit > bc_setup_end.rpt

# min_delay
report_timing -slack_lesser_than 1.0 -delay min -nworst 10 -sig 6 -path_type full_clock -transition_time -nets -capacitance > bc_hold.rpt
set endpoints [add_to_collection [all_registers -data_pins] [all_outputs]]
report_timing -slack_lesser_than 1.0 -delay min -to $endpoints -max_paths [sizeof_collection $endpoints] -path_type end -nosplit > bc_hold_end.rpt

exit
