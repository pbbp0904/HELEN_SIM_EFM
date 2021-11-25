q1 = 40;
q2 = -50;
q3 = 10;

x1 = 100;
x2 = -200;
x3 = 300;
y1 = -300;
y2 = 500;
y3 = -250;
z1 = 8000;
z2 = 6000;
z3 = 4000;


q1 = 40*(1+(rand()-0.5));
q2 = -40*(1+(rand()-0.5));
q3 = 10*(1+(rand()-0.5));
x1 = 1000*(rand()-0.5);
x2 = 1000*(rand()-0.5);
x3 = 1000*(rand()-0.5);
y1 = 1000*(rand()-0.5);
y2 = 1000*(rand()-0.5);
y3 = 1000*(rand()-0.5);
z1 = 8000*(1+(rand()-0.5));
z2 = 6000*(1+(rand()-0.5));
z3 = 4000*(1+(rand()-0.5));

% Input Guesses
x0.q1 = 40*(1+(rand()-0.5));
x0.q2 = -40*(1+(rand()-0.5));
x0.q3 = 10*(1+(rand()-0.5));
x0.x1 = 1000*(rand()-0.5);
x0.x2 = 1000*(rand()-0.5);
x0.x3 = 1000*(rand()-0.5);
x0.y1 = 1000*(rand()-0.5);
x0.y2 = 1000*(rand()-0.5);
x0.y3 = 1000*(rand()-0.5);
x0.z1 = 8000*(1+(rand()-0.5));
x0.z2 = 6000*(1+(rand()-0.5));
x0.z3 = 4000*(1+(rand()-0.5));

xMin = -15000;
xMax =  15000;
xStep =   100;

yMin = -15000;
yMax =  15000;
yStep =   100;

zMin =      0;
zMax =  30000;
zStep =   100;

x = zeros(length(xMin:xStep:xMax),1,1);
y = zeros(1,length(yMin:yStep:yMax),1);
z = zeros(1,1,length(zMin:zStep:zMax));

x(:,1,1) = xMin:xStep:xMax;
y(1,:,1) = yMin:yStep:yMax;
z(1,1,:) = zMin:zStep:zMax;

qs = [q1,q2,q3];
xs = [x1,x2,x3];
ys = [y1,y2,y3];
zs = [z1,z2,z3];

numOfMeasurements = 4;

[E_x,E_y,E_z] = makeEField(x,y,z,qs,xs,ys,zs);
[A,E] = createMeasurements(x,y,z,E_x,E_y,E_z,numOfMeasurements);
for i = 1:20
    x0.q1 = 40*(1+(rand()-0.5));
    x0.q2 = -40*(1+(rand()-0.5));
    x0.q3 = 10*(1+(rand()-0.5));
    x0.x1 = 1000*(rand()-0.5);
    x0.x2 = 1000*(rand()-0.5);
    x0.x3 = 1000*(rand()-0.5);
    x0.y1 = 1000*(rand()-0.5);
    x0.y2 = 1000*(rand()-0.5);
    x0.y3 = 1000*(rand()-0.5);
    x0.z1 = 8000*(1+(rand()-0.5));
    x0.z2 = 6000*(1+(rand()-0.5));
    x0.z3 = 4000*(1+(rand()-0.5));
    
    [sol,fval] = chargeSolverSIM(A,E,length(qs),x0)
    [sol3(:,i)] = sol;
    [fval3(:,i)] = fval;
    i
end


sol3Array = squeeze(cell2mat(struct2cell(sol3)))';
DistVct = pdist(sol3Array);
DistMtx = squareform(DistVct);
