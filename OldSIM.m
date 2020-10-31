% HELEN EFM Sim
clear; clc; close all; format long

% Setup
Ks = setConstants();
Rot = setRotation();
bField = makeBField();
eField = makeEField();
time = makeTime(Ks);

% Generating Environment
v = []; a = []; m = []; eCalc = [];
v = [v; getVoltage(time, Ks, Rot, eField)];
a = [a; getAcceleration(time, Ks, Rot)];
m = [m; getMagField(time, Ks, Rot, bField)];

% Adding noise to the measurements
%[v, a, m] = addNoise(v, a, m);

% Plotting measured values
plotMeasurements(time, v, a, m);

% Calculating electric field from data
eCalc = [eCalc; calculateEField(v, a, m, Ks)];

% Compare the simulation with the calculated results
compareCalcToSim(Ks, eField, Rot, time, v, a, m, eCalc);