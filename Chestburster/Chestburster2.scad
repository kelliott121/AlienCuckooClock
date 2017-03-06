$fn = 72;

use <Motor.scad>;

//$t = 0.375;

strokeLength = 120;
crankLength = strokeLength/2;
yokeLength = 130;
dowelDiameter = 12.7;
dowelLength = 70;
thickness = 2;
guideDiameter = 19.05;

mountAll = true;

crankAngle = $t * 720;

depression = (crankLength*sin(crankAngle));

union()
{
    translate([0, 0, -depression])
    union()
    {
        if (mountAll)
        {
            color("tan")
            //render()
            rotate([0, 0, 90])
            translate([-8, 0, -5.225])
            import("files/Chestburster.stl");
        }

        translate([0, 0, -dowelLength + 20])
        dowel();
        
        color("gray")
        translate([0, 0, -(10 + 10)])
        clamp();
        
        color("gray")
        translate([-(dowelDiameter - thickness), 0, -(10 + 5)])
        rotate([0, 90, 0])
        yoke();
        
        color("gray")
        translate([(dowelDiameter - thickness), 0, -(10 + 5)])
        rotate([0, 90, 0])
        yoke();
    }
    
    color("darkred")
    translate([0, 0, -110])
    telescope(startDiam=((dowelDiameter+.5)+40), endDiam=(dowelDiameter+.5), t=(thickness/2), taper=1, space=0.5, h=25, extension=(crankLength-depression));
    
    color("green")
    translate([-16, -(yokeLength/2 + (thickness*3)), -(10 + 5)])
    rotate([crankAngle, 0, 0])
    rotate([0, 90, 0])
    crank();
    
    color("green")
    translate([16, -(yokeLength/2 + (thickness*3)), -(10 + 5)])
    rotate([crankAngle, 0, 0])
    rotate([0, -90, 0])
    crank();
    
    translate([0, -(yokeLength/2 + (thickness*3)), -15])
    rotate([90, 0, 0])
    motor_mount_assembly(mounted=mountAll);
}


module dowel()
{
    cylinder(d=dowelDiameter, h=dowelLength);
}


module guide()
{
    difference()
    {
        cylinder(d=(guideDiameter + (thickness*2)), h=50);
        
        translate([0, 0, -1])
        cylinder(d=guideDiameter, h=52);
    }
}

module clamp()
{
    height = 10;
    difference()
    {
        union()
        {
            cylinder(d=(dowelDiameter + (thickness * 2)), h=height);
            translate([0, 0, height/2])
            cube([(dowelDiameter + (thickness * 6)), (thickness - 0.5), height], center=true);
        }
        translate([0, 0, -.5])
        cylinder(d=(dowelDiameter + .8), h=(height + 1));
    }
}


module yoke()
{
    height = 10;
    
    translate([0, -(yokeLength/2 + thickness), 0])
    difference()
    {
        cube([height + thickness*2, (yokeLength) + (thickness*8), thickness*2], center=true);
        
        union()
        {
            translate([0, -thickness*2, 0])
            cube([(height + thickness*2)/2, yokeLength, thickness*4], center=true);
            
            translate([0, ((yokeLength/2) + thickness), 0])
            cube([(height + 0.5), thickness, thickness*4], center=true);
        }
    }
}


module crank()
{
    height = 10;
    
    translate([0, -strokeLength/4, 0])
    difference()
    {
        union()
        {
            cube([height + thickness*2, (yokeLength/2) + (thickness*8), thickness*2], center=true);
            translate([0, -strokeLength/4, 0])
            cylinder(d=height/1.5, h=height*1.6);
        }
        
        translate([0, strokeLength/4, 0])
        scale([1.1, 1.1, 1.1])
        shaft();
    }
}


module coupler()
{
    difference()
    {
        cylinder(d=10, h=12.5, center=true);
        shaft();
    }
}


module motor_mount_assembly(mounted=true)
{
    if (mounted)
    {
        translate([-32.5, 0, 0])
        motor();
        
        translate([32.5, 0, 0])
        motor();
    }
    
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
}


module telescope(startDiam, endDiam, t, taper, space, h, extension=0)
{
    spacing = (t + space + taper);
    number = ((startDiam - (endDiam + taper)) / spacing) + 1;
    perTube = extension/(number-1.5);
    
    for (num = [0:(number - 1)])
    {
        diam = startDiam - (spacing * num);
        translate([0, 0, num * perTube])
        tube(diameter1=diam, diameter2=(diam-taper), height=h, t=thickness/2);
    }
}

module tube(diameter1, diameter2, height, t)
{
    difference()
    {
        cylinder(d1=diameter1, d2=diameter2, h=height);
        translate([0, 0, -0.5])
        cylinder(d1=(diameter1-t*2), d2=(diameter2-t*2), h=height+1);
    }
}