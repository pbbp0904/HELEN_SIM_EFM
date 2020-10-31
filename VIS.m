clear; clc; close all; format long;

SphereRadius = 0.0762;
HalfSpheresApart = 0.102;
RodRadius = 0.008;
RodLength = 1.524;
ConnectorThickness = 0.0381;
ConnectorDepth = 0.016;
VaneRootCord = 0.279;
VaneLength = 0.457;
VaneHeight = 0.229;
VaneDepth = 0.152;

[X,Y,Z] = sphere(20);
[Xc,Yc,Zc] = cylinder(1,10);
Xv = [RodLength/2 RodLength/2 RodLength/2 RodLength/2 RodLength/2 RodLength/2 RodLength/2 RodLength/2+VaneDepth RodLength/2+VaneDepth; RodLength/2+VaneDepth RodLength/2+VaneDepth RodLength/2+VaneDepth RodLength/2+VaneDepth RodLength/2+VaneDepth RodLength/2 RodLength/2 RodLength/2+VaneDepth RodLength/2+VaneDepth];
Yv = [VaneLength/2 -VaneLength/2+VaneRootCord -VaneLength/2 VaneLength/2-VaneRootCord VaneLength/2 VaneLength/2 VaneLength/2-VaneRootCord VaneLength/2 VaneLength/2-VaneRootCord; VaneLength/2 -VaneLength/2+VaneRootCord -VaneLength/2 VaneLength/2-VaneRootCord VaneLength/2 -VaneLength/2+VaneRootCord -VaneLength/2 -VaneLength/2+VaneRootCord -VaneLength/2];
Zv = [VaneHeight/2 -VaneHeight/2 -VaneHeight/2 VaneHeight/2 VaneHeight/2 VaneHeight/2 VaneHeight/2 VaneHeight/2 VaneHeight/2; VaneHeight/2 -VaneHeight/2 -VaneHeight/2 VaneHeight/2 VaneHeight/2 -VaneHeight/2 -VaneHeight/2 -VaneHeight/2 -VaneHeight/2];
axis vis3d

[I1, map1] = imread('aluminum.jpg');
[I2, map2] = imread('carbon.jpg');
[I3, map3] = imread('styrofoam.jpg');
[I4, map4] = imread('print3d.jpg');

hold on
transSpheres = hgtransform;
transVanes = hgtransform;
globe1 = surf(X*SphereRadius, Z*SphereRadius-HalfSpheresApart, Y*SphereRadius, I1, 'Parent', transSpheres, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
globe2 = surf(X*SphereRadius, Z*SphereRadius+HalfSpheresApart, Y*SphereRadius, I1, 'Parent', transSpheres, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
rod = surf(Zc*RodLength-RodLength/2, Yc*RodRadius, Xc*RodRadius, I2, 'Parent', transSpheres, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
connector = surf(Yc*ConnectorThickness, Zc*HalfSpheresApart-HalfSpheresApart/2, Xc*ConnectorDepth, I4, 'Parent', transSpheres, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
vane1 = surf(Xv, Yv, Zv, I3, 'Parent', transVanes, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
vane2 = surf(-Xv, -Yv, Zv, I3, 'Parent', transVanes, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
setLims(1);

theta = 2*pi/.5;
phi = 2*pi/10;

timeStep = 0.02;
timeEnd = 100;

for t = 0:timeStep:timeEnd
    tic
    Rt = makehgtform('xrotate',theta*t);
    Rp = makehgtform('zrotate',phi*t);
    transSpheres.Matrix = Rp*Rt;
    transVanes.Matrix = Rp;
    drawnow
    
    duration = toc;
    if duration < timeStep
        pause(timeStep-duration)
    end
end



function setLims(scale)
    xlim([-scale scale])
    ylim([-scale scale])
    zlim([-scale scale])
end