clock();

module clock()
{
    color("black")
    cube([5, 5, 5], center=true);

    color("black")
    translate([0, 50, 0])
    cube([5, 100, 5], center=true);

    color("black")
    rotate([0, 0, -90])
    translate([0, 25, 0])
    cube([5, 50, 5], center=true);
}