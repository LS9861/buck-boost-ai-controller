% parameters.m
% Buck-Boost Converter (Uni directional) System Parameters
% MATLAB 2018a Compatible
% ============================================

clear all; close all; clc;
T_sample = 1e-7; % Sampling time
%% ============================================
%% 1. INPUT POWER PARAMETERS
%% ============================================
Vin = 12;               % Input voltage (Volts) - Fixed 12V DC
Vin_min = 10;           % Minimum input voltage for testing (Volts)
Vin_max = 14;           % Maximum input voltage for testing (Volts)

%% ============================================
%% 2. OUTPUT SPECIFICATIONS
%% ============================================
Vout_ref = 10;          % Reference output voltage (Volts) - Change this
Vout_min = 5;           % Minimum output voltage (Volts)
Vout_max = 15;          % Maximum output voltage (Volts)
Pout_max = 6;           % Maximum output power (Watts)
Iout_max = Pout_max / Vout_min;  % Maximum output current ~1.2A

%% ============================================
%% 3. PASSIVE COMPONENTS 
%% ============================================
L = 330e-6;              % Inductance (Henry) - 47 µH
C_out = 47e-6;          % Output capacitance (Farad) - 47 µF
C_in = 100e-6;          % Input capacitance (Farad) - 100 µF

%% Parasitic elements (for realistic simulation)
R_L = 0.20;              % Inductor series resistance (Ohms)
R_C = 0.05;             % Capacitor series resistance (Ohms)
R_load = 10;%Vout_ref^2 / Pout_max;  % Load resistance (Ohms) - ~16.7 Ohms

%% ============================================
%% 4. SWITCHING PARAMETERS
%% ============================================
f_sw = 25000;           % Switching frequency (Hz) - 50 kHz
T_sw = 1 / f_sw;        % Switching period (seconds) - 20 µs
duty_cycle = 0.5;       % Initial duty cycle (0 to 1) - 50%

%% ============================================
%% 6. CONTROL PARAMETERS (Initial for PID)
%% ============================================
%% PID gains (will be tuned later)
Kp = 1.5;               % Proportional gain
Ki = 0.3;               % Integral gain
Kd = 0.0;              % Derivative gain



