# define output directory area
set OUTPUT_DIR ./output             

file mkdir $OUTPUT_DIR

# set part
set PART_NM xc7vx485tffg1157-2

# create a project
create_project -in_memory myproj "."

# read in design sources
read_vhdl -library atclvhd "./../../atcl/hdl/atclvhd_package.vhd"
read_vhdl     "./../../atcl/hdl/atclvhd_dc_true_dpram.vhd"
read_vhdl     "./../../atcl/hdl/atclvhd_sine_norst.vhd"
read_vhdl     "./../../atcl/hdl/atclvhd_sine_cosine_norst.vhd"
read_verilog  "./../../atcl/hdl/atcl_binary_to_gray.v"
read_verilog  "./../../atcl/hdl/atcl_gray_to_binary.v"
read_vhdl     "./../../atcl/hdl/atclvhd_normalizer.vhd"
read_verilog  "./../../atcl/hdl/atcl_dc_encoder_decoder.v"
read_vhdl     "./../../atcl/hdl/atclvhd_sc_dpram.vhd"
read_verilog  "./../../atcl/hdl/atcl_reset_sync_activehigh.v"
read_vhdl     "./../../atcl/hdl/atclvhd_fftcore_f.vhd"
read_verilog  "./../../atcl/hdl/atcl_dc_dpram.v"
read_verilog  "./../../atcl/hdl/atcl_dc_fifo.v"
read_vhdl     "./../../atcl/hdl/atclvhd_cplx_mult.vhd"
read_verilog  "./../../atcl/hdl/atcl_dc_true_dpram.v"
#
read_vhdl     "./../hdl/psd/psd_sc_dpram.vhd"
read_vhdl     "./../hdl/psd/psd_sqrt.vhd"
read_verilog  "./../hdl/psd/psd_aggregate_ctrl.v"
read_verilog  "./../hdl/psd/psd_aggregate_bins.v"
read_verilog  "./../hdl/psd/psd_sqrt_stream.v"
read_vhdl     "./../hdl/psd/psd_vector_accumulate.vhd"
read_vhdl     "./../hdl/psd/psd_magnitude.vhd"
read_verilog  "./../hdl/psd/psd_bank_round.v"
read_verilog  "./../hdl/psd/psd_gate.v"
read_verilog  "./../hdl/psd/psd_iq_gen.v"
read_verilog  "./../hdl/psd/psd_time_window.v"
read_verilog  "./../hdl/psd/psd_aggregate.v"
read_verilog  "./../hdl/psd/spectrum_scanner.v"
read_verilog  "./../hdl/psd/psd_max_hold.v"
read_vhdl     "./../hdl/psd/log.vhd"
read_vhdl     "./../hdl/psd/psd_periodic_average.vhd"
read_vhdl     "./../hdl/psd/psd_cplx_mult.vhd"
read_verilog  "./../hdl/psd/psd_throttle.v"
read_verilog  "./../hdl/psd/psd_tone_gen.v"
read_verilog  "./../hdl/psd/psd_output_mux.v"
read_verilog  "./../hdl/psd/psd_discard_fsm.v"
read_verilog  "./../hdl/psd/fft_shift.v"
read_verilog  "./../hdl/psd/psd_controller.v"
read_verilog  "./../hdl/psd/psd_fftround_sync.v"
read_verilog  "./../hdl/psd/psd_generate.v"
#read_verilog  "./../hdl/psd/psd_engine.v"
# top level
#read_vhdl     "./psd_engine_wrapper.vhd"
read_vhdl     "./../hdl/psd/psd_fftcore_f4.vhd"

# read in constraints
read_xdc ./constraints.xdc

# run synthesis
# synth_design -top psd_engine_wrapper -part $PART_NM
synth_design -top psd_fftcore_f4 -part $PART_NM
#
# write checkpoint design   
write_checkpoint -force $outputDir/post_synth
#
# report timing 
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
#
# report utilization
report_utilization -file $outputDir/post_synth_util.rpt

#report_power -file $outputDir/post_synth_power.rpt
#report_clock_interaction -delay_type min_max -file $outputDir/post_synth_clock_interaction.rpt
#report_high_fanout_nets -fanout_greater_than 200 -max_nets 50 -file $outputDir/post_synth_high_fanout_nets.rpt

# STEP#3: run placement and logic optimzation, report utilization and timing estimates, write checkpoint design
#
#opt_design
#place_design
#phys_opt_design
#write_checkpoint -force $outputDir/post_place
#report_timing_summary -file $outputDir/post_place_timing_summary.rpt
#
# STEP#4: run router, report actual utilization and timing, write checkpoint design, run drc, write verilog and xdc out
#
#route_design
#write_checkpoint -force $outputDir/post_route
#report_timing_summary -file $outputDir/post_route_timing_summary.rpt
#report_timing -max_paths 100 -path_type summary -slack_lesser_than 0 -file $outputDir/post_route_setup_timing_violations.rpt
#report_clock_utilization -file $outputDir/clock_util.rpt
#report_utilization -file $outputDir/post_route_util.rpt
#report_power -file $outputDir/post_route_power.rpt
#report_drc -file $outputDir/post_imp_drc.rpt
#write_verilog -force $outputDir/bft_impl_netlist.v
#write_xdc -no_fixed_only -force $outputDir/bft_impl.xdc
#
# STEP#5: generate a bitstream
# 
#write_bitstream -force $outputDir/bft.bit

