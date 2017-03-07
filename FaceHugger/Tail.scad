$fn = 72;


tailSegment(h=4.5);
//blade();

module tailSegment(h=4.5)
{
	translate([0, 4.5, 0])
	union()
	{
		base();
		translate([0, 0.5, 0])
		wedge(height=h);
		translate([0, (h * (2/3)) + 0.5, -.625])
		spine(height=h);
	}
}

module spine(height)
{
	h = height * (2/3);
	scale([1, h*2, 1])
	cylinder(d=1, h=1.25, center=true);
	
	translate([0, -1.5, 0])
	linear_extrude(height=1.25, center=true)
	polygon(points=[[-1, 0], [1, 0], [0, 4]]);
}

module wedge(height)
{
	h = height * (1/3);
	rotate([0, -90, 0])
	linear_extrude(height=2, center=true)
	polygon(points=[[-1.25, 0], [1.25, 0], [0, h], [-1.25, h]]);
}

module base()
{
	translate([0, -2, 0])
	cube([2, 5, 2.5], center=true);
}

module blade()
{
	linear_extrude(height=2.5)
	polygon(points=[[-10, -5],[10, -5], [2.5, 0], [-2.5, 2.5], [-10, 5], [-8.75, 2.5], [-8.4, 0], [-8.75, -2.5]]);
}