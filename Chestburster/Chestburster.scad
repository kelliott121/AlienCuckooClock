$fn = 72;

use <Motor.scad>;

//$t = 0.25;

strokeLength = 120;
rotatorLength = strokeLength/2;
armLength = 130;

rotatorAngle = $t * 720;
armAngle = asin((rotatorLength*sin(rotatorAngle))/armLength);

depression = (armLength*(1-cos(armAngle)) + rotatorLength*(1-cos(rotatorAngle)));

translate([0, 0, -depression])
union()
{
    color("tan")
    //render()
    translate([-8, 0, -5.225])
    import("files/Chestburster.stl");

    //cylinder(d=75, h=120);

    translate([0, 0, -30])
    mount();
}

color("gray")
render()
translate([0, 0, -(armLength + 20)])
guide();

color("red")
render()
translate([0, 0, -depression])
union()
{
    translate([0, -40, -90])
    translate([(armLength/2)*sin(armAngle), 0, (armLength/2) - (armLength/2)*cos(armAngle)])
    rotate([0, -armAngle, 0])
    arm();

    translate([0, 40, -90])
    translate([(armLength/2)*sin(armAngle), 0, (armLength/2) - (armLength/2)*cos(armAngle)])
    rotate([0, -armAngle, 0])
    arm();
}

translate([0, 0, -((armLength/2) + 150)])
union()
{
    color("blue")
    translate([0, -35.5, 0])
    rotate([0, ($t * 720), 0])
    rotator();

    color("blue")
    translate([0, 35.5, 0])
    rotate([0, ($t * 720), 0])
    rotator();

    translate([0, 20, 0])
    rotate([90, 0, 90])
    motor();

    translate([0, -20, 0])
    rotate([90, 0, 90])
    motor();

	color("gray")
    translate([0, 0, 0])
    rotate([90, 0, 90])
    motor_mount_assembly();

    translate([0, 0, 0])
    rotate([90, 0, 0])
    coupler();
}

module mount()
{
    difference()
    {
        union()
        {
            translate([0, 0, 30])
            cylinder(d=15, h=10);
            translate([0, 0, 10])
            cylinder(d1=75, d2=15, h=20);
            translate([0, 0, -30])
            cylinder(d=75, h=40);
        }
        
        union()
        {
            translate([0, 0, 30])
            cylinder(d=10, h=10);
            translate([0, 0, 10])
            cylinder(d1=70, d2=10, h=20);
            translate([0, 0, -32])
            cylinder(d=70, h=42);
            
            translate([0, 0, 5])
            rotate([90, 0, 0])
            cylinder(d=2.5, h=200, center=true);
        }
    }
}

module arm()
{
    difference()
    {
        cube([7.5, 4, armLength + 10], center=true);
        
        union()
        {
            translate([0, 0, armLength/2])
            rotate([90, 0, 0])
            cylinder(d=2.5, h=20, center=true);
            
            translate([0, 0, -armLength/2])
            rotate([90, 0, 0])
            cylinder(d=2.5, h=20, center=true);
        }
    }
}

module rotator()
{
    rotate([90, 0, 0])
    difference()
    {
        translate([0, 30, 0])
        cube([10, 70, 4], center=true);
        //cylinder(d=130, h=4, center=true);
        
        union()
        {
            translate([0, rotatorLength, 0])
            cylinder(d=2.5, h=5, center=true);
            
            shaft();
        }
    }
}

module guide()
{
    
    difference()
    { 
        union()
        {
            cylinder(d=81, h=armLength+20);
            
            translate([0, 0, -2.5 + armLength + 20])
            cube([100, 65, 5], center=true);
        }
        
        union()
        {
            translate([0, 0, -5])
            cylinder(d=76, h=(armLength+30));
            
            translate([0, 37.5, (armLength+30)/2])
            cube([100, 10, (armLength+30)], center=true);
            
            translate([0, -37.5, (armLength+30)/2])
            cube([100, 10, (armLength+30)], center=true);
            
            translate([0, 20, ((armLength+20)/2)])
            cube([100, 10, (armLength+10)], center=true);
            
            translate([0, 0, ((armLength+20)/2)])
            cube([100, 10, (armLength+10)], center=true);
            
            translate([0, -20, ((armLength+20)/2)])
            cube([100, 10, (armLength+10)], center=true);
        }
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

module motor_mount_assembly()
{
    translate([8.75, 0, 0])
    motor_mount(supports=false);

    translate([-8.75, 0, 0])
    scale([-1, 1, 1])
    motor_mount(supports=false);
    
    translate([0, -50, -2.75])
    difference()
    {
        cube([20.5, 46, 33], center=true);
        cube([14.5, 47, 29], center=true);
    }
    
    translate([0, -75, 0])
    cube([100, 5, 100], center=true);
}