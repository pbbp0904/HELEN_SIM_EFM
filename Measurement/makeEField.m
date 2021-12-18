function [eField] = makeEField()
%MAKEEFIELD Makes the electric field for the EFM SIM

eField.Stength = 5000/.75; % V/m
eField.Direction = [1,1/2,1];
eField.Vector = eField.Stength*(eField.Direction/norm(eField.Direction));
eField.X = eField.Vector(1);
eField.Y = eField.Vector(2);
eField.Z = eField.Vector(3);
end