
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name xilinx_tb -dir "/home/sabbir/projects/GFAU/design/xilinx_tb/planAhead_run_3" -part xc6slx9tqg144-3
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "/home/sabbir/projects/GFAU/design/xilinx_tb/operators.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/home/sabbir/projects/GFAU/design/xilinx_tb} }
set_property target_constrs_file "operators.ucf" [current_fileset -constrset]
add_files [list {operators.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "/home/sabbir/projects/GFAU/design/xilinx_tb/operators.ncd"
if {[catch {read_twx -name results_1 -file "/home/sabbir/projects/GFAU/design/xilinx_tb/operators.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"/home/sabbir/projects/GFAU/design/xilinx_tb/operators.twx\": $eInfo"
}
