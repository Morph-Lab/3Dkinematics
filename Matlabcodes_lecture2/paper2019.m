clc;
clear all;
syms l1 l2 l3 l4 d1 d2 d3 theta1 theta2 theta3;

%Given the D-H table
%i a_i alpha_i d_i theta_i
%1 0     0      0   theta1
%2 l1    0      d2  theta2
%3 l2    0      0    0

%The corresponding homogeneous transformation matrices for each row of DH
%table are given by

%i = 1
T1 = [cos(theta2) -sin(theta2) 0 0;... %... is used to start a new row
       0 0 1 0;...
       sin(theta2) cos(theta2) 0 0;...
       0 0 0 1];

%i = 2
T2 = [cos(theta3) -sin(theta3) 0 l1;...
       sin(theta3) cos(theta3) 0 0;...
       0 0 1 0;...
       0 0 0 1];
   


%i = 3
T3 = [1 0 0 l2;...
       0 1 0 0;...
       0 0 1 0;...
       0 0 0 1];
   
%The compound transformation matrix
disp('Compound transformation matrix');
T = T1 * T2 * T3

disp('Simplified compound transformation matrix');
Ts = simplify(T)

%Position
p = Ts([1:3],end);

J = jacobian(p,[theta2 theta3])
