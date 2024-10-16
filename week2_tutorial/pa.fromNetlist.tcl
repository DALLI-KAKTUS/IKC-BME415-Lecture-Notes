
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name week2_tutorial -dir "/mnt/hgfs/shared/week2_tutorial/planAhead_run_3" -part xc3s250ecp132-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/mnt/hgfs/shared/week2_tutorial/tutorial1.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/mnt/hgfs/shared/week2_tutorial} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "tutorial1.ucf" [current_fileset -constrset]
add_files [list {tutorial1.ucf}] -fileset [get_property constrset [current_run]]
link_design
