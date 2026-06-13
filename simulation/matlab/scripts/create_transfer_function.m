%% create_transfer_function_corrected.m
% Corrected: Calculates gain OUTSIDE the flat zone

clear; close all; clc;

%% Load characterization data
load('../data/characterization_data.mat');

%% Extract data
duty = characterization.duty_cycles;
vout = characterization.Vout_steady;

% Remove NaN
valid = ~isnan(vout);
duty = duty(valid);
vout = vout(valid);

%% Find gain using points before the flat zone (around 46% duty)
% Find index near 46%
[~, idx_46] = min(abs(duty - 0.46));
[~, idx_48] = min(abs(duty - 0.48));

% Calculate gain from 46% to 48%
delta_duty_1 = duty(idx_48) - duty(idx_46);
delta_vout_1 = vout(idx_48) - vout(idx_46);
gain_1 = delta_vout_1 / delta_duty_1;

% Find gain after flat zone (52% to 54%)
[~, idx_52] = min(abs(duty - 0.52));
[~, idx_54] = min(abs(duty - 0.54));

delta_duty_2 = duty(idx_54) - duty(idx_52);
delta_vout_2 = vout(idx_54) - vout(idx_52);
gain_2 = delta_vout_2 / delta_duty_2;

% Use average of both gains
gain = (gain_1 + gain_2) / 2;

%% Find 50% duty for reference
[~, idx_50] = min(abs(duty - 0.5));
vout_at_50 = vout(idx_50);

%% Display results
fprintf('\n========================================\n');
fprintf('TRANSFER FUNCTION RESULTS (Corrected)\n');
fprintf('========================================\n');
fprintf('Data points: %d\n', length(duty));
fprintf('\nBuck side gain (46%% ? 48%%): %.2f\n', gain_1);
fprintf('Boost side gain (52%% ? 54%%): %.2f\n', gain_2);
fprintf('\n? System gain (K): %.2f\n', gain);
fprintf('   This means: 1%% duty change ? %.2fV change\n', gain/100);
fprintf('\nVout at 50%% duty: %.2fV (flat zone)\n', vout_at_50);
fprintf('========================================\n');

%% Quadratic fit (for reference)
p = polyfit(duty, vout, 2);
fprintf('\nQuadratic fit: Vout = %.3f × D² + %.3f × D + %.3f\n', p(1), p(2), p(3));

%% Plot with gain lines
figure('Position', [100, 100, 800, 600]);
plot(duty*100, vout, 'bo-', 'LineWidth', 2, 'MarkerSize', 8);
hold on;

% Add gain lines
duty_line1 = linspace(0.44, 0.48, 50);
vout_line1 = vout(idx_46) + gain_1 * (duty_line1 - duty(idx_46));
plot(duty_line1*100, vout_line1, 'r--', 'LineWidth', 1.5);

duty_line2 = linspace(0.52, 0.56, 50);
vout_line2 = vout(idx_52) + gain_2 * (duty_line2 - duty(idx_52));
plot(duty_line2*100, vout_line2, 'g--', 'LineWidth', 1.5);

% Highlight flat zone
fill([48 52 52 48], [0 0 15 15], 'yellow', 'FaceAlpha', 0.2, 'EdgeColor', 'none');

xlabel('Duty Cycle (%)');
ylabel('Output Voltage (V)');
title('Buck-Boost Converter: Duty vs Vout (Flat Zone Highlighted)');
legend('Measured data', sprintf('Buck gain = %.0f', gain_1), ...
       sprintf('Boost gain = %.0f', gain_2), 'Flat zone (48-52%)', ...
       'Location', 'northwest');
grid on;

%% Save
tf_data.gain = gain;
tf_data.gain_buck = gain_1;
tf_data.gain_boost = gain_2;
tf_data.poly_coeff = p;
tf_data.duty_at_50 = duty(idx_50);
tf_data.vout_at_50 = vout_at_50;
tf_data.flat_zone = [0.48, 0.52];
tf_data.date = date;

save('../data/transfer_function.mat', 'tf_data');
saveas(gcf, '../results/figures/transfer_function_fit.png');

%% PI Design Recommendation
fprintf('\n========================================\n');
fprintf('PI CONTROLLER DESIGN (Using K = %.2f)\n', gain);
fprintf('========================================\n');
fprintf('\nSuggested initial gains:\n');
fprintf('  Kp = 0.5 / K = %.4f\n', 0.5/gain);
fprintf('  Ki = Kp / 0.01 = %.2f\n', (0.5/gain)/0.01);
fprintf('\nFor a slower response (more stable):\n');
fprintf('  Kp = 0.2 / K = %.4f\n', 0.2/gain);
fprintf('  Ki = Kp / 0.02 = %.2f\n', (0.2/gain)/0.02);
fprintf('========================================\n');