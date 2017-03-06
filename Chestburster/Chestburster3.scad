$fn = 72;

use <Motor.scad>;

//$t = 0.0;

strokeLength = 120;
halfStroke = strokeLength/2;
dowelDiameter = 12.7;
dowelLength = 70;
thickness = 2;

mm_per_tooth = 2.5;
n1 = 40;
angle_per_tooth = (360 / n1);
mm_per_degree = (mm_per_tooth / angle_per_tooth);

mountAll = false;

progression = 200*sin($t * 360);

depression = mm_per_degree*progression;


union()
{
    yOffset = 35;
    
    translate([0, 0, -depression])
    union()
    {
        if (mountAll)
        {
            translate([0, 0, 20])
            union()
            {
                color("tan")
                //render()
                rotate([0, 0, 90])
                translate([-8, 0, -5.225])
                import("files/Chestburster.stl");
            
                translate([0, 0, -(dowelLength - 20)])
                dowel();
            }
        }
    
        for (yScale = [-1, 1])
        {
            for (xScale = [-1, 1])
            {
                /*
                scale([xScale, yScale, 1])
                translate([18.5, -yOffset, 0])
                rotate([0, 90, 0])
                color("pink")
                rotate([0, 0, -progression])
                pinion();
                */

                union()
                {
                    scale([xScale, yScale, 1])
                    translate([-11.5, -yOffset, 0])
                    rotate([90, 0, 0])
                    motor_mount(supports=false);
                }
            }
            
            if (mountAll)
            {
                scale([1, yScale, 1])
                translate([0, -yOffset, 0])
                rotate([90, 0, 0])
                motor();
            }
        }
        
        color("purple")
        translate([0, 0, -7.5])
        clamp();
    }
    /*
    for (zScale = [-1, 1])
    {
        scale([1, 1, zScale])
        translate([0, 0, 73.75 + thickness])
        rack_mount();
    }
    
    for (yScale = [-1, 1])
    {
        for (xScale = [-1, 1])
        {
            scale([xScale, yScale, 1])
            translate([-19, -(18 + yOffset), 0])
            color("lightblue")
            rotate([0, 90, 0])
            import("stl/rack.stl");
        }
    }
    */
}



module pinion()
{
    difference()
    {
        import("stl/pinion.stl");
        scale([1.05, 1.05, 1])
        shaft();
    }
}


module dowel()
{
    cylinder(d=dowelDiameter, h=dowelLength);
}


module clamp()
{
    height = 40;
    difference()
    {
        union()
        {
            cylinder(d=(dowelDiameter + (thickness * 2)), h=height, center=true);
            
            cube([(dowelDiameter + (thickness * 6)), (thickness*2), height], center=true);
            
            cube([80, 10, height], center=true);
            
            for (xScale = [-1, 1])
            {
                translate([xScale*11.5, 0, 0])
                cube([thickness*1.5, 32, height], center=true);
            }
        }

        union()
        {
            cylinder(d=(dowelDiameter + .8), h=(height + 1), center=true);
            
            for (xScale = [-1, 1])
            {
                translate([xScale*35, 0, 0])
                cylinder(d=4, h=height*1.1, center=true);
            }
        }
    }
}

module rack_mount()
{
    translate([0, 0, thickness])
    difference()
    {
        union()
        {
            cube([49.25 + thickness*4, 120.75 + thickness*4, thickness*2], center=true);
            cube([80, 25, thickness*2], center=true);
        }
        
        union()
        {
            scale([1, 2, 1])
            cylinder(d=50, h=thickness*3, center=true);
            
            for (xScale = [-1, 1])
            {
                for (yScale = [-1, 1])
                {
                    scale([xScale, yScale, 1])
                    translate([19, 53, 0])
                    cube([11.5, 15.5, thickness*3], center=true);
                }
                
                translate([xScale*35, 0, 0])
                cylinder(d=2.5, h=5, center=true);
            }
        }
    }
}


module motor_mount_assembly(mounted=true)
{
    if (mounted)
    {
        //translate([-32.5, 0, 0])
        //motor();
        
        //translate([32.5, 0, 0])
        //motor();
    }
    /*
    translate([44, 0, 0])
    scale([1, 1, -1])
    motor_mount(supports=false);

    translate([-44, 0, 0])
    scale([1, 1, -1])
    motor_mount(supports=false);
    
    translate([-44, -7.5, 49])
    cube([thickness*2, 40, 60], center=true);
    
    translate([44, -7.5, 49])
    cube([thickness*2, 40, 60], center=true);
    
    translate([0, -7.5, 80])
    cube([92, 40, thickness], center=true);
    */
}

//switch_mount();
module switch_mount()
{
	holeWidth = 3;
	holeOffset = 2;
	holeSpacing = 9.5;
	
	difference()
	{
		translate([0, 1.5, 0])
		cube([16, 7, 2], center=true);
		
		for (xOffset = [-holeSpacing/2, holeSpacing/2])
		{
			translate([xOffset, holeOffset, 0])
			cylinder(d=holeWidth, h=5, center=true);
		}
	}
	
	translate([0, -1, 12])
	cube([16, 2, 24], center=true);
}