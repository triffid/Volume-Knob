.PHONY: all view

all: view

view: volume-2_ABS_spliced.gcode
	gcodeview $<

volume-2_ABS_spliced.gcode: volume-2_ABS_LH0.2_ND0.35_FD0.5_x1.gcode volume-2_ABS_LH0.05_ND0.35_FD0.95_x1.gcode
	perl -pe 'exit if /Z8\.8/;' volume-2_ABS_LH0.2_ND0.35_FD0.5_x1.gcode > volume-2_ABS_spliced.gcode
	grep -A9999999 Z8\.8 volume-2_ABS_LH0.05_ND0.35_FD0.95_x1.gcode >> volume-2_ABS_spliced.gcode

volume-2_ABS_LH0.2_ND0.35_FD0.5_x1.gcode: volume-2.stl
	slic3r-abs --extrusion-width-ratio 2.5 --fill-density 0.5 $<

volume-2_ABS_LH0.05_ND0.35_FD0.95_x1.gcode: volume-2.stl
	slic3r-abs --perimeters 3 --layer-height 0.05 --fill-density 0.95 --first-layer-height-ratio 4 --extrusion-width-ratio 10 $<

volume-2.stl: volume-2.scad
	openscad -o $@ $<
