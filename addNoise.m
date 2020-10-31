function [v, a, m] = addNoise(v, a, m)
%ADDNOISE Adds noise to the voltage, acceleration, and magnetic field
%measurements

noiseLevels = [.05 .05 .05];

v = v + max(v)*noiseLevels(1)*randn(size(v));

a(:,1) = a(:,1) + max(a(:,1))*noiseLevels(2)*randn(size(a(:,1)));
a(:,2) = a(:,2) + max(a(:,2))*noiseLevels(2)*randn(size(a(:,2)));
a(:,3) = a(:,3) + max(a(:,3))*noiseLevels(2)*randn(size(a(:,3)));

m(:,1) = m(:,1) + max(m(:,1))*noiseLevels(3)*randn(size(m(:,1)));
m(:,2) = m(:,2) + max(m(:,2))*noiseLevels(3)*randn(size(m(:,2)));
m(:,3) = m(:,3) + max(m(:,3))*noiseLevels(3)*randn(size(m(:,3)));

end

