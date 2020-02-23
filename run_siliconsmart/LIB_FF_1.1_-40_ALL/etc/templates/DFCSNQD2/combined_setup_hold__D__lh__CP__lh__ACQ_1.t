##############################################################################
# Template generated by SiliconSmart L-2016.06-SP1-2 (built on Dec 07, 2016 16:59:49) #
# SiliconSmart Path: /acsnfs3/software/SiliconSmartAce-2016.06-SP1-2/linux64/bin/siliconsmart #
# Host Name: ieng6-249.ucsd.edu, User Name: haz023, PID: 5349 #
# Directory: /home/linux/ieng6/ee260bwi20/haz023/lab5/run_siliconsmart/LIB_FF_1.1_-40_ALL #
# Date Fri, 21 Feb 2020 15:13:53 PST #
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
$tempTestColl makeFormalPorts {Q SDN CDN CP D}
$tempTestColl setParameter retention_ports {}
$tempTestColl setParameter synch_controls {SDN CDN}
$tempTestColl setParameter clock_ports {CP}
$tempTestColl setParameter asynch_ports {SDN CDN}
$tempTestColl setParameter asynch_ports_active_state {CDN 10 SDN 10}

## 
## Tests

## 
## Test combined_setup_hold__D__lh__CP__lh
set tempTest [ SBTest "combined_setup_hold__D__lh__CP__lh" ]
$tempTest setTargets { combined_setup_hold__D__lh__CP__lh }
$tempTest setTargetInputs {
  {D lh}}

$tempTest setTargetOutputs {
  {Q lh}}

$tempTest setTargetReferences {
  {CP lh}}

$tempTest setSwitchingInputs {
  {D lh}}

$tempTest setSwitchingRefs {
  {CP lh}}

$tempTest setAnalysisType tranPlus

## 
## Sweep Specification
$tempTest setTagNumTableDimensions 0 mpw

## 
## Harnesses
$tempTest setAcquire 1
$tempTest setStateCoverage "CDN&!CP&SDN"

## 
## ACQ_1
set tempAcq [ SBCombinedSetupHoldAcquisition "ACQ_1" ]
$tempAcq setHarnessName default
$tempAcq setAcquire 1
$tempAcq setState "CDN&SDN"
$tempAcq setStateCoverage "CDN&SDN"
$tempAcq setWhen "1"

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { Q:out SDN CP CDN D } { initial_delay units ct default_slew epsilon width setup hold opt_tolerance dependent_max_width }

$tempWT setStimulus                                                                       {   SDN  CP   CDN  D    Q     } {
                                                                          "0"          {} {   1    1    0    1    0     }
                                                              "initial_delay"          {} {   -    -    -    0    -     }
                                                    "initial_delay+0.5*units"          {} {   -    0    -    -    -     }
                                                      "initial_delay+1*units"          {} {   -    -    1    -    -     }
                                                    "initial_delay+1.5*units"     { in1 } {   -    -    -    1    -     }
"initial_delay+1.5*units-setup+(width+slew_D*3)/2-slew_CP*1.199857+(2.5e-10)" { in2 out } {   -    1    -    -    1     }
                                   "initial_delay+1.5*units-setup+width-hold"     { in3 } {   -    -    -    0    -     }
                     "initial_delay+1.5001*units+dependent_max_width+1.25*ct"          {} {   -    -    -    -    -     }
}

$tempWT addMeasurements {} {
  { tin_D_1              Tin        { D in1 } NO_USER SYS }
  { tin_D_2              Tin        { D in3 } NO_USER SYS }
  { tin_CP               Tin        { CP in2 } NO_USER SYS }
  { setup_D_CP           setup      { D in1 CP in2 } NO_USER SYS }
  { hold_D_CP            hold       { D in3 CP in2 } NO_USER SYS }
  { tout_Q               Tout       { Q in2 } NO_USER SYS }
  { delay_CP_Q           delay      { CP in2 Q in2 } NO_USER SYS }
  { fallback_Q           fallback   { Q in2 0 } NO_USER SYS }
}

$tempWT addOptimization    width    slew_D*3+epsilon    dependent_max_width+5e-10    delay_CP_Q    { tin_D_1 tin_D_2 tin_CP setup_D_CP hold_D_CP tout_Q delay_CP_Q tout_Q delay_CP_Q } { fallback_Q fallback_Q } {  } {  } expand None opt_tolerance dependent_max_width slew_D*3+epsilon dependent_max_width+5e-10 "1"
$tempWT addOptimization    setup    min(epsilon,width-(slew_D*3+epsilon))    width-(slew_D*3+epsilon)    delay_CP_Q    { tin_D_1 tin_D_2 tin_CP setup_D_CP hold_D_CP tout_Q delay_CP_Q tout_Q delay_CP_Q } { fallback_Q fallback_Q } { width hold } {  } refine None opt_tolerance min(epsilon,width-(slew_D*3+epsilon)) width-(slew_D*3+epsilon) 0 "1"
$tempWT addOptimization    hold    -1e-11    -1e-11    delay_CP_Q    { tin_D_1 tin_D_2 tin_CP setup_D_CP hold_D_CP tout_Q delay_CP_Q tout_Q delay_CP_Q } { fallback_Q fallback_Q } { width } {  } expand None opt_tolerance -1e-11 -1e-11 0 "1"
$tempWT bindInterface { Q SDN CP CDN D } { cell_initial_delay CP[cycle_time] CP[cycle_time] CP[default_slew] 1e-11 None 0.0 0.0 D[constraint_resolution] D[dependent_max_width] }
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

