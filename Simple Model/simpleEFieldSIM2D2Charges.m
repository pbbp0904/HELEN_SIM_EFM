q1 = 40;
q2 = -40;

x1 = 0;
x2 = 0;
y1 = 0;
y2 = 0;
z1 = 12000;
z2 = 7000;


e1 = 8.8541878*10^-12;
e2 = 8.8541878*10^-12;
x = -20000:100:20000;
y = 0;
z = (0:100:30000)';

E_x1 = q1*(x-x1)./(4*pi*e1*((x-x1).^2+(y-y1).^2+(z-z1).^2).^(3/2));
E_x2 = q2*(x-x2)./(4*pi*e2*((x-x2).^2+(y-y2).^2+(z-z2).^2).^(3/2));

E_y1 = q1*(y-y1)./(4*pi*e1*((x-x1).^2+(y-y1).^2+(z-z1).^2).^(3/2));
E_y2 = q2*(y-y2)./(4*pi*e2*((x-x2).^2+(y-y2).^2+(z-z2).^2).^(3/2));

E_z1 = q1*(z-z1)./(4*pi*e1*((x-x1).^2+(y-y1).^2+(z-z1).^2).^(3/2));
E_z2 = q2*(z-z2)./(4*pi*e2*((x-x2).^2+(y-y2).^2+(z-z2).^2).^(3/2));


E_x1p = -q1*(x-x1)./(4*pi*e1*((x-x1).^2+(y-y1).^2+(z+z1).^2).^(3/2));
E_x2p = -q2*(x-x2)./(4*pi*e2*((x-x2).^2+(y-y2).^2+(z+z2).^2).^(3/2));

E_y1p = -q1*(y-y1)./(4*pi*e1*((x-x1).^2+(y-y1).^2+(z+z1).^2).^(3/2));
E_y2p = -q2*(y-y2)./(4*pi*e2*((x-x2).^2+(y-y2).^2+(z+z2).^2).^(3/2));

E_z1p = -q1*(z+z1)./(4*pi*e1*((x-x1).^2+(y-y1).^2+(z+z1).^2).^(3/2));
E_z2p = -q2*(z+z2)./(4*pi*e2*((x-x2).^2+(y-y2).^2+(z+z2).^2).^(3/2));




E_x = E_x1 + E_x2 + E_x1p + E_x2p;
E_y = E_y1 + E_y2 + E_y1p + E_y2p;
E_z = E_z1 + E_z2 + E_z1p + E_z2p;

E_t = sqrt(E_x.^2+E_z.^2);


VThreshold = 10000;
E_x(E_x>VThreshold) = VThreshold;
E_x(E_x<-VThreshold) = -VThreshold;

E_z(E_z>VThreshold) = VThreshold;
E_z(E_z<-VThreshold) = -VThreshold;

E_t(E_t>sqrt(2)*VThreshold) = sqrt(2)*VThreshold;
E_t(E_t<-sqrt(2)*VThreshold) = -sqrt(2)*VThreshold;




figure()
hold on
surf(x./1000,z./1000,E_z./1000,'EdgeColor','none','FaceColor','interp')
title('Simulated Upward (Z) Component of The Electric Field for A Dipole Thunderstorm')
xlabel('Horizontal Distance, km')
ylabel('Vertical Distance, km')
colormap jet
colorbar
a=colorbar;
ylabel(a,'Electric Field kV/m','FontSize',12,'Rotation',90);

figure()
hold on
surf(x./1000,z./1000,E_x./1000,'EdgeColor','none','FaceColor','interp')
title('Simulated Horizontal (X-Y) Component of The Electric Field for A Dipole Thunderstorm')
xlabel('Horizontal Distance, km')
ylabel('Vertical Distance, km')
colormap jet
a=colorbar;
ylabel(a,'Electric Field kV/m','FontSize',12,'Rotation',90);

figure()
hold on
surf(x./1000,z./1000,E_t./1000,'EdgeColor','none','FaceColor','interp')
title('Simulated Magnitude of The Electric Field for A Dipole Thunderstorm')
xlabel('Horizontal Distance, km')
ylabel('Vertical Distance, km')
colormap jet
a=colorbar;
ylabel(a,'Electric Field kV/m','FontSize',12,'Rotation',90);
