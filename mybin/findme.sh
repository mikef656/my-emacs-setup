#!/usr/bin/env bash
 find . -type f \
   \( -iname "*.el" \
   -o -iname "*.vhd"  \
   -o -iname "*.v"  \
   -o -iname "*.sv"  \
   -o -iname "*.svp"  \
   -o -iname "*.do" \
   -o -iname "*.tcl" \
   -o -iname "*.rb" \
   -o -iname "*.rpt" \
   -o -iname "*.log" \
   -o -iname "*.bat" \
   -o -iname "*.sh" \
   -o -iname "*.csh" \
   -o -iname "*.runsim" \
   -o -iname "transcript" \
   -o -iname "*config*" \
   -o -iname "*.xdc"  \) \
   -not -path "*/.Xil/*" \
   -not -path "*/.git/*" \
   -not -path "*/ise/*" \
   -not -path "*/questa/*" \
   -not -path "*/modelsim/*" \
   -not -path "*/vcs/*" \
   -not -path "*/ip_project/*" \
   -not -path "*/m3b8_fw/*" \
   -not -path "*/m2a8_fw/*" \
   -not -path "*/s4b1_bb_fw/*" \
   -not -path "*/s5c2_at_dev_fw/*" \
   -not -path "*/.srcs/*" \
   -not -path "*/managed_ip_project/*" \
   | grep -v -P dir-locals |  tee  .project_files.txt
