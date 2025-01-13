clear all;%Clear all variables from memory
syms th1 th2 L1 L2 real;
%%
p = [L1*cos(th1) + L2*cos(th1+th2);...
    L1*sin(th1) + L2*sin(th1+th2);...
    0]
%%
angles = [th1 th2];

J = jacobian(p,angles);

f = [1;1;1];

tau = J'*f
