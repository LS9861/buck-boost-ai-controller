%% pi_controller_setup.m
% PI Controller Design Documentation

Kp = 0.0012;
Ki = 0.12;
filter_cutoff = 1000;  % 1 kHz

fprintf('PI Controller: Kp=%.4f, Ki=%.4f\n', Kp, Ki);
fprintf('Low-pass filter: %.0f Hz\n', filter_cutoff);