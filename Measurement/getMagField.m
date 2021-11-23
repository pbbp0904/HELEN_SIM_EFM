function [m] = getMagField(time, Ks, Rot, bField)
%GETMAGFIELD Gets the magnetic field of the IMU on the EFM

% Import values
rrf = Rot.rodFrequency;
lrf = Rot.lineFrequency;
invertX = Ks.IMUXDir;
invertY = Ks.IMUYDir;
invertZ = Ks.IMUZDir;
By = bField.Y;
Bz = bField.Z;

% Calculate intermediates
theta = 2*pi*rrf;
phi = 2*pi*lrf;

% Calculate acceleration components
m(:,1) = invertX*(By*cos(phi*time).*cos(theta*time)+ Bz*sin(theta*time));
m(:,2) = invertY*(By*sin(phi*time));
m(:,3) = invertZ*(Bz*cos(theta*time)-By*cos(phi*time).*sin(theta*time));
end

