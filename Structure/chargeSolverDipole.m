function [sol] = chargeSolverDipole(A,E)
% Finds the location of three point charges in a tripole thunderstorm from
% the measurements of 4 electric field strengths and directions
% INPUTS:
%   A - A 4x3 array of payload positions in cartesian coordinates
%   E - A 4x3 array of the Ex, Ey, and Ez components as measured by the
%   payloads
% OUTPUTS:
%   sol - solution of charge values and locations in cartesian coordinates

% Create optimization variables
q1 = optimvar('q1','LowerBound',-1000,'UpperBound',1000,'Type','continuous');
q2 = optimvar('q2','LowerBound',-1000,'UpperBound',1000,'Type','continuous');

x1 = optimvar('x1','LowerBound',-30000,'UpperBound',30000,'Type','continuous');
x2 = optimvar('x2','LowerBound',-30000,'UpperBound',30000,'Type','continuous');

y1 = optimvar('y1','LowerBound',-30000,'UpperBound',30000,'Type','continuous');
y2 = optimvar('y2','LowerBound',-30000,'UpperBound',30000,'Type','continuous');

z1 = optimvar('z1','LowerBound',-1000,'UpperBound',30000,'Type','continuous');
z2 = optimvar('z2','LowerBound',-1000,'UpperBound',30000,'Type','continuous');


qs = [q1,q2];
cloc = [x1,y1,z1;x2,y2,z2];
qsp = [-q1,-q2];
clocp = [x1,y1,-z1;x2,y2,-z2];

e0 = 8.8541878*10^-12;

% Create optimization equations
clear equs
clear Eq
for payload = 1:4
    for coord = 1:3
        charge = 1;
        Eq(payload,coord) = qs(charge)*(A(payload,coord)-cloc(charge,coord))/(4*pi*e0*((A(payload,1)-cloc(charge,1))^2+(A(payload,2)-cloc(charge,2))^2+(A(payload,3)-cloc(charge,3))^2)^(3/2)) + + qsp(charge)*(A(payload,coord)-clocp(charge,coord))/(4*pi*e0*((A(payload,1)-clocp(charge,1))^2+(A(payload,2)-clocp(charge,2))^2+(A(payload,3)-clocp(charge,3))^2)^(3/2));
        charge = 2;
        Eq(payload,coord) = Eq(payload,coord) + qs(charge)*(A(payload,coord)-cloc(charge,coord))/(4*pi*e0*((A(payload,1)-cloc(charge,1))^2+(A(payload,2)-cloc(charge,2))^2+(A(payload,3)-cloc(charge,3))^2)^(3/2)) + + qsp(charge)*(A(payload,coord)-clocp(charge,coord))/(4*pi*e0*((A(payload,1)-clocp(charge,1))^2+(A(payload,2)-clocp(charge,2))^2+(A(payload,3)-clocp(charge,3))^2)^(3/2));
        equs((payload-1)*3+coord) = Eq(payload,coord) == E(payload,coord);
    end
end

% Create problem
prob = eqnproblem('Equations',equs);

% Input Guesses
x0.q1 = 1;
x0.q2 = -1;

x0.x1 = 0;
x0.x2 = 0;

x0.y1 = 0;
x0.y2 = 0;

x0.z1 = 2000;
x0.z2 = 1000;

% Set options and solve
options = optimset('MaxIter',100000,'MaxFunEvals',100000,'Display','off','TolFun',1e-15,'TolX',1e-15);
[sol,fval,exitflag] = solve(prob,x0,'options',options);




