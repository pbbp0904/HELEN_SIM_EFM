function [E_x,E_y,E_z] = makeEField(x,y,z,qs,xs,ys,zs)
% Makes the electric field from a number of point charges
% given a perfect conductor at z=0.
% INPUTS:
%   x,y,z - 3 orthoganal vectors defining the space
%   qs - charge values in Coulombs
%   xs - x positions of the charges
%   xs - y positions of the charges
%   xs - z positions of the charges
% OUTPUTS:
%   E_x,E_y,E_z - the electric field in x,y,z directions

% Set constant
e0 = 8.8541878*10^-12;

% Initialize variables
E_x = zeros(length(x),length(y),length(z));
E_y = zeros(length(x),length(y),length(z));
E_z = zeros(length(x),length(y),length(z));

% Make electric field
for charge = 1:length(qs)
    E_x = E_x + qs(charge)*(x-xs(charge))./(4*pi*e0*((x-xs(charge)).^2+(y-ys(charge)).^2+(z-zs(charge)).^2).^(3/2));
    E_x = E_x - qs(charge)*(x-xs(charge))./(4*pi*e0*((x-xs(charge)).^2+(y-ys(charge)).^2+(z+zs(charge)).^2).^(3/2));
    E_y = E_y + qs(charge)*(y-ys(charge))./(4*pi*e0*((x-xs(charge)).^2+(y-ys(charge)).^2+(z-zs(charge)).^2).^(3/2));
    E_y = E_y - qs(charge)*(y-ys(charge))./(4*pi*e0*((x-xs(charge)).^2+(y-ys(charge)).^2+(z+zs(charge)).^2).^(3/2)); 
    E_z = E_z + qs(charge)*(z-zs(charge))./(4*pi*e0*((x-xs(charge)).^2+(y-ys(charge)).^2+(z-zs(charge)).^2).^(3/2));
    E_z = E_z - qs(charge)*(z+zs(charge))./(4*pi*e0*((x-xs(charge)).^2+(y-ys(charge)).^2+(z+zs(charge)).^2).^(3/2));
end


end

