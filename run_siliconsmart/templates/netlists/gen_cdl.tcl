#! /usr/bin/tclsh

set inFile [lindex $argv 0]
set inFp [open $inFile]
while {[gets $inFp line]>=0} {
    if {[regexp {\.SUBCKT.*} $line]} {
        set cell_name [lindex $line 1]
        set outFp [open $cell_name\.cdl w]
        puts $outFp $line
        while {[gets $inFp line]>=0} {
            puts $outFp $line
            if {[regexp {.*GLOBAL.*} $line]} {
                break
            }
        }
        close $outFp
    }
}
close $inFp
