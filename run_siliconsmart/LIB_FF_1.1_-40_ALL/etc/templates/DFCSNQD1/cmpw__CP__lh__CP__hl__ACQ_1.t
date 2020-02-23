##############################################################################
# Template generated by SiliconSmart L-2016.06-SP1-2 (built on Dec 07, 2016 16:59:49) #
# SiliconSmart Path: /acsnfs3/software/SiliconSmartAce-2016.06-SP1-2/linux64/bin/siliconsmart #
# Host Name: ieng6-249.ucsd.edu, User Name: haz023, PID: 5144 #
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
## Test cmpw__CP__lh__CP__hl
set tempTest [ SBTest "cmpw__CP__lh__CP__hl" ]
$tempTest setTargets { cmpw__CP__lh__CP__hl }
$tempTest setTargetInputs {
  {CP lh}}

$tempTest setTargetOutputs {
  {Q lh}}

$tempTest setTargetReferences {
  {CP hl}}

$tempTest setSwitchingInputs {
  {CP lh}}

$tempTest setSwitchingRefs {
  {CP hl}}

$tempTest setAnalysisType tranPlus

## 
## Sweep Specification
$tempTest setTagNumTableDimensions 0 mpw

## 
## Harnesses
$tempTest setAcquire 1
$tempTest setStateCoverage "CDN&SDN"

## 
## ACQ_1
set tempAcq [ SBMPWAcquisition "ACQ_1" ]
$tempAcq setHarnessName default
$tempAcq setAcquire 1
$tempAcq setState "CDN&D&SDN"
$tempAcq setStateCoverage "CDN&SDN"
$tempAcq setWhen "1"

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { Q:out SDN CP CDN D } { initial_delay units ct default_slew stable cmpw min_cmpw max_cmpw opt_tolerance }

$tempWT setStimulus                                             {   SDN  CP   CDN  D    Q     } {
                                                "0"          {} {   1    1    0    1    0     }
                                    "initial_delay"          {} {   -    0    -    -    -     }
                          "initial_delay+0.5*units"          {} {   -    -    1    -    -     }
                            "initial_delay+1*units" { in1 out } {   -    1    -    -    1     }
           "(initial_delay+1*units)+cmpw+slew_CP*3"     { in2 } {   -    0    -    -    -     }
"((initial_delay+1*units)+cmpw+slew_CP*3)+(stable)"          {} {   -    -    -    -    -     }
}

$tempWT addMeasurements {} {
  { tin_CP               Tin        { CP in1 } NO_USER SYS }
  { cmpw_CP              cmpw       { CP in1 CP in2 } NO_USER SYS }
  { tout_Q               Tout       { Q in1 } NO_USER SYS }
  { delay_CP_Q           delay      { CP in1 Q in1 } NO_USER SYS }
  { fallback_Q           fallback   { Q in1 0 } NO_USER SYS }
}

$tempWT addOptimization    cmpw    min_cmpw    max_cmpw    delay_CP_Q    { cmpw_CP tin_CP tin_CP tout_Q delay_CP_Q } { fallback_Q } {  } {  } expand None opt_tolerance None None max_cmpw "1"
$tempWT bindInterface { Q SDN CP CDN D } { cell_initial_delay CP[cycle_time] CP[cycle_time] CP[default_slew] max(CP[stable_time],Q[stable_time]) CP[max_cmpw] CP[min_cmpw] CP[max_cmpw] CP[constraint_resolution] }
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

