clear all;
syms alpha beta gamma real;

%Roll - gamma
%Yaw - alpha
%Pitch - beta


Rz = [cos(alpha) -sin(alpha) 0;...
     sin(alpha) cos(alpha) 0;...
     0 0 1];
 
Ry = [cos(beta) 0 sin(beta);...
    0 1 0;...
    -sin(beta) 0 cos(beta)];

Rx = [1 0 0;...
    0 cos(gamma) -sin(gamma);...
    0 sin(gamma) cos(gamma)];

R = simplify(Rz*Ry*Rx)
%%
gamma = pi/2;
alpha = pi/3;
beta = pi/12;

vpa(subs(R))

%Rlatex = latex(R)