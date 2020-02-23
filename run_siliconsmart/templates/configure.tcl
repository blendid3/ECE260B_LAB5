# See SiliconSmart User Guide Appendix B for a complete list of parameters and definitions

#################################
# OPERATING CONDITIONS DEFINITION
#################################
#
# Create one or more operation conditions here.  Example:
#
#    create_operating_condition op_cond
#    set_opc_process op_cond {
#        {.lib "<LIB_NAME>" <TAG>}
#        {.lib "<LIB_NAME>" <TAG>}
#    }
#    add_opc_supplies op_cond VDD 1.1
#    add_opc_grounds op_cond VSS 0.0
#    set_opc_temperature op_cond 25
#

#set run_dir "/home/secure_projects/AVS_EM/SS"
#set input_dir "$run_dir/input_files"

create_operating_condition _CON_
set_opc_process _CON_ {
{.lib _LIB_DIR_ _PROCESS_}
}

add_opc_supplies _CON_ vdd _VDD_
add_opc_grounds _CON_ vss 0.0
set_opc_temperature _CON_ _TEMP_

#################################
# GLOBAL CONFIGURATION PARAMETERS
#################################
define_parameters default {

    # List of operating conditions as defined by create_operation_condition
    set active_pvts { _CON_ }

    # constraint mode
    set constraint_mode { dependent-setup }

    # If using IBIS, one operating condition must be specified in ibis_typ_pvt
    # set ibis_typ_pvt SS

    # # FINESIM
    # set simulator finesim
    # set simulator_cmd {finesim_spice -w <input_deck> -o <listing_file> >&/dev/null}

    # FINESIM EMBEDDED
    # set simulator finesim_embedded

    #HSPICE
    set simulator hspice
    set simulator_cmd {hspice <input_deck> -o <listing_file>}

    # # HSPICE (client/server mode)
    # set simulator hspice_cs
    # set simulator_cmd {hspice -CC <input_deck> -port <port_num> -o <listing_file>}
    
    # SPECTRE
    # set simulator spectre6
    # set simulator_cmd {spectremdl -tab -batch <mdl_file> -design <input_deck> <listing_file> >&/dev/null}
    
    # ELDO
    # set simulator eldo
    # set simulator_cmd {eldo -compat -i <input_deck> > <listing_file> >&/dev/null}

    # MSIM
    # set simulator msim
    # (csh)
    # set simulator_cmd {msim -hsp -i <input_deck> -o <listing_file> >&/dev/null}
    # (sh)
    # set simulator_cmd {msim -hsp -i <input_deck> -o <listing_file> 2>/dev/null}
   

    # Default simulator options for Finesim, Hspice, Spectre, Msim, and Eldo
    set simulator_options {
	"common,hspice: accurate autostop post list node"
    }

    # Simulation resolution
    set time_res_high 1e-13

    # Controls which supplies are measured for power consumption
    set power_meas_supplies { vdd}

    # list of ground supplies used (required for Functional Recognition)
    set power_meas_grounds { vss}

    # specifies which multi-rail format to be used in Liberty model; none, v1, or v2.
    set liberty_multi_rail_format none

    # LOAD SHARE PARAMETERS
    #  job_scheduler: 'lsf' (Platform), 'grid' (SunGrid), or 'standalone' (local machine)
    #set job_scheduler standalone
    set job_scheduler standalone
    set run_list_maxsize 25
    set normal_queue "normal"
    set simulation_tmpdir _TEMP_DIR_
}


############################
# DEFAULT PINTYPE PARAMETERS
############################
pintype default {
    set_config_opt -pin * soi_transition_mode second

    set prop_delay_out_level_fall 0.5
    set prop_delay_out_level_rise 0.5
    set prop_delay_inp_level_fall 0.5
    set prop_delay_inp_level_rise 0.5

    set logic_high_name vdd
    set logic_high_threshold 0.7

    set logic_low_name vss
    set logic_low_threshold 0.3

    set prop_delay_level 0.5

    # Number of slew and load indices
    # (when importing with -use_default_slews -use_default_loads)
    set numsteps_slew 6
    set numsteps_load 5
    set constraint_numsteps_slew 3

    # Operating load ranges
    set smallest_load 10e-15
    set largest_load 90e-15

    # Operating slew ranges
    set smallest_slew 3e-12
    #set largest_slew 1.2e-9
    set largest_slew 0.1e-9
    set max_tout 10e-9

    # Automatically determine largest_load based on max_tout; off or on
    set autorange_load off
    #set autorange_load on

    # Noise of points in for noise height
    set numsteps_height 8

    # Input noise width.
    set numsteps_width 5

    # driver model: pwl, emulated, active, active-waveform, custom
    set driver_mode emulated

    # driver cell name (relevant only when driver_mode is "active")
    #set driver C12T32_LR_BFX16
    set logic_low_threshold_fall 0.3
    set logic_high_threshold_fall 0.7
    set logic_low_threshold_rise 0.3
    set logic_high_threshold_rise 0.7
}


#####################################
# LIBERTY MODEL GENERATION PARAMETERS
#####################################
define_parameters liberty_model {
    # Add Liberty header attributes here for use with "model -create_new_model"
    set delay_model "table_lookup"
    set default_fanout_load 0.0
    set default_inout_pin_cap 0.0
    set default_input_pin_cap 0.0
    set default_output_pin_cap 0.0
    set default_cell_leakage_power 0.0
    set default_leakage_power_density  0.0
}


#######################
# VALIDATION PARAMETERS
#######################
define_parameters validation {
    # Add validation parameters here
}
