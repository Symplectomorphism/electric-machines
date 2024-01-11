%DC Motor Parameters
clear; clc; close all
R = 2;       % Armature resistance in Ohms
L = 0.002;   % Armature inductance in Henrys
Kb = 0.07;   % Torque Constant = Back Emf constant in N-m/Amp
%np = 4      % Number of Pole pairs
J = 6e-5;    % Moment of inertia in Kg-m^2
f = 0.4e-3;  % Viscous friction coefficient in Nm/rad/sec 
KT = Kb;
Ts = 0.001;  % Sample period for the differentiation of position calculation
% wdiff = (theta[nTs] - theta[(n-1)Ts])/Ts
vmax = 40;
imax = 5;
integrator_saturation = 10000;
encoder = 2000; %Number of pulses put out by the motor in one revolution of the motor shaft

%Current Controller Gains 

%Gains for Speed Observer

%Gains for Trajectory Tracking Controller

%Trajectory Parameters
thetaf = pi;
wmax = 200;  % radians/sec
t1 =  0.03;  % Amount of time the motor takes to go from 0 to wmax.
tc =  0.01;  % Amount of time the motor goes at the constant speed wmax
t2 =  t1+tc; % Time at which the motor starts to decelerate.
t3 =  t2+t1; % Final time
wmax = thetaf/t1;
%td = t3-t2; % Time to decelerate
tdd = 0*0.1; % Time delay before the motor is commanded to move.

c1 =  3*wmax/(t1*t1);
c2 = -2*wmax/(t1*t1*t1);
d1 = c1; %  3*wmax/((t3-t2)*(t3-t2));
d2 = c2; % -2*wmax/((t3-t2)*(t3-t2)*(t3-t2));
%t = ts-tdd
%s = t3 - t
%jerk1 = 2*c1 + 6*c2*t
%jerk2 = 0
%jerk3 = 2*d1 + 6*d2*s
%jerkref1 = IF t<t1 THEN jerk1 ELSE(IF t<t2 THEN jerk2 ELSE jerk3)
%jerkref = IF ts<tdd THEN 0 ELSE IF t<t3 THEN jerkref1 ELSE 0
%Ot2 = wmax*t1/2 + wmax*(t2-t1) + d1*td*td*td/3 + d2*td*td*td*td/4;
%Of = wmax*t1/2 + wmax*(t2-t1) + wmax*td/2; 
%Of is the final position. If td = t3-t2 equals t1 then Of = wmax*t2. 
