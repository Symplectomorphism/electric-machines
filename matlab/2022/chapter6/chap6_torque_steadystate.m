close all; clear; clc
np  = 3; nph = 2;
% Rs = 0 - the maximum steady-state torque occurs at S = Sp = Rr/(sigma*ws*Lr)
Rs  = 0; % 1.7  
Ls  =  0.014;
M   =  0.0117;
Lr  =  0.014;
Rr  =  3.9;
%J   =  .00011
Us  = 80;
UsRMS = 80*sqrt(2);
sigma = 1 - M*M/(Ls*Lr);
det = sigma*Ls*Lr;
ws = 60*2*pi;
Sp = Rr/(sigma*ws*Lr);
Sr = sqrt(sigma)*Sp;   % rated slip
Is0 = Us/(ws*Ls);
Isr = Is0/sqrt(sigma);

% For a 2-phase machine with Rs = 0 and Us the peak voltage, the peak torque is 
mp = (1/2)*((1-sigma)/sigma)*Us*Us/(ws*ws*Ls);
mr = mp*2/(sqrt(sigma)+1/sqrt(sigma));  % Rated Torque if Rs = 0.

% More generally for a 2-phase machine 
% mp = M*Im(I_s*I_r^*)  % Does not assume Rs = 0.


for i = 1:2000

S(i) = i*.01;
det_real(i) = Rs*Rr/S(i) - ws*ws*(Ls*Lr - M*M);
det_imag(i) = Rr*ws*Ls/S(i) + ws*Lr*Rs;

det_mag2(i) = det_real(i)*det_real(i)+det_imag(i)*det_imag(i);

% Remember that U_bar_S = jUs

is_imag(i) = Us*((Rr/S(i))*det_real(i)+ ws*Lr*det_imag(i))/det_mag2(i);
is_real(i) = -( Us*(ws*Lr*det_real(i) - (Rr/S(i))*det_imag(i))/det_mag2(i) );

ir_imag(i) = -Us*ws*M*det_imag(i)/det_mag2(i);
ir_real(i) = -( -Us*ws*M*det_real(i)/det_mag2(i) );


is(i) = sqrt(is_real(i)*is_real(i)+is_imag(i)*is_imag(i));
ir(i) = sqrt(ir_real(i)*ir_real(i)+ir_imag(i)*ir_imag(i));

phir(i) = atan2(ir_imag(i),ir_real(i));
phis(i) = atan2(is_imag(i),is_real(i));

torq(i) = M*is(i)*ir(i)*sin(phis(i)-phir(i));
%pwrfact(i) = cos(pi/2-phis(i));
end

torq = [0 torq];
S = [0 S];
%pwrfact(1) = cos(pi/2-0);

%To get Figures 10.9 a,b (page 156) in Leonhard, do the following plots
plot(S,torq, 'b','LineWidth',2, 'MarkerSize',10)
set(gca, 'FontSize',12)
title('Torque vs. Normalized Slip','FontSize',14)
xlabel('S = (\omega_S - n_p\omega_R)/\omega_S','FontSize',14)
%xlabel('S/S_p')
ylabel ('Torque in Nt-m','FontSize',14)

