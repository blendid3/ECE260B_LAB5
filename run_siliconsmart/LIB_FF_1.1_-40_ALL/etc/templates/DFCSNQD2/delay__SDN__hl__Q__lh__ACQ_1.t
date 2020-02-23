##############################################################################
# Template generated by SiliconSmart L-2016.06-SP1-2 (built on Dec 07, 2016 16:59:49) #
# SiliconSmart Path: /acsnfs3/software/SiliconSmartAce-2016.06-SP1-2/linux64/bin/siliconsmart #
# Host Name: ieng6-249.ucsd.edu, User Name: haz023, PID: 5349 #
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
$tempTestColl makeFormalPorts {Q SDN CDN CP D}
$tempTestColl setParameter retention_ports {}
$tempTestColl setParameter synch_controls {SDN CDN}
$tempTestColl setParameter clock_ports {CP}
$tempTestColl setParameter asynch_ports {SDN CDN}
$tempTestColl setParameter asynch_ports_active_state {CDN 10 SDN 10}

## 
## Tests

## 
## Test delay__SDN__hl__Q__lh
set tempTest [ SBTest "delay__SDN__hl__Q__lh" ]
$tempTest setTargets { delay__SDN__hl__Q__lh Cin__SDN__hl Tout__Q__lh cap_energy__Q__lh energy1__SDN__hl__Q__lh__vdd energy1__SDN__hl__Q__lh__vss energy__SDN__hl__Q__lh leakage_power1__vdd leakage_power1__vss leakage_power2__vdd leakage_power2__vss }
$tempTest setTargetInputs {
  {SDN hl}}

$tempTest setTargetOutputs {
  {Q lh}}

$tempTest setSwitchingInputs {
  {SDN hl}}

$tempTest setAnalysisType tranPlus
$tempTest setAllStatesCovered 0

## 
## Sweep Specification
$tempTest setTagNumTableDimensions 0 mpw

## 
## Harnesses
$tempTest setAcquire 1
$tempTest setStateCoverage "CDN"

## 
## ACQ_1
set tempAcq [ SBDelayAcquisition "ACQ_1" ]
$tempAcq setHarnessName default
$tempAcq setAcquire 1
$tempAcq setState "CDN&!CP&!D"
$tempAcq setStateCoverage "CDN"
$tempAcq setAdditionalStateCoverage "CDN" "energy__SDN__hl__Q__lh"
$tempAcq setAdditionalStateCoverage "CDN" "leakage_power2__vss"
$tempAcq setAdditionalStateCoverage "CDN" "energy1__SDN__hl__Q__lh__vss"
$tempAcq setAdditionalStateCoverage "CDN" "leakage_power2__vdd"
$tempAcq setAdditionalStateCoverage "CDN" "leakage_power1__vss"
$tempAcq setAdditionalStateCoverage "CDN" "leakage_power1__vdd"
$tempAcq setAdditionalStateCoverage "CDN" "cap_energy__Q__lh"
$tempAcq setAdditionalStateCoverage "CDN" "energy1__SDN__hl__Q__lh__vdd"
$tempAcq setWhen "1"
$tempAcq setAdditionalWhen "1" "energy__SDN__hl__Q__lh"
$tempAcq setAdditionalWhen "1" "leakage_power2__vss"
$tempAcq setAdditionalWhen "1" "energy1__SDN__hl__Q__lh__vss"
$tempAcq setAdditionalWhen "1" "leakage_power2__vdd"
$tempAcq setAdditionalWhen "1" "leakage_power1__vss"
$tempAcq setAdditionalWhen "1" "leakage_power1__vdd"
$tempAcq setAdditionalWhen "1" "cap_energy__Q__lh"
$tempAcq setAdditionalWhen "1" "energy1__SDN__hl__Q__lh__vdd"

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { Q:inout SDN CP CDN D } { initial_delay units ct default_slew pp energy_change_threshold energy_change_abs_threshold }

$tempWT setStimulus                          {   SDN  CP   CDN  D    Q     } {
                           "0"            {} {   0    0    0    0    Z,0   }
               "initial_delay"            {} {   1    -    -    -    -,-   }
     "initial_delay+0.5*units"            {} {   -    -    1    -    -,-   }
       "initial_delay+1*units" { start out } {   0    -    -    -    Z,1   }
"(initial_delay+1*units)+(pp)"            {} {   -    -    -    -    -,-   }
}

$tempWT addMeasurements {} {
  { tin_SDN              Tin        { SDN start } NO_USER SYS }
  { cin_SDN              Cin        { SDN start } NO_USER SYS }
  { tout_Q               Tout       { Q out } NO_USER SYS }
  { delay_SDN_Q          delay      { SDN start Q out } NO_USER SYS }
  { energy__SDN__hl__Q__lh energy     { start pp energy_change_threshold energy_change_abs_threshold 0 } NO_USER SYS }
  { energy1__SDN__hl__Q__lh__vdd energy1    { start pp energy_change_threshold energy_change_abs_threshold 0 vdd } }
  { leakage_power1__vdd  leakage_power1 { initial_delay+1*units+0.95*pp initial_delay+1*units+pp vdd } }
  { leakage_power2__vdd  leakage_power2 { initial_delay+1*units+0.90*pp initial_delay+1*units+0.95*pp vdd } }
  { energy1__SDN__hl__Q__lh__vss energy1    { start pp energy_change_threshold energy_change_abs_threshold 0 vss } }
  { leakage_power1__vss  leakage_power1 { initial_delay+1*units+0.95*pp initial_delay+1*units+pp vss } }
  { leakage_power2__vss  leakage_power2 { initial_delay+1*units+0.90*pp initial_delay+1*units+0.95*pp vss } }
  { cap_energy__Q__lh    cap_energy { start pp cap_Q Q 0 } }
}

$tempWT bindInterface { Q SDN CP CDN D } { 10e-12 SDN[cycle_time] SDN[cycle_time] SDN[default_slew] cell_power_period power_stabilization_threshold power_stabilization_threshold_absolute }
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
$tempTopOp setElementName cap_ground_Q
$tempTopOp setOperation insert
$tempTopOp setNodes {ground_Q 0}
$tempTopOp setParam {0}
$tempHarness addTopologyOperation $tempTopOp
release_obj $tempTopOp
set tempTopOp [ SBTopologyOperation ]
$tempTopOp setElement capacitor
$tempTopOp setElementName cap_Q
$tempTopOp setOperation insert
$tempTopOp setNodes {Q ground_Q}
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

