use <FaceHugger/FaceHugger.scad>;
use <Clock.scad>;
use <Mannequin.scad>;

color("tan")
translate([0, 100, 505])
rotate([-90, 0, 0])
union()
{
    body(top=true);
    body(bottom=true);
}

//human();
color("yellow")
translate([-32.5, 0, -215])
rotate([0, 0, 180])
scale([100, 100, 100])
import("dummytop.stl");

color("tan")
translate([0, 75, 200])
rotate([90, -90, 180])
import("Chestburster/files/Chestburster.stl");

translate([0, 135, 500])
rotate([90, 0, 0])
scale([-1, 1, 1])
clock();