%%            Robotic Hoof
%%%%%%%%%% Excercise 3.4 %%%%%%%%%%%%%%%%%%%
clear all 
syms theta alp a d theta1 theta2 theta3 L1 L2 L3 real
 
 Tij=[cos(theta)         ,          -sin(theta),         0,           a;
       sin(theta)*cos(alp), cos(theta)*cos(alp), -sin(alp), -sin(alp)*d;
       sin(theta)*sin(alp), cos(theta)*sin(alp),  cos(alp), cos(alp)*d;
       0,               0,                  0,          1];
  %hoof DH parameters
 DHparam =[0  0     0    theta1;... % Joint 1 Fetlock joint
           0  pi/2 L1+L2 theta2;... % Joint 2 Pastern joint
           0  pi/2  0    theta3;... % Joint 3 Coffin joint
           L3  0    0     0];       % Joint 4

[njoints,~]=size(DHparam); 
%Finding each transformation matrix using Khalil and Dombre variation method (eq 38)
 for n=1:njoints
     T(n).matrix=subs(Tij, [a alp d theta], DHparam(n,:));
 end
%Now we construct the homogeneous transformation matrix
 Ttip=T(1).matrix;
  for n=2:njoints
     Ttip=Ttip*T(n).matrix;
  end
 Ttip = simplify(Ttip) %simplified transformation matrix
 
 tipPos = Ttip(1:3,4) %tip position relative to base frame at the Fetlock joint
 
 J = jacobian(tipPos,[theta1 theta2 theta3])
 