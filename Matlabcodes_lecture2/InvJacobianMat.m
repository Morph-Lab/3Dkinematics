clear all;
syms l1 l2 l3 theta1 theta2 real

tip = [l1*cos(theta1)+l2*sin(theta1) + l3*cos(theta1)*cos(theta2);...
    l1*sin(theta1)-l2*cos(theta1) + l3*cos(theta2)*sin(theta1);...
    l3*sin(theta2)];

J = jacobian(tip,[theta1,theta2]) %Jacobian matrix 

Jin = simplify(pinv(J))

%Jinlatex = latex(Jin)
size(Jin)
%%
size(Jin)
l1 = 1; l2 = 0.5; l3 = 1;
theta1 = [-pi:pi/100:pi];
theta2 = [-pi:pi/100:pi];
J11 = vpa(eval(Jin(1,1)));
J12 = vpa(eval(Jin(1,2)));
J13 = vpa(eval(Jin(1,3)));

J21 = vpa(eval(Jin(2,1)));
J22 = vpa(eval(Jin(2,2)));
J23 = vpa(eval(Jin(2,3)));

subplot(2,3,1)
plot(theta1,J11,'o');
xlabel('\theta_1, \theta_2 [rad]');
ylabel('(1,1) element of J^{+}');

subplot(2,3,2)
plot(theta1,J12,'o');
xlabel('\theta_1, \theta_2 [rad]');
ylabel('(1,2) element of J^{+}');

subplot(2,3,3)
plot(theta1,J13,'o');
xlabel('\theta_1, \theta_2 [rad]');
ylabel('(1,3) element of J^{+}');

subplot(2,3,4)
plot(theta1,J21,'o');
xlabel('\theta_1, \theta_2 [rad]');
ylabel('(2,1) element of J^{+}');

subplot(2,3,5)
plot(theta1,J22,'o');
xlabel('\theta_1, \theta_2 [rad]');
ylabel('(2,2) element of J^{+}');

subplot(2,3,6)
plot(theta1,J23,'o');
xlabel('\theta_1, \theta_2 [rad]');
ylabel('(2,3) element of J^{+}');