clear all;
clc;
%First Jacobian
J1 = [0.2 0.1 0.5;...
    0.15 0.05 0.01;...
    0.01 0.01 0.6];

%Second Jacobian
J2 = [0.1 0.2 0.5;...
    0.05 0.15 0.01;...
    0.6 0.01 0.01];

%Force vector
f = [10;5;20];

%First torque vector
tau1 = J1'*f

%Second torque vector
tau2 = J2'*f
