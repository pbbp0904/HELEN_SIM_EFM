function [eField] = calculateEField3Ax(v, a, m, Ks)
%CALCULATEEFIELD Calculates the electric field based on measured voltage,
%acceleration, and magnetic field.

% Import values
cac = Ks.chargeAmpCapacitance;
e0 = Ks.e0;
g = Ks.g;
sa = Ks.sphereArea;
sp = Ks.samplePeriod;
gain = Ks.ampGain;

% Make Time
t = 0:sp:(length(m(:,2))-1)*sp;

% Calculate rod frequency intermediates
swt = (a(:,1) + mean(a(:,1)))/g;
cwt = (a(:,3))/g;

% Calculating line frequency intermediates by fitting sin omega t and cos
% omega t to axial magnetic field measurements

y = smooth(t,m(:,2)',0.01,'rloess')';
x = t;
yu = max(y);
yl = min(y);
yr = (yu-yl);                                                % Range of ‘y’
ac=xcorr(y,y);
[~,locs]=findpeaks(ac);
per = mean(diff(locs))*sp;                                   % Estimate period
ym = mean(y);                                                % Estimate offset
fit = @(b,x)  b(1).*(sin(2*pi*x./b(2) + 2*pi/b(3))) + b(4);  % Function to fit
fcn = @(b) sum((fit(b,x) - y).^2);                           % Least-Squares cost function
options = optimset('MaxFunEvals',1000000,'MaxIter',1000000); % Options for minimazation 
s = fminsearch(fcn, [yr;  per;  -1;  ym],options);           % Minimise Least-Squares

sOt = sin(2*pi*t/s(2) + 2*pi/s(3));
cOt = sin(2*pi*t/s(2) + 2*pi/s(3) + pi/2);

% Calculate electric field Z component
d = designfilt('lowpassfir', ...
    'PassbandFrequency',0.000000001,'StopbandFrequency',sp*(2.5), ...
    'PassbandRipple',0.0001,'StopbandAttenuation',40, ...
    'DesignMethod','equiripple');
EzVec = filter(d,v'.*swt);
middle = length(EzVec)*.5;
bound = length(EzVec)*.1;
Ez = mean(EzVec(middle-bound:middle+bound))*(-2*cac)/(e0*sa*gain);


% Calculate electric field H component
d = designfilt('bandpassfir','FilterOrder',30, ...
         'CutoffFrequency1',1/s(2)*.95,'CutoffFrequency2',1/s(2)*1.05, ...
         'SampleRate',1/sp);
EhVec = filtfilt(d,(v'.*cwt)).*(2*cac)/(e0*sa*gain);

% Design lowpass filter for X and Y components
d = designfilt('lowpassfir', ...
    'PassbandFrequency',0.000000001,'StopbandFrequency',sp/s(2)*3, ...
    'PassbandRipple',0.001,'StopbandAttenuation',20, ...
    'DesignMethod','equiripple');

% Calculate electric field X component
ExVec = filter(d,2*EhVec.*sOt');
bound = length(ExVec)*.1;
Ex = mean(ExVec(length(ExVec)-bound:length(ExVec)));

% Calculate electric field Y component
EyVec = filter(d,-2*EhVec.*cOt');
bound = length(EyVec)*.1;
Ey = mean(EyVec(length(EyVec)-bound:length(EyVec)));

% Combine components into eField vector
eField = [Ex, Ey, Ez];

%Debug
%figure()
%hold on
%plot(ExVec)
%plot(EyVec)
%plot(EzVec)

end

