use <Tail.scad>;

$fn = 72;


/*
//translate([0, 0, -4])
clock();

//translate([10, 0, 0])
translate([0, 0, 25.25])
union()
{
    minute_disk(diskDiameter=12);
    translate([0, 0, 2.5])
    minute_extender(diskDiameter=12);
	color([0.25, 0.25, 0.25])
    translate([0, 0, 2.5 + 25])
    minute_hand(diskDiameter=12);
}

//translate([-10, 0, 0])
translate([0, 0, 22])
union()
{
    hour_disk(diskDiameter=19);
    translate([0, 0, 2.5])
    hour_extender(diskDiameter=19);
	color([0.25, 0.25, 0.25])
    rotate([0, 0, 90])
    translate([0, 0, 2.5 + 25])
    hour_hand(diskDiameter=19);
}
*/

hour_hand(diskDiameter=19);

translate([0, 25, 0])
minute_hand(diskDiameter=12);


module clock()
{
    color("black")
    translate([0, 0, 6])
    cube([57, 57, 12], center=true);
    
    color("gray")
    translate([0, 0, 6])
    cylinder(d=8, h=15.5);
    
    color("white")
    translate([0, 0, 15.5+6])
    cylinder(d=5, h=3.5);
    
    color("gray")
    translate([0, 0, 15.5+6+3.5])
    cylinder(d=4, h=3.5);
}


module hour_disk(diskDiameter)
{
    tolerance = 0.2;
    diameter = 5;
    male_diameter = diameter - tolerance*2;
    female_diameter = diameter + tolerance*2;
    
    difference()
    {
        cylinder(d=diskDiameter, h=2.5);
        
        translate([0, 0, -0.25])
        cylinder(d=female_diameter, h=3);
    }
}

//translate([-5, 0, 0])
//hour_extender();
module hour_extender(diskDiameter)
{
    thickness = 2;
    height = 25;
    
    difference()
    {
        cylinder(d=diskDiameter, h=height);
        cylinder(d=diskDiameter-thickness*2, h=height);
    }
}


module hour_hand(diskDiameter)
{
    thickness = 2;
    baseThickness = thickness*0.75;
	baseHeight = diskDiameter*0.29;
    length = 125;
	spacing = 5.5;
    
    difference()
    {
        union()
        {
            cylinder(d=diskDiameter, h=thickness);
            translate([0, -diskDiameter/2, 0])
            cube([length - 18, baseHeight, thickness]);
			
			for (xOffset = [0:16])
			{
				translate([xOffset * spacing + spacing*2.4, -10, 1.25])
				scale([2, 1.7 - (xOffset*.04), 1])
				tailSegment();
			}
			
			translate([length + 10 - 20, -5, 0])
			blade();
        }
        
        cylinder(d=diskDiameter-thickness*2, h=thickness);
    }
}


module minute_disk(diskDiameter)
{
    diameter = 3.9;
    width = 2.9;
    tolerance = 0.2;
    
    difference()
    {
        cylinder(d=diskDiameter, h=2.5);
        
        intersection()
        {
            cylinder(d=diameter + tolerance*2, h=5);
            translate([0, 0, 2.5])
            cube([width + tolerance*2, width * 2, 5], center=true);
        }
    }
}

//translate([5, 0, 0])
//minute_extender();
module minute_extender(diskDiameter)
{
    thickness = 2;
    height = 25;
    
    difference()
    {
        cylinder(d=diskDiameter, h=height);
        cylinder(d=diskDiameter-thickness*2, h=height);
    }
}


module minute_hand(diskDiameter)
{
    thickness = 2;
    baseThickness = thickness*0.75;
	baseHeight = diskDiameter*0.29;
    length = 175;
	spacing = 5.5;
    
	union()
	{
		cylinder(d=diskDiameter, h=thickness);
		translate([0, -diskDiameter/2, 0])
		cube([length - 18, baseHeight, thickness]);
		
		for (xOffset = [0:20])
		{
			translate([xOffset * spacing + spacing*2, -6.5, 1.25])
			scale([2, 1.25 - (xOffset*.02), 1])
			tailSegment();
		}
		
		for (xOffset = [21:25])
		{
			translate([xOffset * spacing + spacing*2, -6.5, 1.25])
			scale([2, 1.75 * sin((xOffset - 21)*30 + 30), 1])
			tailSegment();
		}
		
		translate([length + 10 - 20, -3 , 0])
		scale([1, .75, 1])
		blade();
	}
}