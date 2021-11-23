lightningFlashRate = 1/5; % per second
timeAloft = 2*60*60; % in seconds
TGFsPerFlash = 1/2600; % Average number of TGFs per lightning flash

maxSimFlights = 100000;
s = zeros(1,maxSimFlights);
for i = 1:maxSimFlights
    r = rand(1,round(timeAloft*lightningFlashRate));
    s(i) = sum(r<TGFsPerFlash);
end
mean(s)

% Should just equal timeAloft * TGFsPerFlash * lightningFlashRate
timeAloft*TGFsPerFlash*lightningFlashRate