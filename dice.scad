$fa = 1;  // 1 for rendering     6 for design
$fs = .04;  // .04 for rendering   1 for design

module filletCube(side,filletRadius) {
    d = side/2 - filletRadius;
    hull() {
        for (x=[-1:2:1]) {
            for (y=[-1:2:1]) {
                for (z=[-1:2:1]) {
                    translate([d*x,d*y,d*z]){
                        sphere(filletRadius);
                    }
                }
            }
        }
    }
}

module hollowSphere(outsideRadius,insideRadius) {
    difference() {
        sphere(outsideRadius);
        sphere(insideRadius);
    }
}

module pipOpening(pipRadius=1,maxAngle=40,pipPosition=[0,0,0],faceDirection=[0,0,1]) {
    sphereRadius = pipRadius * sqrt(tan(90-maxAngle) + 1);
    delta = sqrt(sphereRadius^2 - pipRadius^2);

    translate([faceDirection[0]*delta,faceDirection[1]*delta,faceDirection[2]*delta]) {
        translate(pipPosition) {
            sphere(sphereRadius);
        }
    }
}

module facePips(number,side,pipRadius=1,maxAngle=40,faceRotation=[0,0,0]) {
    rotate(faceRotation) {
        translate([0,0,side/2]) {
            m=sqrt(((side/2)^2)*2)/3;
            if (number==1 || number==3 || number==5) {
                pipOpening(pipRadius,maxAngle,[0,0,0],[0,0,1]);
            }
            if (number != 1) {
                pipOpening(pipRadius,maxAngle,[-m,m,0],[0,0,1]);
                pipOpening(pipRadius,maxAngle,[m,-m,0],[0,0,1]);
            }
            if (number > 3) {
                pipOpening(pipRadius,maxAngle,[m,m,0],[0,0,1]);
                pipOpening(pipRadius,maxAngle,[-m,-m,0],[0,0,1]);
            }
            if (number == 6) {
                pipOpening(pipRadius,maxAngle,[m,0,0],[0,0,1]);
                pipOpening(pipRadius,maxAngle,[-m,0,0],[0,0,1]);
            }
        }
    }
}

size = 50;
fillet = size/10;
maxOverhangDegrees = 40;

difference(){
    filletCube(size,fillet);
    hollowSphere(size,size*11/16);

    facePips(1,size,fillet,maxOverhangDegrees,[180,0,0]);
    facePips(2,size,fillet,maxOverhangDegrees,[0,90,0]);
    facePips(3,size,fillet,maxOverhangDegrees,[-90,0,0]);
    facePips(4,size,fillet,maxOverhangDegrees,[90,0,0]);
    facePips(5,size,fillet,maxOverhangDegrees,[0,-90,0]);
    facePips(6,size,fillet,maxOverhangDegrees,[0,0,0]);

}

