require 'pathname'

mytarget = Pathname.new'"m:/VHDL/Completion Letters/2013A/TMSC Completion Letters - 2013A CT SureCom VHDL'

board_names = 
%q[ 
https://chivcs.tmriusa.com/svn/tmiller/proj/surecom/fpgas/scst2va_fpga/ptst/trunk/src
https://chivcs.tmriusa.com/svn/tmiller/proj/surecom/fpgas/scst2va_fpga/ptst/trunk/sim
https://chivcs.tmriusa.com/svn/tmiller/proj/surecom/fpgas/scst2va_fpga/ptst/docs
]

temp = %q(https://chivcs.tmriusa.com/svn/tmiller/proj/surecom/fpgas/scst2va_fpga/ptst/trunk/src/)


blah= system("svn export --force #{temp}")
