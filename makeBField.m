function [bField] = makeBField()
%MAKEBFIELD Makes the magnetic field for the EFM SIM

bField.Stength = 5*10^(-5); % T
bField.Direction = [0,0.5,-0.866]; % Magnetic Field Vector at North American Latitudes
bField.Vector = bField.Stength*(bField.Direction/norm(bField.Direction));
bField.X = bField.Vector(1);
bField.Y = bField.Vector(2);
bField.Z = bField.Vector(3);
end