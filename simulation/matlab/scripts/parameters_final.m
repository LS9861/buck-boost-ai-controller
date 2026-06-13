% parameters.m
% Non Invertable Buck-Boost Converter (Uni directional) System Parameters
% MATLAB 2018a Compatible
% ============================================

clear all; close all; clc;

%% parameters_final.m
% Your Working Parameters for Buck-Boost Converter
% Tested and verified: 330µH, 25kHz, 10? load
%% simulating setting 
% cont mode
T_maxStep=1e-6;  % Max step size
T_RelTol=1e-4;  % Relative tolerance
T_AbsTol=1e-6;  % Relative tolerance
% descrete
T_sample = 1e-7; % Sampling time
%% Power Stage
Vin = 12;               % Input voltage (V) - Fixed
L = 330e-6;             % Inductance (330 µH)
C_out = 47e-6;          % Output capacitance (47 µF)
C_in = 100e-6;          % Input capacitance (100 µF)

%% Switching
f_sw = 25000;           % Switching frequency (25 kHz)
T_sw = 1/f_sw;          % Period (40 µs)

%% Load (for CCM operation at mid to high duty)
R_load = 5;            % Load resistance (10 ?)

%% Parasitic Elements (Realistic)
R_L = 0.15;             % Inductor series resistance (?)
R_C = 0.05;             % Capacitor ESR (?)
V_f_diode = 0.4;        % Diode forward voltage (V)
R_ds_on = 0.035;        % MOSFET on-resistance (?)
Ron= 0.01; 
%% Control Limits (for future)
duty_min = 0.05;        % Minimum duty cycle
duty_max = 0.95;        % Maximum duty cycle

%% Display Configuration
fprintf('\n=== PARAMETERS LOADED ===\n');
fprintf('Vin = %.1f V\n', Vin);
fprintf('L = %.0f µH\n', L*1e6);
fprintf('C_out = %.0f µF\n', C_out*1e6);
fprintf('f_sw = %.0f kHz\n', f_sw/1000);
fprintf('R_load = %.1f ?\n', R_load);
fprintf('=========================\n\n');