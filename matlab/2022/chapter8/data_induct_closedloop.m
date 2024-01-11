clear; close all; clc;
%MOTOR PARAMETERS
%Actual Motor parameters
M = 0.0117; %Henrys
Rr = 3.9; %Ohms
Rs = 1.7; %Ohms
Lr = 0.014; %Henrys
Ls = 0.014; %Henrys
% If f = 0.00014 then the 8000 rpm trajectory cannot be tracked without
% violating the voltage constraints
f = 0; %0.00014; %.00014; %Nm/rad/sec
J = 0.00011; % kgm^2
np = 3; %pole-pairs
V = 60;
Vmax = V;
Imax = 6;
ws = 2*pi*60;
tau_L = 0;

sigma = 1 - M*M/(Lr*Ls);
eta = Rr/Lr;
beta = M/(sigma*Lr*Ls);
mu = np*M/(J*Lr);
KT = np*M/Lr;
gamma = M*M*Rr/(sigma*Lr*Lr*Ls) + Rs/(sigma*Ls);

id0 = 5.5/sqrt(2);
psid0 = M*id0;
wbase = 250; %.6*V/((M/Lr)*np*psid0)

%Motor Parameters used by the Controller 
Rr2 = Rr;
Rs2 = Rs;
Lr2 = Lr;
Ls2 = Ls;
M2 = M;
J2 = J;
sigma2 = 1 - M2*M2/(Lr2*Ls2);
eta2 = Rr/Lr;
beta2 = M2/(sigma2*Lr2*Ls2);
mu2 = np*M2/(J2*Lr2);
KT2 = np*M2/Lr2;
gamma2 = M2*M2*Rr2/(sigma2*Lr2*Lr2*Ls2) + Rs2/(sigma2*Ls2);

vbusmax = sqrt(2)*120;
vdcmax = (2/pi)*vbusmax;
%np3 = 4; % number of pole pairs
%np3 = 50
%

%Current Controller Gains in DQ coordinates
Kp = 100+100;
KI = 100*100;
KPf = 10000;
KIf = 420000;

%Gains for Trajectory Tracking Controller
p0 = 10; %.1;
p1 = 10; %.1;
p2 = 10; %.1;
k0 = p0*p1*p2;
k1 = p0*p1 + p0*p2 + p1*p2;
k2 = p0+p1+p2;

%Trajectory Parameters
wmax = 800;
t1 =  1.5;
tc = 0.1;
t2 =  t1 + tc; %.6;
t3 =  t2 + t1;
tdd = 0.01;

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
% td = t3-t2;
% Ot2 = wmax*t1/2 + wmax*(t2-t1) + d1*td*td*td/3 + d2*td*td*td*td/4;
% Of = wmax*t1/2 + wmax*(t2-t1) + wmax*td/2;
