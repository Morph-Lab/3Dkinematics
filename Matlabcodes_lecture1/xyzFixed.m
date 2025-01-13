clear all;
syms alpha beta gamma real;

Rz = [cos(alpha) -sin(alpha) 0;... %Use ... to go to the next row. It looks better that way
     sin(alpha) cos(alpha) 0;...
     0 0 1];
 
Ry = [cos(beta) 0 sin(beta);...
    0 1 0;...
    -sin(beta) 0 cos(beta)];

Rx = [1 0 0;...
    0 cos(gamma) -sin(gamma);...
    0 sin(gamma) cos(gamma)];

R = simplify(Rz*Ry*Rx)
Rlatex = latex(R)

