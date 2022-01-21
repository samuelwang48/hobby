include <../core.scad>
include <../vitamins/stepper_motors.scad>
include <../smooth_prim.scad>

use <../utils/layout.scad>

//                                   corner  body    boss    boss          shaft               cap         thread black  end    shaft    shaft
//                     side, length, radius, radius, radius, depth, shaft, length,      holes, heights,    dia,   caps,  conn,  length2, bore
NEMA17Sx = ["NEMA17S",  42.3, 34,     53.6/2, 25,     11,     2,     5,     8,          31,    [8,     8], 3,     false, false, 0,       0];





translatex = -7.738;
mh = 15;
bleed = 2;
tw = 28;

offsetx = 0;

mount_inner_d = 55;

m5d = 5.1;
m5d_cap = 9.5;

module stepper_motors()
    rotate([0, 0, 90])
        NEMA(NEMA17Sx, 0);
        
module filament()
    translate([-33, 26/2-9, 2])
        cube([66, 3, 3]);

module extruder() {
    color([0,1,0])
    translate([-10, -13, 0])
        cube([20, 26, 8]);
}

module thread() {
    cylinder(15, d=3, center=false);
}

module support() {
    
    
    union() {
        difference() {
            translate([-21, -21-4, 0])
                SmoothXYCube([28, 42+4*2, 7.5], 2);
            
            
            translate([-10, -13, -2])
                SmoothXYCube([20, 26, 12], 2);
            
            cylinder(3, d=22, center=false);
            
            filament();
            
            
            translate([-31/2, -31/2, -2])
                thread();
            translate([-31/2, 31/2, -2])
                thread();
        }

        union() {
            color([1, 1, 0.5])
            union() {
                translate([-21, -21-4, -34])
                    SmoothXYCube([28, 4, 34+7.5], 2);
                
                mirror([0, 1, 0])
                translate([-21, -21-4, -34])
                    SmoothXYCube([28, 4, 34+7.5], 2);
            }
    
            union() {
                support_insert();
                support_insert_stop();
            }
            
            mirror([0, 1, 0])
            union() {
                support_insert();
                support_insert_stop();
            }
        }
        
        
        
    }
    
    /*
    difference() {
        translate([-21-2.5, -21, -37])
            cube([2.5, 42, 37+7.5]);
        filament();
        
        // side
        translate([-21-7.5-2, -38/2, -37-2])
        color([0,1,0])
            cube([7.5, 38, 37+7.5]);
        
        // outlet
        translate([-21-7.5, -10/2, -37-2])
        color([1,0,0])
            cube([10, 10, 15]);
    }
    //*/
    
}

stopx = 21;
stopy = 28;
stopz = 34;
stopw = 4;
stopt = 3;
stop_gap = 1.33;

module support_insert_stop() {
    
}


module support_insert() {
    difference() {
        union() {
            union() {
                difference() {
                    color([1, 0, 0])
                    translate([-stopx, -stopx-stopw, -stopz-stopt])
                        SmoothXYCube([stopy, stopw, stopt], 2);
                    
                    translate([-stopx-2/2+8/2, -stopx-stopw/2-stop_gap/2, -stopz-stopw-4])
                        cube([stopy+2-8, stop_gap, stopw+4]);
                    
                }
                
                difference() {
                    difference() {
                        difference() {
                            color([1, 0.5, 0.5])
                            rotate([0, 90, 0])
                            translate([stopz + 0.8, -stopx-stopw-stop_gap/2, -stopx-stop_gap/2])
                                SmoothCube([stopt+1, stopw+stop_gap, stopy+stop_gap], 2);
                        
                            translate([-stopx-2/2, (-stopx-stopw/2-stop_gap/2)-stopw+stop_gap, -stopz-stopw-2])
                                cube([stopy+2, stopw, stopw+2]);
                        }
                    
                        translate([-stopx-0.5*2, -stopx-stopw-3.3/2, -stopz-stopt])
                            cube([stopy+2, stopw+3.3, stopt], 2);
                        
                    }
                
                    color([0, 1, 0.5])
                    union() {
                        translate([-stopx+stop_gap*2-10, -stopx-stopw-3.3/2, -stopz-6])
                            cube([stop_gap+10, stopw+3.3, 10], 2);
                    
                    
                        translate([stopy-stopx-stop_gap*(1+2), -stopx-stopw-3.3/2, -stopz-6])
                            cube([stop_gap+10, stopw+3.3, 10], 2);
                    }
                }
            }
        }
        
        //*
        color([0, 1, 0.5])
        union() {
            translate([-stopx+stop_gap*2, -stopx-stopw-3.3/2, -stopz-8])
                cube([stop_gap, stopw+3.3, 12], 2);
        
        
            translate([stopy-stopx-stop_gap*(1+2), -stopx-stopw-3.3/2, -stopz-8])
                cube([stop_gap, stopw+3.3, 12], 2);
        }
    }
    //*/
}

module mount() {
    /*
    translate([-40, -34.3, mh/2])
    rotate([0, -90, 0])
    nut(M5_nut, true);
    */
    
    difference() {
        difference() {
            translate([-translatex-tw+offsetx, 0, 0])
            difference() {
                difference(){
                    intersection() {
                        difference() {
                            translate([90/2+translatex, 0, 0])
                                cylinder(mh, d=90, center=false);
                            
                            translate([mount_inner_d/2, 0, -bleed/2])
                                cylinder(mh+bleed, d=mount_inner_d, center=false);
                        }
                        
                        
                        /*
                        translate([translatex, -90/2, 0])
                            cube([tw, 90, mh]);
                        //*/
                        
                        translate([translatex, -82/2, mh])
                        rotate([0, 90, 0])
                            SmoothXYCube([mh, 82, tw], 2);
                        
                    }
                
                    color([1,0,0])
                    translate([19, 45, -bleed/2])
                    rotate([0, 0, -90]) {
                        linear_extrude(mh+bleed)
                        polygon(points=[[0,0], [4.951*3, -0.774*3], [12.782*3, -50.13*3]]);
                    }
                    
                    mirror([0,1,0])
                    color([1,0,0])
                    translate([19, 45, -bleed/2])
                    rotate([0, 0, -90]) {
                        linear_extrude(mh+bleed)
                        polygon(points=[[0,0], [4.951*3, -0.774*3], [12.782*3, -50.13*3]]);
                    }
                }
                
                translate([-18.3, 0, mh/2])
                union() {
                    rotate([0, 0, -45])
                    translate([translatex, tw, 0])
                    union() {
                        rotate([0, 90, 0])
                        translate([0, -0.5, 0])
                        cylinder(sqrt(2*tw^2), d=5, center=false);
                        
                        rotate([0, 90, 0])
                        translate([0, 0.5, 0])
                        cylinder(sqrt(2*tw^2), d=5, center=false);
                        
                        translate([0, -0.25, -2.5])
                        cube([sqrt(2*tw^2), 0.5, 5]);
                    }
                    
                    
                    mirror([0,1,0])
                    rotate([0, 0, -45])
                    translate([translatex, tw, 0])
                    union() {
                        rotate([0, 90, 0])
                        translate([0, -0.5, 0])
                        cylinder(sqrt(2*tw^2), d=5, center=false);
                        
                        rotate([0, 90, 0])
                        translate([0, 0.5, 0])
                        cylinder(sqrt(2*tw^2), d=5, center=false);
                        
                        translate([0, -0.25, -2.5])
                        cube([sqrt(2*tw^2), 0.5, 5]);
                    }
                }
            }
            
            union() {
                translate([offsetx-1.5, -34.3, mh/2])
                rotate([0, -90, 0])
                cylinder(d=10, h=20, $fn=6);
                
                mirror([0, 1, 0])
                translate([offsetx-1.5, -34.3, mh/2])
                rotate([0, -90, 0])
                cylinder(d=10, h=20, $fn=6);
            }
        }
        
        union() {
            translate([offsetx+8.5, -34.3, mh/2])
            rotate([0, -90, 0])
            cylinder(d=m5d, h=20);
            
            mirror([0, 1, 0])
            translate([offsetx+8.5, -34.3, mh/2])
            rotate([0, -90, 0])
            cylinder(d=m5d, h=20);
        }
    }
    
}

module extruder_with_filament() {
    
    difference() {
        extruder();
        filament();
    }
}

module group_motor() {
    stepper_motors();
    extruder_with_filament();
    support();
}

module middle_hshape() {
    middle_w = 53;
    middle_h = 26;
    middle_y = -55/2-13.5;
    middle_z = middle_h/2;
    middle_t = 3;

    difference() {
        difference() {
            difference() {
                color([1, 1, 1])
                union() {
                    //color([1, 0, 1])
                    translate([5, middle_y, 0])
                    rotate([90, 0, 90])
                    SmoothXYCube([14.5, 69.9+15, middle_t], 2);

                    //color([1, 0, 1])
                    mirror([0, 1, 0])
                    translate([5, middle_y, 0])
                    rotate([90, 0, 90])
                    SmoothXYCube([14.5, 69.9+15, middle_t], 2);

                    translate([0, 0, (69.9+15)/2])
                    union() {
                        //color([1, 0, 0])
                        translate([5, -(middle_w+4)/2, middle_z])
                        rotate([0, 90, 0])
                        SmoothXYCube([middle_h, middle_w+4, middle_t], 2);
                        
                        translate([0, 0, -middle_h])
                        difference() {
                            //color([1, 1, 0])
                            translate([5, -middle_w/2-2, middle_z])
                            rotate([0, 90, 0])
                            SmoothXYCube([10, middle_w+4, middle_t], 2);
                            
                            //color([0, 1, 0])
                            translate([5-1, -middle_w/2, middle_z-5])
                            rotate([0, 90, 0])
                            SmoothXYCube([middle_h, middle_w, middle_t*2], 2);
                        }
                        
                        mirror([0, 0, 1])
                        translate([0, 0, -middle_h])
                        difference() {
                            //color([1, 1, 0])
                            translate([5, -middle_w/2-middle_t, middle_z])
                            rotate([0, 90, 0])
                            SmoothXYCube([10, middle_w+middle_t*2, middle_t], 2);
                            
                            //color([0, 1, 0])
                            translate([5-1, -middle_w/2, middle_z-5])
                            rotate([0, 90, 0])
                            SmoothXYCube([middle_h, middle_w, middle_t*2], 2);
                        }
                    }
                }
                
                //screw
                union() {
                    color([0, 1, 1])
                    translate([0, -(middle_w-20)/2, 28/2+42])
                        rotate([0, 90, 0])
                        SmoothXYCube([28, middle_w-20, 10], 2);
                    
                    color([0, 1, 0])
                    translate([0, -(55+14+middle_t*2)/2, 28/2+42])
                        rotate([0, 90, 0])
                        SmoothXYCube([28, 7, 10], 2);
                    
                    mirror([0, 1, 0])
                    color([0, 1, 0])
                    translate([0, -(55+14+middle_t*2)/2, 28/2+42])
                        rotate([0, 90, 0])
                        SmoothXYCube([28, 7, 10], 2);
                    
                    color([0, 1, 0])
                    translate([0, -stopw-42/2, 28/2+42])
                        rotate([0, 90, 0])
                        SmoothXYCube([28, stopw, 10], 2);
                    
                    mirror([0, 1, 0])
                    color([0, 1, 0])
                    translate([0, -stopw-42/2, 28/2+42])
                        rotate([0, 90, 0])
                        SmoothXYCube([28, stopw, 10], 2);
                }
            }
            
            //screw cap
            union() {
                translate([offsetx+13.3, -34.3, mh/2])
                rotate([0, -90, 0])
                cylinder(d=m5d, h=20);
                
                mirror([0, 1, 0])
                translate([offsetx+13.3, -34.3, mh/2])
                rotate([0, -90, 0])
                cylinder(d=m5d, h=20);
                
                
                translate([offsetx+13.3, -34.3, mh/2+69.9])
                rotate([0, -90, 0])
                cylinder(d=m5d, h=20);
                
                mirror([0, 1, 0])
                translate([offsetx+13.3, -34.3, mh/2+69.9])
                rotate([0, -90, 0])
                cylinder(d=m5d, h=20);
            }
        }
        
        union() {
            translate([offsetx+13.3-middle_t-0.5, -34.3, mh/2])
            rotate([0, -90, 0])
            cylinder(d=m5d_cap, h=middle_t);
            
            mirror([0, 1, 0])
            translate([offsetx+13.3-middle_t-0.5, -34.3, mh/2])
            rotate([0, -90, 0])
            cylinder(d=m5d_cap, h=middle_t);
            
            
            translate([offsetx+13.3-middle_t-0.5, -34.3, mh/2+69.9])
            rotate([0, -90, 0])
            cylinder(d=m5d_cap, h=middle_t);
            
            mirror([0, 1, 0])
            translate([offsetx+13.3-middle_t-0.5, -34.3, mh/2+69.9])
            rotate([0, -90, 0])
            cylinder(d=m5d_cap, h=middle_t);
        }
    }
}

if($preview)
    let($show_threads = 1)

        /*
        translate([33.8+5+14.2, 0, 69.9/2])
        rotate([0, 90, 0])
        group_motor();

        middle_hshape();
        */

        translate([0, 0, 0])
        mount();

        //*
        translate([0, 0, 69.9])
        mount();
        //*/
