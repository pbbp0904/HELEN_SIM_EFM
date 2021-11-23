function  compareCalcToSim(Ks, eField, Rot, time, v, a, m, eCalc)
%COMPARECALCTOSIM Compares the calculated eField with the simulated eField

Exsim = eField.X;
Eysim = eField.Y;
Ezsim = eField.Z;

Estrengthsim = sqrt(Exsim^2+Eysim^2+Ezsim^2);
Edirectionsim = [Exsim, Eysim, Ezsim]/norm([Exsim Eysim Ezsim]);

Excalc = eCalc(1);
Eycalc = eCalc(2);
Ezcalc = eCalc(3);

Estrengthcalc = sqrt(Excalc^2+Eycalc^2+Ezcalc^2);
Edirectioncalc = [Excalc, Eycalc, Ezcalc]/norm([Excalc Eycalc Ezcalc]);

fprintf("Actual Ex: %.3f V/m\n",Exsim);
fprintf("Actual Ey: %.3f V/m\n",Eysim);
fprintf("Actual Ez: %.3f V/m\n",Ezsim);
fprintf("Actual Electric Field Strength: %.0f V/m\n", Estrengthsim)
fprintf("Actual Electric Field Direction: [%.3f %.3f %.3f]\n\n", Edirectionsim(1), Edirectionsim(2), Edirectionsim(3));

fprintf("Calculated Ex: %.3f V/m\n",Excalc);
fprintf("Calculated Ey: %.3f V/m\n",Eycalc);
fprintf("Calculated Ez: %.3f V/m\n",Ezcalc);
fprintf("Calculated Electric Field Strength: %.0f V/m\n", Estrengthcalc)
fprintf("Calculated Electric Field Direction: [%.3f %.3f %.3f]\n\n\n", Edirectioncalc(1), Edirectioncalc(2), Edirectioncalc(3));


fprintf('Percent Error for Ex: %.6f%%\n', 100*abs((Exsim-Excalc)/Exsim));
fprintf('Percent Error for Ey: %.6f%%\n', 100*abs((Eysim-Eycalc)/Eysim));
fprintf('Percent Error for Ez: %.6f%%\n\n', 100*abs((Ezsim-Ezcalc)/Ezsim));

fprintf("Percent Error for Electric Field Strength: %.6f%%\n", 100*abs((Estrengthsim-Estrengthcalc)/Estrengthsim));
dirXError = 100*abs((Edirectionsim(1)-Edirectioncalc(1))/Edirectionsim(1));
dirYError = 100*abs((Edirectionsim(2)-Edirectioncalc(2))/Edirectionsim(2));
dirZError = 100*abs((Edirectionsim(3)-Edirectioncalc(3))/Edirectionsim(3));
fprintf("Percent Error for Electric Field Direction: [%.6f%% %.6f%% %.6f%%]\n\n", dirXError, dirYError, dirZError);

end