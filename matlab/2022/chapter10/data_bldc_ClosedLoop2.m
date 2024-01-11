clc; clear; close all
%MOTOR PARAMETERS
%Motor Parameter values from Krishnan

%vbusmax = 160;
vmax = 200; %vbusmax;
%omegas = 10*2*pi;
%V = 100;
%Ic = 1;
%Parameter Values from Krishnan
M = 0.15e-3;  %2.5e-3 %0.5e-3  %2.5e-3
Ls = 2.72e-3; %(7/3)*M
Rs = 0.7;  %0.25
J = 2.0e-4;  %13.9e-5;
D = 2e-3; %.0001; % Nm/(rads/sec)
tau_L = 0;
np = 1; % np = 2 %number of pole pairs
ep = 0.5128;  %0.1617  %k
tau_p = ep;
Gamma = [Ls -M -M; -M Ls -M; -M -M Ls];
Gamma_Inv = Gamma^-1;  %Inverse of Inductance Matrix


%Current Controller Gains coordinates
Kp = 1000; %+100;
KI = 0*1e6; %100*100;


%Gains for Trajectory Tracking Controller
p0 = 100; %.1;
p1 = 100; %.1;
p2 = 100; %.1;
k0 = p0*p1*p2;
k1 = p0*p1 + p0*p2 + p1*p2;
k2 = p0+p1+p2;

%Trajectory Parameters
wbase = 4000*2*pi/60;

wmax = 400;
t1 =  .1;
tc = .5;
t2 =  t1 + tc; %.6;
t3 =  t2 + t1;
tdd = .1;

c1 = 3*wmax/(t1*t1);
c2 = -2*wmax/(t1*t1*t1);
d1 = 3*wmax/((t3-t2)*(t3-t2));
d2 = -2*wmax/((t3-t2)*(t3-t2)*(t3-t2));
%t = ts-tdd
%s = t3 - t
%jerk1 = 2*c1 + 6*c2*t
%jerk2 = 0
%jerk3 = 2*d1 + 6*d2*s
%jerkref1 = IF t<t1 THEN jerk1 ELSE(IF t<t2 THEN jerk2 ELSE jerk3)
%jerkref = IF ts<tdd THEN 0 ELSE IF t<t3 THEN jerkref1 ELSE 0
td = t3-t2;
Ot2 = wmax*t1/2 + wmax*(t2-t1) + d1*td*td*td/3 + d2*td*td*td*td/4;
Of = wmax*t1/2 + wmax*(t2-t1) + wmax*td/2;


