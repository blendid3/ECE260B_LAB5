##############################################################################
# Template generated by SiliconSmart L-2016.06-SP1-2 (built on Dec 07, 2016 16:59:49) #
# SiliconSmart Path: /acsnfs3/software/SiliconSmartAce-2016.06-SP1-2/linux64/bin/siliconsmart #
# Host Name: ieng6-249.ucsd.edu, User Name: haz023, PID: 5005 #
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
$tempTestColl makeFormalPorts {A1 Z A2}
$tempTestColl setParameter retention_ports {}
$tempTestColl setParameter synch_controls {}
$tempTestColl setParameter clock_ports {}
$tempTestColl setParameter asynch_ports {}
$tempTestColl setParameter asynch_ports_active_state {}

## 
## Tests

## 
## Test delay__A2__hl__Z__hl
set tempTest [ SBTest "delay__A2__hl__Z__hl" ]
$tempTest setTargets { delay__A2__hl__Z__hl Cin__A2__hl Tout__Z__hl cap_energy__Z__hl energy1__A2__hl__Z__hl__vdd energy1__A2__hl__Z__hl__vss energy__A2__hl__Z__hl leakage_power1__vdd leakage_power1__vss leakage_power2__vdd leakage_power2__vss }
$tempTest setTargetInputs {
  {A2 hl}}

$tempTest setTargetOutputs {
  {Z hl}}

$tempTest setSwitchingInputs {
  {A2 hl}}

$tempTest setAnalysisType tranPlus
$tempTest setAllStatesCovered 0

## 
## Sweep Specification
$tempTest setTagNumTableDimensions 0 mpw

## 
## Harnesses
$tempTest setAcquire 1
$tempTest setStateCoverage "!A1"

## 
## ACQ_1
set tempAcq [ SBDelayAcquisition "ACQ_1" ]
$tempAcq setHarnessName default
$tempAcq setAcquire 1
$tempAcq setState "!A1"
$tempAcq setStateCoverage "!A1"
$tempAcq setAdditionalStateCoverage "!A1" "energy1__A2__hl__Z__hl__vss"
$tempAcq setAdditionalStateCoverage "!A1" "leakage_power2__vss"
$tempAcq setAdditionalStateCoverage "!A1" "energy1__A2__hl__Z__hl__vdd"
$tempAcq setAdditionalStateCoverage "!A1" "leakage_power1__vss"
$tempAcq setAdditionalStateCoverage "!A1" "leakage_power1__vdd"
$tempAcq setAdditionalStateCoverage "!A1" "energy__A2__hl__Z__hl"
$tempAcq setAdditionalStateCoverage "!A1" "leakage_power2__vdd"
$tempAcq setAdditionalStateCoverage "!A1" "cap_energy__Z__hl"
$tempAcq setWhen "1"
$tempAcq setAdditionalWhen "1" "energy1__A2__hl__Z__hl__vss"
$tempAcq setAdditionalWhen "1" "leakage_power2__vss"
$tempAcq setAdditionalWhen "1" "energy1__A2__hl__Z__hl__vdd"
$tempAcq setAdditionalWhen "1" "leakage_power1__vss"
$tempAcq setAdditionalWhen "1" "leakage_power1__vdd"
$tempAcq setAdditionalWhen "1" "energy__A2__hl__Z__hl"
$tempAcq setAdditionalWhen "1" "leakage_power2__vdd"
$tempAcq setAdditionalWhen "1" "cap_energy__Z__hl"

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { A1 Z:inout A2 } { initial_delay units ct default_slew pp energy_change_threshold energy_change_abs_threshold }

$tempWT setStimulus                            {   A1   A2   Z     } {
                             "0"            {} {   0    0    Z,1   }
                 "initial_delay"            {} {   -    1    -,-   }
       "initial_delay+0.5*units" { start out } {   -    0    Z,0   }
"(initial_delay+0.5*units)+(pp)"            {} {   -    -    -,-   }
}

$tempWT addMeasurements {} {
  { tin_A2               Tin        { A2 start } NO_USER SYS }
  { cin_A2               Cin        { A2 start } NO_USER SYS }
  { tout_Z               Tout       { Z out } NO_USER SYS }
  { delay_A2_Z           delay      { A2 start Z out } NO_USER SYS }
  { energy__A2__hl__Z__hl energy     { start pp energy_change_threshold energy_change_abs_threshold 0 } NO_USER SYS }
  { energy1__A2__hl__Z__hl__vdd energy1    { start pp energy_change_threshold energy_change_abs_threshold 0 vdd } }
  { leakage_power1__vdd  leakage_power1 { initial_delay+0.5*units+0.95*pp initial_delay+0.5*units+pp vdd } }
  { leakage_power2__vdd  leakage_power2 { initial_delay+0.5*units+0.90*pp initial_delay+0.5*units+0.95*pp vdd } }
  { energy1__A2__hl__Z__hl__vss energy1    { start pp energy_change_threshold energy_change_abs_threshold 0 vss } }
  { leakage_power1__vss  leakage_power1 { initial_delay+0.5*units+0.95*pp initial_delay+0.5*units+pp vss } }
  { leakage_power2__vss  leakage_power2 { initial_delay+0.5*units+0.90*pp initial_delay+0.5*units+0.95*pp vss } }
  { cap_energy__Z__hl    cap_energy { start pp cap_Z Z 0 } }
}

$tempWT bindInterface { A1 Z A2 } { 10e-12 A2[cycle_time] A2[cycle_time] A2[default_slew] cell_power_period power_stabilization_threshold power_stabilization_threshold_absolute }
$tempAcq addWaveTable $tempWT
release_obj $tempWT

## 
## Sweep Specification
$tempAcq setTagNumTableDimensions 0 mpw

## 
## Harnesses

set tempHarness [ SBHarness default ]
set tempTopOp [ SBTopologyOperation ]
$tempTopOp setElement dcvs
$tempTopOp setElementName cap_ground_Z
$tempTopOp setOperation insert
$tempTopOp setNodes {ground_Z 0}
$tempTopOp setParam {0}
$tempHarness addTopologyOperation $tempTopOp
release_obj $tempTopOp
set tempTopOp [ SBTopologyOperation ]
$tempTopOp setElement capacitor
$tempTopOp setElementName cap_Z
$tempTopOp setOperation insert
$tempTopOp setNodes {Z ground_Z}
$tempTopOp setParam {load_Z}
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

