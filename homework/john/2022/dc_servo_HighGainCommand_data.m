clear; clc; close all

% DC Motor Parameters
R = 2;      % Armature resistance in Ohms
L =  0.002; % Armature inductance in Henrys
KT = 0.07;  % Torque Constant = Back Emf constant in N-m/Amp
%np = 4     % Number of Pole pairs
J = 6.0e-5; % Moment of inertia in Kg-m^2
f = 4e-4;   % Viscous friction coefficient in Nm/rad/sec 
imax = 5;   % Maximum continous current in Amps
vmax = 40;  % 

Ts = 0.001; % Sample period for the differentiation of position calculation
% wdiff = (theta[nTs] - theta[(n-1)Ts])/Ts

integrator_saturation = 10000;
encoder = 2000; %Number of pulses put out by the motor in one revolution of the motor shaft

%Initial Conditions
theta0 = 0; %.1
omega0 = 0; % 1
load_torque = 0; %.035

%Current Controller Gains 
k = 100;
Kp = k;
KI = k*k;
% The current controller is stable for 
% k*R > (R/L)/(f/J) = 1000/6.67 = 150
% k > 150/R = 75
