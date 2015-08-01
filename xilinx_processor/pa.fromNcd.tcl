
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name processor -dir "/media/BELGELER/Workspaces/Xilinx/processor/planAhead_run_1" -part xc6slx45csg324-3
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "/media/BELGELER/Workspaces/Xilinx/processor/Atlys_Spartan6.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/media/BELGELER/Workspaces/Xilinx/processor} {ipcore_dir} }
add_files "ipcore_dir/ROM_4K.ncf" "ipcore_dir/RAM_4K.ncf" -fileset [get_property constrset [current_run]]
set_param project.paUcfFile  "pins.ucf"
add_files "pins.ucf" -fileset [get_property constrset [current_run]]
open_netlist_design
read_xdl -file "/media/BELGELER/Workspaces/Xilinx/processor/Atlys_Spartan6.ncd"
if {[catch {read_twx -name results_1 -file "/media/BELGELER/Workspaces/Xilinx/processor/Atlys_Spartan6.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"/media/BELGELER/Workspaces/Xilinx/processor/Atlys_Spartan6.twx\": $eInfo"
}
