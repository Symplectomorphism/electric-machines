clear; clc; close all
%DC Motor Parameters

R = 2;      % Armature resistance in Ohms
L =  0.002; % Armature inductance in Henrys
KT = 0.07;  % Torque Constant = Back Emf constant in N-m/Amp
%np = 1     % Number of Pole pairs
J = 6.0e-5; % Moment of inertia in Kg-m^2
f = 4e-4;   % Viscous friction coefficient in Nm/rad/sec 
imax = 5;   % Maximum continous current in Amps
vmax = 40;  


Ts = 0.001; %Sample period for the differentiation of position calculation
% wdiff = (theta[nTs] - theta[(n-1)Ts])/Ts

integrator_saturation = 10000;
encoder = 2000; %Number of pulses put out by the motor in one revolution of the motor shaft

%Initial Conditions
theta0 = 0; %.1
omega0 = 0; % 1
load_torque = 0; %.035

%Current Controller Gains 
Kp = 100+100;
KI = 100*100;

%Gains for Speed Observer
p1 = 300; p2 = 300; p3 = 300;

l1 = p1 + p2 + p3 - f/J;
l2 = p1*p2 + p1*p3 + p2*p3 -l1*(f/J);
l3 = -p1*p2*p3;

%Gains for Trajectory Tracking Controller
r1 = 50; 
r2 = 50; 
r3 = 50; 
k0 = r1*r2*r3;
k1 = r1*r2 + r1*r3 + r2*r3;
k2 = r1+r2+r3;

