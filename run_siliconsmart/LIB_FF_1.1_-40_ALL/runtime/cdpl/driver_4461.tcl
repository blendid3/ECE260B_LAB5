if { [catch {
set_location /home/linux/ieng6/ee260bwi20/haz023/lab5/run_siliconsmart/LIB_FF_1.1_-40_ALL
set_log_file /home/linux/ieng6/ee260bwi20/haz023/lab5/run_siliconsmart/LIB_FF_1.1_-40_ALL/temp/sis.haz023.[pid].log
set_log_level info
set_log_stdout_level info
set jobName [lindex $argv 0]

# Parameter block and pintype definitions.  The following definitions
# preserve any (pintype) parameters set outside of the configure.tcl file.
define_parameters default {
    set PLACEHOLDER X
}

define_parameters liberty_model {
    set default_cell_leakage_power 0.0
    set default_fanout_load 0.0
    set default_inout_pin_cap 0.0
    set default_input_pin_cap 0.0
    set default_leakage_power_density 0.0
    set default_output_pin_cap 0.0
    set delay_model table_lookup
}

pintype default {
    set PLACEHOLDER X
}

# Liberty attributes set by user
set_liberty_attribute -cell DFCSNQD1 -pin D nextstate_type data
set_liberty_attribute -cell DFCSNQD2 -pin D nextstate_type data
set_liberty_attribute -cell DFCSNQD4 -pin D nextstate_type data
# Liberty groups added by the user
# Liberty attributes cleared by user

#Operating conditions

create_operating_condition FF_1.1_-40_ALL
add_opc_supplies FF_1.1_-40_ALL vdd 1.1
add_opc_grounds FF_1.1_-40_ALL vss 0.0

## 
## User-specified characterization and modeling configuration options.
## 

create_parameter import_sensitization_vector
set_config_opt -- import_sensitization_vector 0

create_parameter is_char_mode
set_config_opt -- is_char_mode 0

create_parameter lvf_license
set_config_opt -- lvf_license 0

create_parameter pureRecharFlow
set_config_opt -- pureRecharFlow 0

create_parameter rechar_mode
set_config_opt -- rechar_mode 0

create_parameter slew_derate_lower_threshold
set_config_opt -- slew_derate_lower_threshold 0.3

create_parameter slew_derate_upper_threshold
set_config_opt -- slew_derate_upper_threshold 0.7

} err ] } {

# Connect back to the server to send err message.
startCdplWorker $err
exit 0
} else {

# Connect back to the server to retrieve the jobs.
startCdplWorker "" 
log_info "CDPL worker exited normally."
if { [catch {exec mv -f /home/linux/ieng6/ee260bwi20/haz023/lab5/run_siliconsmart/LIB_FF_1.1_-40_ALL/temp/sis.haz023.[pid].log /home/linux/ieng6/ee260bwi20/haz023/lab5/run_siliconsmart/LIB_FF_1.1_-40_ALL/runtime/cdpl/sis.W$::env(CDPL_WORKERID).[get_hostname].[pid].log} mv_err] } {
  log_warning $mv_err
}
set_log_file /home/linux/ieng6/ee260bwi20/haz023/lab5/run_siliconsmart/LIB_FF_1.1_-40_ALL/runtime/cdpl/sis.W$::env(CDPL_WORKERID).[get_hostname].[pid].log
exit 0
}
