%% characterize_converter.m
% SIMPLIFIED VERSION — Works with To Workspace block
% No automatic clearing of workspace

%% ============================================
%% 1. LOAD PARAMETERS (DO NOT CLEAR)
%% ============================================
run('parameters_final.m');

%% ============================================
%% 2. SETUP
%% ============================================
duty_cycles = 0.1:0.02:0.9;
num_points = length(duty_cycles);

% Storage for results
Vout_results = zeros(1, num_points);
duty_results = zeros(1, num_points);
success_count = 0;

fprintf('\n========================================\n');
fprintf('CHARACTERIZATION SWEEP\n');
fprintf('========================================\n');
fprintf('Vin = %.1f V, L = %.0f µH, f_sw = %.0f kHz\n', Vin, L*1e6, f_sw/1000);
fprintf('R_load = %.1f ?\n', R_load);
fprintf('========================================\n\n');

%% ============================================
%% 3. RUN EACH SIMULATION
%% ============================================
for i = 1:num_points
    duty = duty_cycles(i);
    
    % Clear previous Vout from workspace (but keep everything else)
    evalin('base', 'clear Vout');
    
    % Set duty cycle
    assignin('base', 'duty_input', duty);
    
    % Run simulation
    try
        sim('buck_boost__mdl');
        
        % Check if Vout was created
        Vout_exists = evalin('base', 'exist(''Vout'', ''var'')');
        
        if Vout_exists
            % Get Vout data
            vout_data = evalin('base', 'Vout');
            
            % Calculate steady-state (last 20%)
            steady_idx = round(0.8 * length(vout_data));
            vout_steady = mean(vout_data(steady_idx:end));
            
            % Store results
            Vout_results(i) = vout_steady;
            duty_results(i) = duty;
            success_count = success_count + 1;
            
            ideal = Vin * (duty / (1 - duty));
            fprintf('? Duty: %.1f%% ? Vout: %.2fV (Ideal: %.2fV)\n', ...
                    duty*100, vout_steady, ideal);
        else
            fprintf('? Duty: %.1f%% ? Vout not found in workspace\n', duty*100);
            Vout_results(i) = NaN;
        end
        
    catch ME
        fprintf('? Duty: %.1f%% ? Error: %s\n', duty*100, ME.message);
        Vout_results(i) = NaN;
    end
end

%% ============================================
%% 4. SAVE RESULTS
%% ============================================
% Remove NaN values for saving
valid_idx = ~isnan(Vout_results);
valid_duty = duty_results(valid_idx);
valid_vout = Vout_results(valid_idx);

% Save to data file
characterization.duty_cycles = valid_duty;
characterization.Vout_steady = valid_vout;
characterization.Vin = Vin;
characterization.L = L;
characterization.f_sw = f_sw;
characterization.R_load = R_load;
characterization.date = date;
characterization.success_count = success_count;
characterization.total_points = num_points;

% Create data folder if it doesn't exist
if ~exist('../data', 'dir')
    mkdir('../data');
end

save('../data/characterization_data.mat', 'characterization');
fprintf('\n? Data saved to: ../data/characterization_data.mat\n');
fprintf('   Successful simulations: %d/%d\n', success_count, num_points);

%% ============================================
%% 5. CREATE PLOT
%% ============================================
if success_count > 0
    figure;
    plot(valid_duty*100, valid_vout, 'b-o', 'LineWidth', 2, 'MarkerSize', 8);
    hold on;
    
    % Ideal curve
    ideal_all = Vin * (valid_duty ./ (1 - valid_duty));
    plot(valid_duty*100, ideal_all, 'r--', 'LineWidth', 1.5);
    
    xlabel('Duty Cycle (%)');
    ylabel('Output Voltage (V)');
    title(sprintf('Buck-Boost Converter (L=%.0fµH, f=%.0fkHz)', L*1e6, f_sw/1000));
    legend('Actual (with losses)', 'Ideal (lossless)', 'Location', 'northwest');
    grid on;
    
    % Create figures folder if it doesn't exist
    if ~exist('../results/figures', 'dir')
        mkdir('../results/figures');
    end
    
    saveas(gcf, '../results/figures/characterization_plot.png');
    fprintf('? Plot saved to: ../results/figures/characterization_plot.png\n');
    
    % Display key results
    fprintf('\n========================================\n');
    fprintf('KEY RESULTS\n');
    fprintf('========================================\n');
    
    % Find closest to 0.3, 0.5, 0.7
    [~, idx30] = min(abs(valid_duty - 0.3));
    [~, idx50] = min(abs(valid_duty - 0.5));
    [~, idx70] = min(abs(valid_duty - 0.7));
    
    fprintf('Duty 30%% ? Vout = %.2fV\n', valid_vout(idx30));
    fprintf('Duty 50%% ? Vout = %.2fV\n', valid_vout(idx50));
    fprintf('Duty 70%% ? Vout = %.2fV\n', valid_vout(idx70));
    fprintf('========================================\n');
else
    fprintf('\n? No successful simulations. Check your model.\n');
end