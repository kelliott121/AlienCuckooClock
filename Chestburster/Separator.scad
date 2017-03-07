$fn = 72;

separator();

module separator()
{
	difference()
	{
		union()
		{
			translate([0, 0, 1.25])
			cube([30, 30, 2.5], center=true);
			
			cylinder(d=26, h=12.5);
		}
		
		cylinder(d=22, h=12.5);
	}
}