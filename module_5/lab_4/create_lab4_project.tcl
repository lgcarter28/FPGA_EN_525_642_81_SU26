set script_dir [file normalize [file dirname [info script]]]
set repo_root [file normalize [file join $script_dir .. ..]]
set lab_src_dir [file normalize [file join $script_dir src]]
set project_dir [file normalize [file join $script_dir lab4_vivado_project]]
set project_name lab4_vivado_project

set shared_source_files [list \
    [file join $repo_root utils rtl src pulseGenerator.vhd] \
    [file join $repo_root utils rtl src seg7_anode_decode.vhd] \
    [file join $repo_root utils rtl src char_mux_8to1.vhd] \
    [file join $repo_root utils rtl src seg7_hex.vhd] \
    [file join $repo_root utils rtl src seg7_controller.vhd] \
    [file join $repo_root utils rtl src debounce_button.vhd] \
    [file join $repo_root utils rtl src vga_timing_640x480.vhd] \
]

set lab_source_files [list \
    [file join $lab_src_dir square_position_controller.vhd] \
    [file join $lab_src_dir vga_color_renderer.vhd] \
    [file join $lab_src_dir lab4_top.vhd] \
]

set lab_constraint_files [list \
    [file join $lab_src_dir Nexys-4-DDR-Master_ca.xdc] \
]

set simulation_files [list \
    [file join $script_dir sim square_position_controller_tb.vhd] \
    [file join $script_dir sim vga_color_renderer_tb.vhd] \
    [file join $script_dir sim vga_timing_640x480_tb.vhd] \
]

foreach required_file [concat $shared_source_files $lab_source_files $lab_constraint_files $simulation_files] {
    if {![file exists $required_file]} {
        error "Required project file does not exist: $required_file"
    }
}

set project_file [file join $project_dir $project_name.xpr]
if {[file exists $project_file]} {
    open_project $project_file
} else {
    create_project $project_name $project_dir -part xc7a100tcsg324-1 -force
}

set_property enable_vhdl_2008 1 [current_project]

add_files -norecurse -fileset sources_1 $shared_source_files
add_files -norecurse -fileset sources_1 $lab_source_files
add_files -norecurse -fileset constrs_1 $lab_constraint_files
add_files -norecurse -fileset sim_1 $simulation_files

set_property top lab4_top [get_filesets sources_1]
set_property top_auto_set 0 [get_filesets sources_1]
set_property top vga_timing_640x480_tb [get_filesets sim_1]
set_property top_auto_set 0 [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts "Vivado project ready at $project_dir"
puts "Top module: lab4_top"
