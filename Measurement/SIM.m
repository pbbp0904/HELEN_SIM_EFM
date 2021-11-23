% HELEN EFM Sim
clear; clc; close all; format long

% Setup and Environment
disp('Setting up...');
Ks = setConstants();
disp('Generating environment...');
Rot = setRotation();
bField = makeBField();
eField = makeEField();
time = makeTime(Ks);

% Simulating Measurements
disp('Simulating Measurements...');
v = []; a = []; m = []; eCalc = [];
v = [v; getVoltage(time, Ks, Rot, eField)];
a = [a; getAcceleration(time, Ks, Rot)];
m = [m; getMagField(time, Ks, Rot, bField)];

% Adding noise to the measurements
disp('Adding noise...');
[v, a, m] = addNoise(v, a, m);

% Plotting measured values
disp('Plotting measurements...');
plotMeasurements(time, v, a, m);
vSim = v;

%% Calculating electric field from data
disp('Calculating electric field...');
eCalc = [eCalc; calculateEField1Ax(v, a, m, Ks)];

%% Compare the simulation with the calculated results
disp('Comparing calculations to simulation...');
compareCalcToSim(Ks, eField, Rot, time, v, a, m, eCalc);

% Shows a visual representation of the data
disp('Visualizing data...');
visualizeData(Ks, eField, bField, Rot, time, v, a, m, eCalc);

disp('Done!');