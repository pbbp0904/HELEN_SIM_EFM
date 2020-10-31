function [v] = getVoltage(t, Ks, Rot, eField)
% Load electric Field
Ex = eField.X;
Ey = eField.Y;
Ez = eField.Z;

% Load sphere properties
sa = Ks.sphereArea;
rrf = Rot.rodFrequency;
lrf = Rot.lineFrequency;

% Load electrical properties
cac = Ks.chargeAmpCapacitance;
ag = Ks.ampGain;

% Load conversions and constants
e0 = Ks.e0;

% Calculate voltage
v = ag*((e0.*sa)./(cac)).*((Ex.*sin(2*pi*lrf.*t).*cos(2*pi*rrf.*t))-(Ey.*cos(2*pi*lrf.*t).*cos(2*pi*rrf.*t))-(Ez.*sin(2*pi*rrf.*t)));
end

