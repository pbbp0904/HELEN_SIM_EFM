q1 = 40;
q2 = -40;
q3 = 3;

x1 = 0;
x2 = 0;
x3 = 0;
y1 = 0;
y2 = 0;
y3 = 0;
z1 = 12000;
z2 = 7000;
z3 = 2000;


x = -30000:10:30000;
y = 0;
z = [0:10:30000,fliplr(0:10:30000-10)];



e1 = 8.8541878*10^-12;
e2 = 8.8541878*10^-12;
e3 = 8.8541878*10^-12;

E_x1 = q1*(x-x1)./(4*pi*e1*((x-x1).^2+(y-y1).^2+(z-z1).^2).^(3/2));
E_x2 = q2*(x-x2)./(4*pi*e2*((x-x2).^2+(y-y2).^2+(z-z2).^2).^(3/2));
E_x3 = q3*(x-x3)./(4*pi*e3*((x-x3).^2+(y-y3).^2+(z-z3).^2).^(3/2));

E_y1 = q1*(y-y1)./(4*pi*e1*((x-x1).^2+(y-y1).^2+(z-z1).^2).^(3/2));
E_y2 = q2*(y-y2)./(4*pi*e2*((x-x2).^2+(y-y2).^2+(z-z2).^2).^(3/2));
E_y3 = q3*(y-y3)./(4*pi*e3*((x-x3).^2+(y-y3).^2+(z-z3).^2).^(3/2));

E_z1 = q1*(z-z1)./(4*pi*e1*((x-x1).^2+(y-y1).^2+(z-z1).^2).^(3/2));
E_z2 = q2*(z-z2)./(4*pi*e2*((x-x2).^2+(y-y2).^2+(z-z2).^2).^(3/2));
E_z3 = q3*(z-z3)./(4*pi*e3*((x-x3).^2+(y-y3).^2+(z-z3).^2).^(3/2));


E_x1p = -q1*(x-x1)./(4*pi*e1*((x-x1).^2+(y-y1).^2+(z+z1).^2).^(3/2));
E_x2p = -q2*(x-x2)./(4*pi*e2*((x-x2).^2+(y-y2).^2+(z+z2).^2).^(3/2));
E_x3p = -q3*(x-x3)./(4*pi*e3*((x-x3).^2+(y-y3).^2+(z+z3).^2).^(3/2));

E_y1p = -q1*(y-y1)./(4*pi*e1*((x-x1).^2+(y-y1).^2+(z+z1).^2).^(3/2));
E_y2p = -q2*(y-y2)./(4*pi*e2*((x-x2).^2+(y-y2).^2+(z+z2).^2).^(3/2));
E_y3p = -q3*(y-y3)./(4*pi*e3*((x-x3).^2+(y-y3).^2+(z+z3).^2).^(3/2));

E_z1p = -q1*(z+z1)./(4*pi*e1*((x-x1).^2+(y-y1).^2+(z+z1).^2).^(3/2));
E_z2p = -q2*(z+z2)./(4*pi*e2*((x-x2).^2+(y-y2).^2+(z+z2).^2).^(3/2));
E_z3p = -q3*(z+z3)./(4*pi*e3*((x-x3).^2+(y-y3).^2+(z+z3).^2).^(3/2));




E_x = E_x1 + E_x2 + E_x3 + E_x1p + E_x2p + E_x3p;
E_y = E_y1 + E_y2 + E_y3 + E_y1p + E_y2p + E_y3p;
E_z = E_z1 + E_z2 + E_z3 + E_z1p + E_z2p + E_z3p;

figure()
hold on
plot(x./1000,z./1000)
scatter(x1./1000,z1./1000,100,[1,0,0],'filled')
scatter(x2./1000,z2./1000,100,[0,0,1],'filled')
scatter(x3./1000,z3./1000,100,[1,0,0],'filled')
title('Simulated Path of Instrument and Location of Charges')
legend('Instrument Path')

figure()
hold on
plot(x./1000,E_x)
plot(x./1000,E_z)
title('Simulated Airborne Electric Field as a Function of X')
legend('Electric Field (x)','Electric Field (z)')

figure()
hold on
plot(z./1000,E_x)
plot(z./1000,E_z)
title('Simulated Airborne Electric Field as a Function of Z')
legend('Electric Field (x)','Electric Field (z)')


