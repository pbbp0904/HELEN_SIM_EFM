function [time] = makeTime(Ks)

% Making time window for simulation
startTime = 0;
endTime = 50; % In seconds
time = startTime:Ks.samplePeriod:endTime;

end

