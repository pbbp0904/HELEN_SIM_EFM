function visualizeData(Ks, eField, bField, Rot, time, v, a, m, eCalc)

[EFM, h] = buildEFM();
quiver3(0,0,0,bField.Direction(1),bField.Direction(2),bField.Direction(3));
quiver3(0,0,0,eField.Direction(1),eField.Direction(2),eField.Direction(3));

theta = 2*pi/.5;
phi = 2*pi/10;

timeStep = time(2)-time(1);
n=1;
for t = time
    tic
    Rt = makehgtform('xrotate',theta*t);
    Rp = makehgtform('zrotate',phi*t);
    EFM.transSpheres.Matrix = Rp*Rt;
    EFM.transVanes.Matrix = Rp;
    drawnow

    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    % Write to the GIF File 
    if n == 1 
        imwrite(imind,cm,'efm.gif','gif', 'Loopcount',inf,'DelayTime',0.02); 
    else
        imwrite(imind,cm,'efm.gif','gif','WriteMode','append','DelayTime',0.02); 
    end 
    n = n + 1;

    duration = toc;
    if duration < timeStep
        pause(timeStep-duration)
    end
end
end





function [EFM,h] = buildEFM()

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

[I1, map1] = imread('aluminum.jpg');
[I2, map2] = imread('carbon.jpg');
[I3, map3] = imread('styrofoam.jpg');
[I4, map4] = imread('print3d.jpg');

h = figure();
axis vis3d
hold on
view(3)
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
set(gca,'ztick',[])
set(gca,'zticklabel',[])
xlim([-1 1])
ylim([-1 1])
zlim([-1 1])
set(gcf,'color','w');
set(gca,'Visible','off')

EFM.transSpheres = hgtransform;
EFM.transVanes = hgtransform;
globe1 = surf(X*SphereRadius, Z*SphereRadius-HalfSpheresApart, Y*SphereRadius, I1, 'Parent', EFM.transSpheres, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
globe2 = surf(X*SphereRadius, Z*SphereRadius+HalfSpheresApart, Y*SphereRadius, I1, 'Parent', EFM.transSpheres, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
rod = surf(Zc*RodLength-RodLength/2, Yc*RodRadius, Xc*RodRadius, I2, 'Parent', EFM.transSpheres, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
connector = surf(Yc*ConnectorThickness, Zc*HalfSpheresApart-HalfSpheresApart/2, Xc*ConnectorDepth, I4, 'Parent', EFM.transSpheres, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
vane1 = surf(Xv, Yv, Zv, I3, 'Parent', EFM.transVanes, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
vane2 = surf(-Xv, -Yv, Zv, I3, 'Parent', EFM.transVanes, 'FaceColor', 'texturemap', 'EdgeColor', 'none');

end