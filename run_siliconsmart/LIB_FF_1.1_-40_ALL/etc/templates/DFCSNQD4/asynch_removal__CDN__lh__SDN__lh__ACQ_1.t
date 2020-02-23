##############################################################################
# Template generated by SiliconSmart L-2016.06-SP1-2 (built on Dec 07, 2016 16:59:49) #
# SiliconSmart Path: /acsnfs3/software/SiliconSmartAce-2016.06-SP1-2/linux64/bin/siliconsmart #
# Host Name: ieng6-249.ucsd.edu, User Name: haz023, PID: 5326 #
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
## Test asynch_removal__CDN__lh__SDN__lh
set tempTest [ SBTest "asynch_removal__CDN__lh__SDN__lh" ]
$tempTest setTargets { asynch_removal__CDN__lh__SDN__lh }
$tempTest setTargetInputs {
  {CDN lh}}

$tempTest setTargetOutputs {
  {Q lh}}

$tempTest setTargetReferences {
  {SDN lh}}

$tempTest setSwitchingInputs {
  {CDN lh}}

$tempTest setSwitchingRefs {
  {SDN lh}}

$tempTest setAnalysisType tranPlus

## 
## Sweep Specification
$tempTest setTagNumTableDimensions 0 mpw

## 
## Harnesses
$tempTest setAcquire 1
$tempTest setStateCoverage "!SDN"

## 
## ACQ_1
set tempAcq [ SBConstraintAcquisition "ACQ_1" ]
$tempAcq setHarnessName default
$tempAcq setAcquire 1
$tempAcq setState "!CP&!D"
$tempAcq setStateCoverage "1"
$tempAcq setWhen "1"

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { Q:out SDN CP CDN D } { initial_delay units ct default_slew stable driver_delay_CDN driver_delay_SDN asynch_removal min_asynch_removal max_asynch_removal opt_tolerance glitch_threshold_Q }

$tempWT setStimulus                                             {   SDN  CP   CDN  D    Q     } {
                                                "0"          {} {   1    0    1    0    0     }
                                    "initial_delay"          {} {   0    -    -    -    1     }
                          "initial_delay+0.5*units"          {} {   -    -    0    -    0     }
                            "initial_delay+1*units"     { in1 } {   1    -    -    -    -     }
           "(initial_delay+1*units)+asynch_removal" { in2 out } {   -    -    1    -    1     }
"((initial_delay+1*units)+asynch_removal)+(stable)"          {} {   -    -    -    -    -     }
}

$tempWT addMeasurements {} {
  { tin_SDN              Tin        { SDN in1 } NO_USER SYS }
  { tin_CDN              Tin        { CDN in2 } NO_USER SYS }
  { asynch_removal_CDN_SDN asynch_removal { CDN in2 SDN in1 } NO_USER SYS }
  { tout_Q               Tout       { Q in2 } NO_USER SYS }
  { threshold_cross_Q    glitch_delay { CDN in2 Q in2 glitch_threshold_Q } NO_USER SYS }
}

$tempWT addOptimization    asynch_removal    min_asynch_removal    max_asynch_removal    threshold_cross_Q    { asynch_removal_CDN_SDN tin_CDN tin_SDN } { tout_Q threshold_cross_Q } {  } {  } fail None opt_tolerance (driver_delay_SDN-driver_delay_CDN)+(1.99*opt_tolerance)+(0.15*(slew_CDN+slew_SDN)) driver_delay_SDN-driver_delay_CDN min_asynch_removal "1"
$tempWT bindInterface { Q SDN CP CDN D } { cell_initial_delay CDN[cycle_time] CDN[cycle_time] CDN[default_slew] max(CDN[stable_time],Q[stable_time]) (slew_CDN*0.5)/(0.7-0.3) (slew_SDN*0.5)/(0.7-0.3) CDN[max_asynch_removal] CDN[min_asynch_removal] CDN[max_asynch_removal] CDN[constraint_resolution] Q[glitch_low_threshold] }
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

