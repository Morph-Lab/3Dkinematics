clear all;
syms alpha theta a b;

Rx = [1 0 0;...
    0 cos(alpha) -sin(alpha);...
    0 sin(alpha) cos(alpha)];

Px = [a;0;0];

Ry = [cos(theta) 0 -sin(theta);...
    0 1 0;...
     sin(theta) 0 cos(theta)];
 
Py = [0;b;0];

S1 = [Rx Px;0 0 0 1];
S2 = [Ry Py;0 0 0 1];

%Correct
Tc = simplify(S2*S1)

%Wrong
Tw = simplify(S1*S2)