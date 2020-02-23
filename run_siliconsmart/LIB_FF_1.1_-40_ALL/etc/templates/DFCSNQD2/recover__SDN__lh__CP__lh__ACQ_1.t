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
## Test recover__SDN__lh__CP__lh
set tempTest [ SBTest "recover__SDN__lh__CP__lh" ]
$tempTest setTargets { recover__SDN__lh__CP__lh }
$tempTest setTargetInputs {
  {SDN lh}}

$tempTest setTargetOutputs {
  {Q hl}}

$tempTest setTargetReferences {
  {CP lh}}

$tempTest setSwitchingInputs {
  {SDN lh}}

$tempTest setSwitchingRefs {
  {CP lh}}

$tempTest setAnalysisType tranPlus

## 
## Sweep Specification
$tempTest setTagNumTableDimensions 0 mpw

## 
## Harnesses
$tempTest setAcquire 1
$tempTest setStateCoverage "CDN&!CP&!D"

## 
## ACQ_1
set tempAcq [ SBConstraintAcquisition "ACQ_1" ]
$tempAcq setHarnessName default
$tempAcq setAcquire 1
$tempAcq setState "CDN&!D"
$tempAcq setStateCoverage "CDN&!D"
$tempAcq setWhen "1"

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { Q:out SDN CP CDN D } { initial_delay units ct default_slew stable driver_delay_SDN driver_delay_CP recovery min_recovery max_recovery opt_tolerance }

$tempWT setStimulus                                       {   SDN  CP   CDN  D    Q     } {
                                          "0"          {} {   1    1    1    0    0     }
                              "initial_delay"          {} {   0    -    -    -    1     }
                    "initial_delay+0.5*units"          {} {   -    0    -    -    -     }
                      "initial_delay+1*units"     { in1 } {   1    -    -    -    -     }
           "(initial_delay+1*units)+recovery" { in2 out } {   -    1    -    -    0     }
"((initial_delay+1*units)+recovery)+(stable)"          {} {   -    -    -    -    -     }
}

$tempWT addMeasurements {} {
  { tin_SDN              Tin        { SDN in1 } NO_USER SYS }
  { tin_CP               Tin        { CP in2 } NO_USER SYS }
  { recovery_SDN_CP      recover    { SDN in1 CP in2 } NO_USER SYS }
  { tout_Q               Tout       { Q in2 } NO_USER SYS }
  { delay_CP_Q           delay      { CP in2 Q in2 } NO_USER SYS }
  { fallback_Q           fallback   { Q in2 0 } NO_USER SYS }
}

$tempWT addOptimization    recovery    min_recovery    max_recovery    delay_CP_Q    { recovery_SDN_CP tin_SDN tin_CP tout_Q delay_CP_Q } { fallback_Q } {  } {  } pass None opt_tolerance (driver_delay_SDN-driver_delay_CP)+(1.99*opt_tolerance)+(0.15*(slew_SDN+slew_CP)) driver_delay_SDN-driver_delay_CP min_recovery "1"
$tempWT bindInterface { Q SDN CP CDN D } { cell_initial_delay SDN[cycle_time] SDN[cycle_time] SDN[default_slew] max(SDN[stable_time],Q[stable_time]) (slew_SDN*0.5)/(0.7-0.3) (slew_CP*0.5)/(0.7-0.3) SDN[max_recovery] SDN[min_recovery] SDN[max_recovery] SDN[constraint_resolution] }
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

