##############################################################################
# Template generated by SiliconSmart L-2016.06-SP1-2 (built on Dec 07, 2016 16:59:49) #
# SiliconSmart Path: /acsnfs3/software/SiliconSmartAce-2016.06-SP1-2/linux64/bin/siliconsmart #
# Host Name: ieng6-249.ucsd.edu, User Name: haz023, PID: 5093 #
# Directory: /home/linux/ieng6/ee260bwi20/haz023/lab5/run_siliconsmart/LIB_FF_1.1_-40_ALL #
# Date Fri, 21 Feb 2020 15:13:54 PST #
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
## Test delay__A1__lh__Z__hl
set tempTest [ SBTest "delay__A1__lh__Z__hl" ]
$tempTest setTargets { delay__A1__lh__Z__hl Cin__A1__lh Tout__Z__hl cap_energy__Z__hl energy1__A1__lh__Z__hl__vdd energy1__A1__lh__Z__hl__vss energy__A1__lh__Z__hl leakage_power1__vdd leakage_power1__vss leakage_power2__vdd leakage_power2__vss }
$tempTest setTargetInputs {
  {A1 lh}}

$tempTest setTargetOutputs {
  {Z hl}}

$tempTest setSwitchingInputs {
  {A1 lh}}

$tempTest setAnalysisType tranPlus
$tempTest setAllStatesCovered 1

## 
## Sweep Specification
$tempTest setTagNumTableDimensions 0 mpw

## 
## Harnesses
$tempTest setAcquire 1
$tempTest setStateCoverage "A2"

## 
## ACQ_1
set tempAcq [ SBDelayAcquisition "ACQ_1" ]
$tempAcq setHarnessName default
$tempAcq setAcquire 1
$tempAcq setState "A2"
$tempAcq setStateCoverage "A2"
$tempAcq setAdditionalStateCoverage "A2" "energy1__A1__lh__Z__hl__vss"
$tempAcq setAdditionalStateCoverage "A2" "leakage_power2__vss"
$tempAcq setAdditionalStateCoverage "A2" "energy__A1__lh__Z__hl"
$tempAcq setAdditionalStateCoverage "A2" "leakage_power1__vss"
$tempAcq setAdditionalStateCoverage "A2" "leakage_power1__vdd"
$tempAcq setAdditionalStateCoverage "A2" "energy1__A1__lh__Z__hl__vdd"
$tempAcq setAdditionalStateCoverage "A2" "leakage_power2__vdd"
$tempAcq setAdditionalStateCoverage "A2" "cap_energy__Z__hl"
$tempAcq setWhen "A2"
$tempAcq setAdditionalWhen "A2" "energy1__A1__lh__Z__hl__vss"
$tempAcq setAdditionalWhen "A2" "leakage_power2__vss"
$tempAcq setAdditionalWhen "A2" "energy__A1__lh__Z__hl"
$tempAcq setAdditionalWhen "A2" "leakage_power1__vss"
$tempAcq setAdditionalWhen "A2" "leakage_power1__vdd"
$tempAcq setAdditionalWhen "A2" "energy1__A1__lh__Z__hl__vdd"
$tempAcq setAdditionalWhen "A2" "leakage_power2__vdd"
$tempAcq setAdditionalWhen "A2" "cap_energy__Z__hl"

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { A1 Z:inout A2 } { initial_delay units ct default_slew pp energy_change_threshold energy_change_abs_threshold }

$tempWT setStimulus                            {   A1   A2   Z     } {
                             "0"            {} {   1    1    Z,1   }
                 "initial_delay"            {} {   0    -    -,-   }
       "initial_delay+0.5*units" { start out } {   1    -    Z,0   }
"(initial_delay+0.5*units)+(pp)"            {} {   -    -    -,-   }
}

$tempWT addMeasurements {} {
  { tin_A1               Tin        { A1 start } NO_USER SYS }
  { cin_A1               Cin        { A1 start } NO_USER SYS }
  { tout_Z               Tout       { Z out } NO_USER SYS }
  { delay_A1_Z           delay      { A1 start Z out } NO_USER SYS }
  { energy__A1__lh__Z__hl energy     { start pp energy_change_threshold energy_change_abs_threshold 0 } NO_USER SYS }
  { energy1__A1__lh__Z__hl__vdd energy1    { start pp energy_change_threshold energy_change_abs_threshold 0 vdd } }
  { leakage_power1__vdd  leakage_power1 { initial_delay+0.5*units+0.95*pp initial_delay+0.5*units+pp vdd } }
  { leakage_power2__vdd  leakage_power2 { initial_delay+0.5*units+0.90*pp initial_delay+0.5*units+0.95*pp vdd } }
  { energy1__A1__lh__Z__hl__vss energy1    { start pp energy_change_threshold energy_change_abs_threshold 0 vss } }
  { leakage_power1__vss  leakage_power1 { initial_delay+0.5*units+0.95*pp initial_delay+0.5*units+pp vss } }
  { leakage_power2__vss  leakage_power2 { initial_delay+0.5*units+0.90*pp initial_delay+0.5*units+0.95*pp vss } }
  { cap_energy__Z__hl    cap_energy { start pp cap_Z Z 0 } }
}

$tempWT bindInterface { A1 Z A2 } { 10e-12 A1[cycle_time] A1[cycle_time] A1[default_slew] cell_power_period power_stabilization_threshold power_stabilization_threshold_absolute }
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

