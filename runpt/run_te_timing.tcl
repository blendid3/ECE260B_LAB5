### read all timing libraries

read_lib ./tsmc65wc.lib
read_lib ./tsmc65bc.lib

set link_path [ list * tsmc65wc tsmc65bc ]

### read verilog
read_verilog aes_cipher_top.v

### link design --> this step associates liberty models to cells in the design 
link_design aes_cipher_top 

### wc
set_operating_conditions -analysis_type single WCCOM -library tsmc65wc

### read timing constraints
read_sdc aes_cipher_top.sdc
set_propagated_clock clk

### read SPEF 
read_parasitics ./aes_cipher_top.spef

### set the precision in measurements
set report_default_significant_digits 6

update_timing -full

### report timing to 10 worst paths
report_timing -slack_lesser_than 1.0 -nworst 10 -sig 6 -path_type full_clock -transition_time -nets -capacitance > wc_top10_worst_paths.rpt

### report end-point timing
### end-points in the design are registers of timing paths and outputs
set endpoints [add_to_collection [all_registers -data_pins] [all_outputs]]
report_timing -slack_lesser_than 1.0 -to $endpoints -max_paths [sizeof_collection $endpoints] -path_type end -nosplit > wc_end_point_timing.rpt

exit
