# Baseline in this section is what is run as shown in the log from previous runs
# m:/VHDL/fpga_designs/mfitzgerald/my_working_copies/ \
# hsbp/hsbp_cfk_bpj_b_fpga_2012-12-09_132451_Rev031/fpga_build_hsbp_cfk_bpj_b.log
#
################################################################################
# VARAIBLES CONTROL EXECUTION OF THIS SCRIPT
################################################################################
run_synthesis='y'
run_ngdbuild='y'
run_map='y'
run_par='y'
run_trace='y'
run_bitgen='y'

################################################################################
# LOAD MODULES
################################################################################
echo 'loading modules'
module load synplicity/200906
module load xilinx_ise/11.3

################################################################################
# SYNTHESIS
################################################################################
if [[ $run_synthesis =~ [Yy] ]]
then

  echo 'got here'
  #exit
  # change to the synthesis directory
  cd syn
  #
  echo "Running Synthesis"
  #synplify_pro -batch -impl $synth_result_dir $syn_prj_local_filename";
   synplify_pro -batch -impl XC5VLX330T        Perl_fpga_build_local.prj
  echo "Synthesis complete"

  # cd back to project root dir
  cd ..
  #
  # copy synthesis output (.edf) to a folder under ./par
  # $files_to_copy = $project_root_dir.$fpga_dir.$synthesis_dir."/".$synth_result_dir."/".$edif_filename;
  # sys_cmd ("cp -f $files_to_copy $par_dir/".$edn_dir);
  cp -f -v ./syn/XC5VLX330T/hsbp_cfk_bpj_b_fpga.edf ./par/edn.dir
  #
else

    echo "Skipping synthesis"
fi

################################################################################
# NGDBUILD
################################################################################
if [[ $run_ngdbuild =~ [Yy] ]]
then

  # check if the pwd is par, change to it if it's not par
  result=${PWD##*/}
  #
  if [[ $result = 'par' ]]
  then
      echo "folder is par"
  else
      cd par
      echo "folder is not par changing to par"
  fi

  echo "Running ngdbuild"
  #
  # ngdbuild -uc $ucf_filename       -sd $edn_dir -dd $ngo_dir $fpga;
  ngdbuild   -uc Perl_fpga_build.ucf -sd edn.dir  -dd ngo.dir  hsbp_cfk_bpj_b_fpga
else
  echo "Skipping ngdbuild"
fi

################################################################################
# MAP
################################################################################
if [[ $run_map =~ [Yy] ]]
then

  # check if the pwd is par, change to it if it's not par
  result=${PWD##*/}
  #
  if [[ $result = 'par' ]]
  then
      echo "folder is par"
  else
      cd par
      echo "folder is not par changing to par"
  fi

  echo "Running map"
  map -detail -w -ol high -timing -register_duplication on -mt on -pr b hsbp_cfk_bpj_b_fpga

else
  echo "Skipping map"
fi

################################################################################
# PAR
################################################################################
if [[ $run_par =~ [Yy] ]]
then
  # check if the pwd is par, change to it if it's not par
  result=${PWD##*/}
  #
  if [[ $result = 'par' ]]
  then
      echo "folder is par"
  else
      cd par
      echo "folder is not par changing to par"
  fi

  echo 'running par'
  par -w -ol high -xe n hsbp_cfk_bpj_b_fpga.ncd hsbp_cfk_bpj_b_fpga
else

  echo 'skipping par'
fi

################################################################################
# TRACE
################################################################################
if [[ $run_trace =~ [Yy] ]]
then
  # check if the pwd is par, change to it if it's not par
  result=${PWD##*/}
  #
  if [[ $result = 'par' ]]
  then
      echo "folder is par"
  else
      cd par
      echo "folder is not par changing to par"
  fi

  echo 'Running trace'
  # trce -e 100 -u 100 -xml $fpga.twx -o $fpga.twr $fpga.ncd $fpga.pcf;
  trce -e 100 -u 100 -xml hsbp_cfk_bpj_b_fpga.twx -o hsbp_cfk_bpj_b_fpga.twx.twr hsbp_cfk_bpj_b_fpga.twx.ncd hsbp_cfk_bpj_b_fpga.twx.pcf
else
  echo 'Skippingt trace'

fi

################################################################################
# BITGEN
################################################################################
if [[ $run_bitgen =~ [Yy] ]]
then

  # check if the pwd is par, change to it if it's not par
  result=${PWD##*/}
  #
  if [[ $result = 'par' ]]
  then
      echo "folder is par"
  else
      cd par
      echo "folder is not par changing to par"
  fi

  echo 'running bitgen'

# bitgen -w -f $project_root_dir $common_files_dir$bitgen_cfg_file $option{'additional_bit_options'};
#   sys_cmd ("cp -f $fpga.ncd $fpga"."_Rev$revision_number.ncd");
#   $bitgen_outfile = $bitgen_outfile.$revision_number.".bit";
#   $bitgen_command = $bitgen_command." ".$fpga."_Rev$revision_number.ncd ".$bitgen_outfile;
#
  bitgen   -w -f ./bitgen.ut  hsbp_cfk_bpj_b_fpga.ncd hsbp_cfk_bpj.bit
else
  echo 'skipping bitgen'
fi

#may be useful in the future
# $fpga="hsbp_cfk_bpj_b_fpga"
# $synth_result_dir='XC5VLX330T'
# $synthesis_dir          = "syn";
# $edif_filename = $fpga.".edf";

# ###################################################
# # use this to control project location
# my $project_root_dir       = "$proj_env/fpga_designs/";
# my $config_file            = "Perl_fpga_build.cfg";
# my $common_files_dir       = "common_build_files/";
# my $rev_number_dir         = "$proj_drive/RESEARCH_ENG/HARDWARE/FPGA_Rev_numbers/";
# my $build_history_dir      = "$proj_drive/RESEARCH_ENG/HARDWARE/FPGA_Build_History/";
# my $archive_dir            = "archive_dir/";
# my $build_source_dir       = "build_source_files";
# my $synthesis_dir          = "syn";
# my $par_dir                = "par";            # Don't use "/" here
# my $edn_dir                = "edn.dir";
# my $ngo_dir                = "ngo.dir";
# my $syn_prj_filename       = "Perl_fpga_build.prj";
# my $syn_prj_local_filename = "Perl_fpga_build_local.prj";
# my $syn_sdc_filename       = "Perl_fpga_build.sdc";
# my $syn_sdc_local_filename = "Perl_fpga_build_local.sdc";
# my $ucf_filename           = "Perl_fpga_build.ucf";
# my $bitgen_cfg_file        = "bitgen.ut";
# my $promgen_cfg_file       = "promgen.cfg";
# my $fpga_part_type;
# my $fpga_part_speed;
# my $fpga_device;
# my $fpga_part_package;
# my $ruby_family_type;      # Virtex2P or Virtex4 or Virtex5
# my $coregen_dir;
# my $license_server1        = "4444\@FPGA-LINUX-01";
# my $server_name1           = "FPGA-LINUX-01/";
# my $license_server2        = "6666\@FPGA-LINUX-02";
# my $server_name2           = "FPGA-LINUX-02/";
# my $email_server           = '172.16.2.10';
# my $synth_license_retry_seconds = 60;
# ###################################################

# #########################################################################
# #
# # Commands
# #
# # my $synthesis_command = "synplify_pro -batch -impl $synth_result_dir $syn_prj_local_filename";
# my $synthesis_command = "synplify_pro -batch -impl XC5VLX330T Perl_fpga_build_local.prj";

# my $ruby_command      = "ruby $proj_env/fpga_modules/$coregen_dir/bin/makeCores.rb --core_dir $proj_env/fpga_modules/$coregen_dir/xco --edf_file ./$edif_filename  --synthesizer Synplicity --fpga_family $ruby_family_type --fpga_speed $fpga_part_speed --fpga_package $fpga_part_package --fpga_device $fpga_device --platform $platform";
# my $ngdbuild_command  = "ngdbuild -uc $ucf_filename -sd $edn_dir -dd $ngo_dir $fpga";
# my $chipscope_command = "inserter".$prog_extension;
# my $map_command       = "map $option{'additional_map_options'} -pr b $fpga";
# my $par_command       = "par $option{'additional_par_options'} $fpga.ncd $fpga";
# my $twr_command       = "trce -e 100 -u 100 -xml $fpga.twx -o $fpga.twr $fpga.ncd $fpga.pcf";
# my $bitgen_command    = "bitgen -w -f $project_root_dir$common_files_dir$bitgen_cfg_file $option{'additional_bit_options'}";
# my $promgen_command   = "promgen -w -f $project_root_dir$common_files_dir$promgen_cfg_file -o";
# my $ehe_command       = "ehe -ufpga"; # other parameters appended later

# my $exit_value; # non-zero when the system is unable to execute a program (does not contain exit value of the DOS command after running)

# # #########################################################################
# #
# # Synthesis
# #
# #Change dir to synthesis dir
# cd ./syn

# echo Current Dir is $(pwd)

# synplify_pro -batch -impl synth_results Perl_fpga_build_local.prj

# ngdbuild -uc $ucf_filename -sd $edn_dir -dd $ngo_dir $fpga

# synth_result_dir=XC5VLX330T
# syn_prj_local_filename=Perl_fpga_build_local.prj

# ucf_filename=Perl_fpga_build.ucf
# edn_dir=edn.dir

# synplify_pro -batch -impl $synth_result_dir $syn_prj_local_filename;

# # my $synthesis_command = "synplify_pro -batch -impl XC5VLX330T Perl_fpga_build_local.prj";

# ngdbuild -uc $ucf_filename -sd $edn_dir -dd $ngo_dir $fpga;

# map $option{'additional_map_options'} -pr b $fpga;

# par $option{'additional_par_options'} $fpga.ncd $fpga;

# trce -e 100 -u 100 -xml $fpga.twx -o $fpga.twr $fpga.ncd $fpga.pcf;

# bitgen -w -f $project_root_dir$common_files_dir$bitgen_cfg_file $option{'additional_bit_options'};

# promgen -w -f $project_root_dir$common_files_dir$promgen_cfg_file -o;

