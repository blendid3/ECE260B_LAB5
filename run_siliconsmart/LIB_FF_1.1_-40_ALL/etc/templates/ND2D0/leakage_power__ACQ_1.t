##############################################################################
# Template generated by SiliconSmart L-2016.06-SP1-2 (built on Dec 07, 2016 16:59:49) #
# SiliconSmart Path: /acsnfs3/software/SiliconSmartAce-2016.06-SP1-2/linux64/bin/siliconsmart #
# Host Name: ieng6-249.ucsd.edu, User Name: haz023, PID: 5005 #
# Directory: /home/linux/ieng6/ee260bwi20/haz023/lab5/run_siliconsmart/LIB_FF_1.1_-40_ALL #
# Date Fri, 21 Feb 2020 15:13:50 PST #
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
$tempTestColl makeFormalPorts {A1 ZN A2}
$tempTestColl setParameter retention_ports {}
$tempTestColl setParameter synch_controls {}
$tempTestColl setParameter clock_ports {}
$tempTestColl setParameter asynch_ports {}
$tempTestColl setParameter asynch_ports_active_state {}

## 
## Tests

## 
## Test leakage_power
set tempTest [ SBTest "leakage_power" ]
$tempTest setTargets { leakage_power }
$tempTest setAnalysisType tranPlus

## 
## Sweep Specification
$tempTest setTagNumTableDimensions 0 mpw

## 
## Harnesses
$tempTest setAcquire 1

## 
## ACQ_1
set tempAcq [ SBLeakageCurrentAcquisition "ACQ_1" ]
$tempAcq setHarnessName default
$tempAcq setAcquire 1
$tempAcq setState "!A2&ZN&!A1"
$tempAcq setStateCoverage "!A1&!A2"
$tempAcq setWhen "!A1 !A2"
$tempAcq addSweptState {A1 0 A2 0} {!A1&!A2} {!A1 !A2}
$tempAcq addSweptState {A1 0 A2 1} {!A1&A2} {!A1 A2}
$tempAcq addSweptState {A1 1 A2 0} {A1&!A2} {A1 !A2}

## 
## Wavetable
set tempWT [ SBWaveTable ]
$tempWT setInterface { A1 ZN:out A2 } { initial_delay units ct default_slew trailing_delay pp }

$tempWT setStimulus                       {   A1   A2   ZN    } {
                            "0"   { in0 } {   0    0    1     }
   "(0)+initial_delay+(1.0*pp)" { start } {   0    0    1     }
"(0)+initial_delay+(1.0*pp)+pp"   { end } {   0    0    1     }
}

$tempWT addMeasurements {} {
  { leakage_current      leakage_power { (0)+initial_delay+(1.0*pp) (0)+initial_delay+(1.0*pp)+pp {A1 A2} {} } NO_USER SYS }
}

$tempWT bindInterface { A1 ZN A2 } { cell_initial_delay None[cycle_time] None[cycle_time] None[default_slew] cell_trailing_delay cell_power_period }
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
$tempTopOp setElementName cap_ZN
$tempTopOp setOperation insert
$tempTopOp setNodes {ZN ZN[logic_low_name]}
$tempTopOp setParam {load_ZN}
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

