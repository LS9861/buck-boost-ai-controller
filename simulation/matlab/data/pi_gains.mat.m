%% Save PI gains
pi_gains.Kp = 0.0012;
pi_gains.Ki = 0.12;
pi_gains.filter_cutoff = 1000;  % 1 kHz
pi_gains.description = 'Working PI gains with low-pass filter';
pi_gains.date = date;
pi_gains.notes = 'Kp=0.0012, Ki=0.12. Settling time ~0.6 sec. Works 5V-28V.';

save('../data/pi_gains.mat', 'pi_gains');
fprintf('? pi_gains.mat saved\n');