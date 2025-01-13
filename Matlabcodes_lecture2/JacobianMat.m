clear all;
syms l1 l2 l3 theta1 theta2 

tip = [l1*cos(theta1)+l2*sin(theta1) + l3*cos(theta1)*cos(theta2);...
    l1*sin(theta1)-l2*cos(theta1) + l3*cos(theta2)*sin(theta1);...
    l3*sin(theta2)];

J = jacobian(tip,[theta1,theta2]) %Jacobian matrix 