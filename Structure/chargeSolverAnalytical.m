function [solution] = chargeSolverAnalytical()
% Attepmts to find the location of three point charges in a tripole thunderstorm from
% the measurements of 4 electric field strengths and directions
% INPUTS:
%   Nothing
% OUTPUTS:
%   Analytic Solution


syms q [1 3] real
syms x [1 3] real
syms y [1 3] real
syms z [1 3] real
syms A [4 3] real
syms E [4 3] real

qs = [q1,q2,q3];
cloc = [x1,y1,z1;x2,y2,z2;x3,y3,z3];
qsp = [-q1,-q2,-q3];
clocp = [x1,y1,-z1;x2,y2,-z2;x3,y3,-z3];

syms e0 real

equ = sym(zeros(1,12));
for payload = 1:4
    for coord = 1:3
        tempequ = sym(0);
        for charge = 1:3
            tempequ = tempequ + qs(charge)*(A(payload,coord)-cloc(charge,coord))/(4*pi*e0*((A(payload,1)-cloc(charge,1))^2+(A(payload,2)-cloc(charge,2))^2+(A(payload,3)-cloc(charge,3))^2)^(3/2))  +  qsp(charge)*(A(payload,coord)-clocp(charge,coord))/(4*pi*e0*((A(payload,1)-clocp(charge,1))^2+(A(payload,2)-clocp(charge,2))^2+(A(payload,3)-clocp(charge,3))^2)^(3/2));
        end
        equ((payload-1)*3+coord) = E(payload,coord) == tempequ;
    end
end

solution = solve(equ,[q1 q2 q3 x1 x2 x3 y1 y2 y3 z1 z2 z3]);
% Trys its best but doesn't yield a solution

