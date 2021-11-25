function [A,E] = createMeasurements(x,y,z,E_x,E_y,E_z,numOfMeasurements)
% Creates field measurements from random locations in the space of the
% vector field
% INPUTS:
%   x,y,z - 3 orthoganal vectors defining the space
%   E_x,E_y,E_z - field components in x,y, and z directions
%   numOfMeasurements - number of measurements points desired
% OUTPUTS:
%   A - the location of the measurement points in the space
%   E - the x,y, and z field measurements at the locations

A = zeros(numOfMeasurements,3);
E = zeros(numOfMeasurements,3);

xind = randi(length(x),1,numOfMeasurements);
yind = randi(length(y),1,numOfMeasurements);
zind = randi(length(z),1,numOfMeasurements);

A(:,1) = squeeze(x(xind))';
A(:,2) = squeeze(y(yind))';
A(:,3) = squeeze(z(zind))';

for measurement = 1:numOfMeasurements
    E(measurement,1) = E_x(xind(measurement),yind(measurement),zind(measurement));
    E(measurement,2) = E_y(xind(measurement),yind(measurement),zind(measurement));
    E(measurement,3) = E_z(xind(measurement),yind(measurement),zind(measurement));
end

end
