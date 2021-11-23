function plotMeasurements(time, v, a, m)
%PLOTMEASUREMENTS A function to plot the measurements over time

figure()
hold on
plot(time,v, 'LineWidth', 1)
title('Voltage Over Time')
xlabel('Time (s)')
ylabel('Voltage (V)')

figure()
hold on
plot(time,a(:,1), 'LineWidth', 1)
plot(time,a(:,3), 'LineWidth', 1)
title('Acceleration Components Over Time')
legend('Radial', 'Tangential')
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')

figure()
hold on
plot(time,m(:,1), 'LineWidth', 1)
plot(time,m(:,2), 'LineWidth', 1)
plot(time,m(:,3), 'LineWidth', 1)
title('Magnetic Field Components Over Time')
legend('Radial', 'On Axis', 'Tangential')
xlabel('Time (s)')
ylabel('Magnetic Field (T)')
end

