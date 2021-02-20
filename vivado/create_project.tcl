
# define the project settings
set project_name "hamexpo2021"
set device "xc7z045ffg900-2"
set board [lindex [lsearch -all -inline [get_board_parts] *zc706*] end]

# create the project and define board and library location
create_project $project_name project_files -part $device -force
set_property board_part $board [current_project]
set lib_dirs ../library
set_property ip_repo_paths $lib_dirs [current_fileset]
update_ip_catalog

# add constraints
add_files system_constr.xdc

# add some library files to the project
add_files ../library/util_cdc
add_files ../library/common

# create the block level design
source system_bd.tcl
save_bd_design
validate_bd_design

# create the wrapper
make_wrapper -files [get_files project_files/hamexpo2021.srcs/sources_1/bd/system/system.bd] -top
add_files -norecurse project_files/hamexpo2021.gen/sources_1/bd/system/hdl/system_wrapper.v
set_property top system_wrapper [current_fileset]
