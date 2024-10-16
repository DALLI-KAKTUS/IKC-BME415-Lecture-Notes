
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name week2_tutorial -dir "/mnt/hgfs/shared/week2_tutorial/planAhead_run_2" -part xc3s250ecp132-5
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "tutorial1.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {tutorial1.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top tutorial1 $srcset
add_files [list {tutorial1.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s250ecp132-5
