function [sol,fval] = chargeSolverSIM(A,E,numOfCharges,x0)
% Finds the locations of point charges in a field from
% the measurements of electric field strengths and directions
% INPUTS:
%   A - An array of measurement positions in cartesian coordinates
%   E - An array of the Ex, Ey, and Ez components
%   numOfCharges - number of desired charges to solve for
% OUTPUTS:
%   sol - solution of charge values and locations in cartesian coordinates

% Create optimization variables
qs = {};
cloc = {};
for charge = 1:numOfCharges
    q = optimvar(strcat('q',num2str(charge)),'LowerBound',-1000,'UpperBound',1000,'Type','continuous');
    qs{charge} = q;
    qsp{charge} = -q;
    
    x = optimvar(strcat('x',num2str(charge)),'LowerBound',-100000,'UpperBound',100000,'Type','continuous');
    y = optimvar(strcat('y',num2str(charge)),'LowerBound',-100000,'UpperBound',100000,'Type','continuous');
    z = optimvar(strcat('z',num2str(charge)),'LowerBound',0,'UpperBound',100000,'Type','continuous');
    cloc{charge,1} = x;
    cloc{charge,2} = y;
    cloc{charge,3} = z;
    clocp{charge,1} = x;
    clocp{charge,2} = y;
    clocp{charge,3} = -z;
end

e0 = 8.8541878*10^-12;

% Create optimization equations
clear equs
clear Eq
for payload = 1:height(A)
    for coord = 1:3
        charge = 1;
        Eq(payload,coord) = qs{charge}*(A(payload,coord)-cloc{charge,coord})/(4*pi*e0*((A(payload,1)-cloc{charge,1})^2+(A(payload,2)-cloc{charge,2})^2+(A(payload,3)-cloc{charge,3})^2)^(3/2)) + + qsp{charge}*(A(payload,coord)-clocp{charge,coord})/(4*pi*e0*((A(payload,1)-clocp{charge,1})^2+(A(payload,2)-clocp{charge,2})^2+(A(payload,3)-clocp{charge,3})^2)^(3/2));
        for charge = 2:numOfCharges
            Eq(payload,coord) = Eq(payload,coord) + qs{charge}*(A(payload,coord)-cloc{charge,coord})/(4*pi*e0*((A(payload,1)-cloc{charge,1})^2+(A(payload,2)-cloc{charge,2})^2+(A(payload,3)-cloc{charge,3})^2)^(3/2)) + + qsp{charge}*(A(payload,coord)-clocp{charge,coord})/(4*pi*e0*((A(payload,1)-clocp{charge,1})^2+(A(payload,2)-clocp{charge,2})^2+(A(payload,3)-clocp{charge,3})^2)^(3/2));
        end
        equs((payload-1)*3+coord) = Eq(payload,coord) == E(payload,coord);
    end
end

% Create problem
prob = eqnproblem('Equations',equs);

% % Input Guesses
% x0.q1 = 10;
% x0.q2 = -10;
% x0.q3 = 2;
% x0.x1 = 0;
% x0.x2 = 0;
% x0.x3 = 0;
% x0.y1 = 0;
% x0.y2 = 0;
% x0.y3 = 0;
% x0.z1 = 10000;
% x0.z2 = 500;
% x0.z3 = 100;

% Set options and solve
options = optimset('MaxIter',10000,'MaxFunEvals',10000,'Display','none','TolFun',1e-15,'TolX',1e-15);
[sol,fval,exitflag] = solve(prob,x0,'options',options);


