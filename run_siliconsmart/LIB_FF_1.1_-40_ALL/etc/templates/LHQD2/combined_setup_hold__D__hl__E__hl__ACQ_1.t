##############################################################################
# Template generated by SiliconSmart L-2016.06-SP1-2 (built on Dec 07, 2016 16:59:49) #
# SiliconSmart Path: /acsnfs3/software/SiliconSmartAce-2016.06-SP1-2/linux64/bin/siliconsmart #
# Host Name: ieng6-249.ucsd.edu, User Name: haz023, PID: 5262 #
# Directory: /home/linux/ieng6/ee260bwi20/haz023/lab5/run_siliconsmart/LIB_FF_1.1_-40_ALL #
# Date Fri, 21 Feb 2020 15:13:51 PST #
#                                                                            #
# Copyright (C) 2016 Synopsys Inc.                                #
# This file contains confidential and proprietry information.                #
# All rights reserved.                                                       #
#                                                                            #
##############################################################################

set tempTestColl [ SBTestCollection automap ]


# Specifies the version of the template API expected by this file.
$tempTestColl setTemplateVer 7

## 
## Configuration Flags
$tempTestColl setConfigurationFlags { doTiming doPower }

## 
## Formal Ports
$tempTestColl makeFormalPorts {Q E D}
$tempTestColl setParameter retention_ports {}
$tempTestColl setParameter synch_controls {}
$tempTestColl setParameter clock_ports {E}
$tempTestColl setParameter asynch_ports {}
$tempTestColl setParameter asynch_ports_active_state {}

## 
## Tests

## 
## Test combined_setup_hold__D__hl__E__hl
set tempTest [ SBTest "combined_setup_hold__D__hl__E__hl" ]
$tempTest setTargets { combined_setup_hold__D__hl__E__hl }
$tempTest setTargetInputs {
  {D hl}}

$tempTest setTargetOutputs {
  {Q hl}}

$tempTest setTargetReferences {
  {E hl}}

$tempTest setSwitchingInputs {
  {D hl}}

$tempTest setSwitchingRefs {
  {E hl}}

$tempTest setAnalysisType tranPlus

## 
## Sweep Specification
$tempTest setTagNumTableDimensions 0 mpw

## 
## Harnesses
$tempTest setAcquire 1
$tempTest setStateCoverage "E"

## 
## ACQ_1
set tempAcq [ SBCombinedSetupHoldAcquisition "ACQ_1" ]
$tempAcq setHarnessName default
$tempAcq setAcquire 1
$tempAcq setState "1"
$tempAcq setStateCoverage "1"
$tempAcq setWhen "1"

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { Q:out E D } { initial_delay units ct default_slew epsilon width setup hold glitch_threshold_Q opt_tolerance dependent_max_width }

$tempWT setStimulus                                                                    {   E    D    Q     } {
                                                                       "0"          {} {   0    0    1     }
                                                           "initial_delay"          {} {   -    1    -     }
                                                 "initial_delay+0.5*units"          {} {   1    -    -     }
                                                   "initial_delay+1*units" { in1 out } {   -    0    0     }
"initial_delay+1*units-setup+(width+slew_D*3)/2-slew_E*1.199857+(2.5e-10)"     { in2 } {   0    -    -     }
                                  "initial_delay+1*units-setup+width-hold"     { in3 } {   -    1    1     }
                  "initial_delay+1.0001*units+dependent_max_width+1.25*ct"          {} {   -    -    -     }
}

$tempWT addMeasurements {} {
  { tin_D_1              Tin        { D in1 } NO_USER SYS }
  { tin_D_2              Tin        { D in3 } NO_USER SYS }
  { tin_E                Tin        { E in2 } NO_USER SYS }
  { setup_D_E            setup      { D in1 E in2 } NO_USER SYS }
  { hold_D_E             hold       { D in3 E in2 } NO_USER SYS }
  { hold_glitch_Q        glitch_delay { D in3 Q in3 glitch_threshold_Q } NO_USER SYS }
  { tout_Q               Tout       { Q in1 } NO_USER SYS }
  { delay_D_Q            delay      { D in1 Q in1 } NO_USER SYS }
  { fallback_Q           fallback   { Q in1 0 } NO_USER SYS }
}

$tempWT addOptimization    width    slew_D*3+epsilon    dependent_max_width+5e-10    delay_D_Q    { tin_D_1 tin_D_2 tin_E setup_D_E hold_D_E tout_Q delay_D_Q tout_Q delay_D_Q } { hold_glitch_Q fallback_Q fallback_Q } {  } {  } expand None opt_tolerance dependent_max_width slew_D*3+epsilon dependent_max_width+5e-10 "1"
$tempWT addOptimization    setup    min(epsilon,width-(slew_D*3+epsilon))    width-(slew_D*3+epsilon)    delay_D_Q    { tin_D_1 tin_D_2 tin_E setup_D_E hold_D_E tout_Q delay_D_Q tout_Q delay_D_Q } { hold_glitch_Q fallback_Q fallback_Q } { width hold } {  } refine None opt_tolerance min(epsilon,width-(slew_D*3+epsilon)) width-(slew_D*3+epsilon) 0 "1"
$tempWT addOptimization    hold    -1e-11    -1e-11    delay_D_Q    { tin_D_1 tin_D_2 tin_E setup_D_E hold_D_E tout_Q delay_D_Q tout_Q delay_D_Q } { hold_glitch_Q fallback_Q fallback_Q } { width } {  } expand None opt_tolerance -1e-11 -1e-11 0 "1"
$tempWT bindInterface { Q E D } { cell_initial_delay E[cycle_time] E[cycle_time] E[default_slew] 1e-11 None 0.0 0.0 Q[logic_low_threshold_fall] D[constraint_resolution] D[dependent_max_width] }
$tempAcq addWaveTable $tempWT
release_obj $tempWT

## 
## Sweep Specification
$tempAcq setTagNumTableDimensions 0 mpw

## 
## Harnesses

set tempHarness [ SBHarness default ]
set tempTopOp [ SBTopologyOperation ]
$tempTopOp setElement capacitor
$tempTopOp setElementName cap_Q
$tempTopOp setOperation insert
$tempTopOp setNodes {Q Q[logic_low_name]}
$tempTopOp setParam {load_Q}
$tempHarness addTopologyOperation $tempTopOp
release_obj $tempTopOp
$tempAcq addHarness $tempHarness
release_obj $tempHarness

$tempAcq setHarnessName default
$tempTest addAcquisition $tempAcq
release_obj $tempAcq

$tempTestColl addTest $tempTest
release_obj $tempTest

set tempTestColl

