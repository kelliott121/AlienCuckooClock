$fn = 36;



difference()
{
    body(top=true);
    //body(bottom=true);
    union()
    {
        clockworks();
        //translate([0, 0, 25 + 17.5])
        //cube([100, 100, 50], center=true);
    }
}


module body(top=false, bottom=false)
{
    translate([64, 0, 0])
    union()
    {
        if (top)
        {
            //color("blue")
            //translate([26, 5, 0])
            //import("FaceHugger_Top_PLA.stl", convexity=20);
            
            //color("red")
            translate([-45.46, -50.72, 5.27])
            import("FaceHugger_Top_PLA_Fixed.stl", convexity=20);
        }

        if (bottom)
        {
            //color("blue")
            //rotate([0, 180, 0])
            //import("FaceHuggerBottom_PLA.stl", convexity=200);
            
            //color("red")
            rotate([0, 180, 0])
            import("FaceHuggerBottom_PLA_Fixed.stl", convexity=200);
        }
    }
}

module clockworks()
{
    height = 100;
    zOffset = 0;
    union()
    {
        translate([0, 0, zOffset - (height/2)])
        cube([57, 57, height], center=true);
        
        translate([0, 0, zOffset])
        cylinder(d1=25, d2=20, h=25);
        
        translate([0, 0, zOffset + 25])
        cylinder(d=20, h=35);
    }
}
