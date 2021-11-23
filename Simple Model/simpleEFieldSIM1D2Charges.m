q1 = 50;
q2 = -50;

x1 = 0;
x2 = 0;
y1 = 0;
y2 = 0;
z1 = 10000;
z2 = 6000;


e1 = 8.8541878*10^-12;
e2 = 8.8541878*10^-12;
x = -20000:10:20000;
y = 0;
z = 0;

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

figure()
hold on
grid on
plot(x./1000,E_z1+E_z1p,'r')
plot(x./1000,E_z2+E_z2p,'b')
plot(x./1000,E_z,'k')
title({'Simulated Upward (Z) Electric Field for A Dipole Thunderstorm', 'As Measured From The Ground with',sprintf('q_1=%iC, x_1=%ikm, z_1=%ikm',q1,x1/1000,z1/1000),sprintf('q_2=%iC, x_2=%ikm, z_2=%ikm',q2,x2/1000,z2/1000)})
legend('Main Postive Charge','Main Negative Charge','Total Electric Field')
xlabel('Horizontal Distance (km)')
ylabel('Vertical Electric Field (kV/m)')
