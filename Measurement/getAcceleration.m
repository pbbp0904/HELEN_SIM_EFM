function [a] = getAcceleration(time, Ks, Rot)
%GETACCELERATION Gets the acceleration of the IMU on the EFM

% Import values
r = Ks.IMURadius;
rrf = Rot.rodFrequency;
lrf = Rot.lineFrequency;
g = Ks.g;
invertX = Ks.IMUXDir;
invertY = Ks.IMUYDir;
invertZ = Ks.IMUZDir;

% Calculate intermediates
theta = 2*pi*rrf;
IMUTanVel = 2*pi*r*rrf;
IMUAxVel = 2*pi*r*lrf;

% Calculate acceleration components
a(:,1) = invertX*(IMUTanVel^2/r - g*sin(theta.*time));
a(:,2) = invertY*(IMUAxVel^2/r);
a(:,3) = invertZ*(-1*g*cos(theta.*time));
end

