#!/usr/bin/tclsh

set cornerList "FF"
set voltList "1.1"
set tempList "-40"

foreach volt $voltList {
foreach corner $cornerList {
foreach temp $tempList {

    set con "${corner}_${volt}_${temp}_ALL"
    
    # generate rundir
    exec siliconsmart -x "create -legacy LIB_${con};exit;"
    
    set dir "[exec pwd]"
    cd LIB_${con}
   
    set inFile [open ../templates/run.tcl]
    set outFile [open run.tcl w]
    while {[gets $inFile line] >= 0} {
        regsub -all _LIB_DIR_ $line ${dir}/LIB_${con} line
        regsub -all _CON_ $line $con line
        puts $outFile $line    
    }
    close $inFile
    close $outFile

    set lib_dir "${dir}/templates/CLN65GPLUS_1d8_lk_v1d0p1.l"
    set temp_dir "${dir}/LIB_${con}/temp"
    if {![file exists ./temp]} {
	exec mkdir temp
    }
    set inFile [open ../templates/configure.tcl] 
    set outFile [open ./config/configure.tcl w]
    while {[gets $inFile line]>=0} {
        regsub -all _CON_ $line $con line
	regsub -all _LIB_DIR_ $line ${lib_dir} line 
        regsub -all _TEMP_DIR_ $line ${temp_dir} line
        regsub -all _VDD_ $line $volt line
        regsub -all _TEMP_ $line $temp line
        regsub -all _PROCESS_ $line $corner line
        puts $outFile $line
    }
    close $inFile 
    close $outFile 

    exec rm -rf netlists
    exec ln -snf ../templates/netlists .
    exec ln -snf ../templates/ref.lib .

    exec chmod 755 run.tcl
	  exec chmod 755 config/configure.tcl

    catch {exec siliconsmart run.tcl}

    cd .. 

}
}
}
