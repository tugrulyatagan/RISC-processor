
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name processor -dir "E:/Workspaces/Xilinx/processor/planAhead_run_1" -part xc6slx45csg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "E:/Workspaces/Xilinx/processor/Atlys_Spartan6.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {E:/Workspaces/Xilinx/processor} {ipcore_dir} }
add_files "ipcore_dir/RAM_4K.ncf" "ipcore_dir/ROM_4K.ncf" -fileset [get_property constrset [current_run]]
set_param project.paUcfFile  "pins.ucf"
add_files "pins.ucf" -fileset [get_property constrset [current_run]]
open_netlist_design
