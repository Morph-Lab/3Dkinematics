%Tutorial-1
%------Question-2

disp('a)')

A = [1 0 0;0 0 -1;0 1 0]; 
B = [0.7071 0 0.7071;0 1 0;-0.7071 0 0.7071]; 
C = [0.866 -0.5 0;0.5 0.866 0;0 0 1]; 

disp([det(A) det(B) det(C)])

disp('b)')

A = [1 0 0;0 0 -1;0 -1 0]; 
B = [0.7071 0 0.7071;0 1 0;0 0 0.7071]; 
C = [0.866 0 0;0.5 0.866 0;0 0 1]; 

disp([det(A) det(B) det(C)])

disp('c)')

A = [1 0 0;0 0 -1;0 -1 0]; 
B = [-0.7071 0 0.7071;0 1 0;-0.7071 0 0.7071]; 
C = [0.866 0.5 0;0.5 0.866 0;0 0 1]; 

disp([det(A) det(B) det(C)])

disp('d)')

A = [1 0 0;0 0 -1;0 1 0]; 
B = [-0.7071 0 0.7071;0 1 0;1 0 0.7071]; 
C = [0.866 -0.5 0;0.5 -0.866 0;0 0 1]; 

disp([det(A) det(B) det(C)])

%------Question-3

% d) correct

%------Question-4

% a) correct
%%
%------Question-5

clear all;
syms L1 L2 theta1 theta2 theta3 real

P = [L1*cos(theta1)+L2*cos(theta1 + theta2);...
    L1*sin(theta1)+L2*sin(theta1 + theta2);...
    0];
th = [theta1;theta2;theta3];

J = jacobian(P,th)



% a) is correct
%%
%--------Question-6

f = [1;...
    1;...
    1];

tau = J'*f

% b) is correct

%%
%--------Question-7
%L2*cos(theta1 + theta2) - L2*sin(theta1 + theta2) = 0
% tan(theta1+theta2) = 1;

% d) is correct
%%
%--------Question-8

% b) is correct

%%
%--------Question-9
% b) is correct

%%
%--------Question-10







