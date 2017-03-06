$fn = 36;

skinColor = [255/255, 224/255, 189/255];

human();

module human()
{
    torso();
    translate([0, 0, 450])
    neck();
    translate([0, 25, 550])
    head();
}

module torso()
{
    height = 450;
    widths = [335, 300, 270, 270, 305, 345, 350, 125];
    depths = [225, 225, 225, 225, 225, 225, 225, 125];

    stackHeight = height / (len(widths) - 1);

    color("gray")
    for (stackNum = [0:(len(widths) - 2)])
    {
        translate([0, 0, stackNum * stackHeight])
        linear_extrude( height=stackHeight, slices=20,
                        scale=[widths[stackNum+1]/widths[stackNum], depths[stackNum+1]/depths[stackNum]])
        scale([widths[stackNum], depths[stackNum],1])
        circle(d=1);
    }
}

module neck()
{
    color(skinColor)
    translate([0, -7.5, 0])
    cylinder(d=100, h=30);
}

module head()
{
    /*
    color(skinColor)
    translate([0, -6, 125])
    scale([1.1, 1.1, 1.5])
    sphere(d=155);
    */
    rotate([0, 0, 180])
    color(skinColor)
    import("human-head.stl");
}