source settings.tcl
open_project -reset prj_2dfft_impulse_test
set_top top_fft2d
add_files src/top_2d_fft_test.cpp -cflags "-I../../include/hw/vitis_2dfft/float/"
add_files -tb src/main_2d_fft_test.cpp -cflags "-I../../include/hw/vitis_2dfft/float/"
add_files -tb src/top_2d_fft_test.cpp -cflags "-I../../include/hw/vitis_2dfft/float/"
open_solution -reset "solution1"
#set_part {xcu200-fsgd2104-2-e}
 set_part $XPART
create_clock -period 3.33 -name default
config_compile -no_signed_zeros=0 -unsafe_math_optimizations=0
config_sdx -target none
config_export -format ip_catalog -rtl verilog -vivado_optimization_level 2 -vivado_phys_opt place -vivado_report_level 0
config_rtl -encoding onehot -kernel_profile=0 -module_auto_prefix=0 -mult_keep_attribute=0 -reset control -reset_async=0 -reset_level high -verbose=0
set_clock_uncertainty 12.5%
if {$CSIM == 1} {
 csim_design -clean
}
if {$CSYNTH == 1} {
 csynth_design
}
#cosim_design -wave_debug -trace_level port -tool xsim
if {$COSIM == 1} {
 cosim_design 
} 
if {$VIVADO_SYN == 1} {
 export_design -flow syn -rtl verilog
}
if {$VIVADO_IMPL == 1} {
 export_design -flow impl -rtl verilog
}
if {$QOR_CHECK == 1} {
   puts "QoR check not implemented yet"
}
 
exit
