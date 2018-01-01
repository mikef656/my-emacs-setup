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
   -o -iname "transcript" \
   -o -iname "*config*" \
   -o -iname "*.xdc"  \) \
   -not -path "*/.Xil/*" \
   -not -path "*/.srcs/*" \
   -not -path "*/managed_ip_project/*" \
   | grep -v -P dir-locals |  tee  .project_files.txt
