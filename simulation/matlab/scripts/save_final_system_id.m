%% save_final_system_id.m
% Save the final validated system identification model

clear; close all; clc;

%% Final system identification parameters
% From step response test: 10V to 20V at t=100ms
system_id_final.K = 1.80;           % Static gain
system_id_final.tau = 0.0108;       % Time constant (seconds)
system_id_final.G = tf(1.80, [0.0108, 1]);  % Transfer function
system_id_final.date = date;
system_id_final.description = 'Step response: 10V to 20V at t=100ms';
system_id_final.notes = 'Valid for small changes around 10-20V output';

%% Ensure data folder exists
if ~exist('../data', 'dir')
    mkdir('../data');
end

%% Save to file
save('../data/system_id_final.mat', 'system_id_final');

%% Display confirmation
fprintf('\n========================================\n');
fprintf('FINAL SYSTEM ID SAVED\n');
fprintf('========================================\n');
fprintf('G(s) = %.2f / (%.4fs + 1)\n', system_id_final.K, system_id_final.tau);
fprintf('Time constant: %.1f ms\n', system_id_final.tau*1000);
fprintf('Cutoff frequency: %.1f Hz\n', 1/(2*pi*system_id_final.tau));
fprintf('========================================\n');
fprintf('? Saved to: ../data/system_id_final.mat\n');