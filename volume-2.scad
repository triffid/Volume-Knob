knob_diameter = 60;

knob_rise = 10;
knob_dome_height = 3;

segment_length = 0.5;

pot_travel = 300;
pot_index = 90;

pi = 3.141592653589;

r = knob_diameter / 2;
h = knob_dome_height;
a = (((r * r) + (h * h)) / 2 / h);

sl = segment_length;

module knob() {
	render()
	rotate_extrude($fn = r * 2 * pi / sl) {
		union() {
			difference() {
				translate([0, h - a + knob_rise]) {
					difference() {
						circle(a, $fn = a * 2 * pi / sl);
						translate([-a * 3, -a * 1.5]) square(a * 3);
						translate([r, -a * 1.5]) square(a * 3);
						translate([-a, -a * 3 + a - h - knob_rise]) square(a * 3);
					}
				}
				difference() {
					translate([0, -2]) square([r - 2, knob_rise]);
					translate([0, -5]) rotate(-45) translate([-a, 0]) square(a);
				}
			}
		}
	}
}

rotate([0, 0, -pot_travel / 2 + sin($t * 360 + 90) * pot_travel / 2])
render()
difference() {
	knob();

	rotate([0, 0, pot_index])
	translate([0, 0, -1]) {
		difference() {
			cylinder(r=6.4 / 2, h=knob_rise + 1, $fn=6.4 * pi / sl);
			translate([-3.2 + 5.5, -5, -5]) cube([10, 10, 50]);
		}
		translate([2.3, sqrt((3.2 * 3.2) - (2.3 * 2.3))]) cylinder(r=0.5, h = 11, $fn = 8);
		translate([2.3, -sqrt((3.2 * 3.2) - (2.3 * 2.3))]) cylinder(r=0.5, h = 11, $fn = 8);
		translate([-3.2, 0]) cylinder(r=0.5, h = 11, $fn = 8);
	}
	rotate([0, 0, -90 - ((360 - pot_travel) / 2)]) translate([12, -1, 2]) cube([r, 2, knob_rise + knob_dome_height + 2]);
}
render()
difference() {
	intersection() {
		cylinder(r1=22, r2=10, h=12);
		union() {
			for (i=[0:7]) {
				rotate([0, 0, 360 / 8 * i - 7.5])
					translate([4.5, -0.5, 0]) cube([20, 1, 10]);
			}
		}
	}
	translate([0, 0, -4.95]) cylinder(r1=0, r2=15, h=15, $fn = 44 * pi / sl);
}
