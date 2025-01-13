clear all;
clc;
syms l1 l2 theta1 theta2 real;

pos = [l1*cos(theta1)+l2*cos(theta1+theta2);...
    l1*sin(theta1) + l2*sin(theta1+theta2);...
    0];

J = jacobian(pos,[theta1 theta2]);

f = [1;1;1];

tau = J'*f
