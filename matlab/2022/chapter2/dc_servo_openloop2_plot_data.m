clc; close all; clear
load motor_data
size(motor_data);

t = motor_data(1,:);
theta_cnts = motor_data(2,:);
current = motor_data(3,:);
omega = motor_data(4,:);

plot(t,theta_cnts,'b','LineWidth',2, 'MarkerSize',10);
% The "b" means use a blue line
% The thickness of the line is set by "LineWidth" value
% which is 2 in this example
set(gca,'FontSize',15)
title('\theta  in counts vs. time','FontSize',12)
ylabel('Counts','FontSize',12)
xlabel ('seconds','FontSize',12)
% 
figure  % Put the next plot on a new figure 
%
plot(t,current,'--m','LineWidth',2, 'MarkerSize',5,'Marker',"o");
set(gca,'FontSize',12)
% The "--" means use a dashed line
% The "m" means use the color magenta
% The "o" means use markers in the shape of circles
% The size of the markers is set using "MarkerSize"
title('i(t) vs. time','FontSize',12)
ylabel('Amperes','FontSize',12)
xlabel ('seconds','FontSize',12)

figure  % Put the next plot on a new figure 
% 
plot(t,omega,'--r','LineWidth',2, 'MarkerSize',10);
title('\omega(t)  vs. time','FontSize',12)
ylabel('radians/sec','FontSize',12)
xlabel ('seconds','FontSize',12)
set(gca,'FontSize',12)
% 

