%%            Past paper
%%%%%%%%%% Q2. Angular and end-point speeds %%%%%%%%%%%%%%%%%%%
clear all 
syms theta alp a d theta1 theta2 theta3 L1 L2 L3 L4 real
 
 Tij=[cos(theta)         ,-sin(theta)         ,         0,           a;
       sin(theta)*cos(alp), cos(theta)*cos(alp), -sin(alp), -sin(alp)*d;
       sin(theta)*sin(alp), cos(theta)*sin(alp),  cos(alp), cos(alp)*d;
       0,               0,                  0,          1];
 % DH parameters
 DHparam =[0    0   L1  theta1;... % Joint 1
           L1  -pi/2 0   theta2;... % Joint 2
           L2  0    0    theta3;... % Joint 3
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
  
 tipPos_exp = Ttip(1:3,4); 
 tipJ = jacobian(tipPos_exp,[theta1 theta2 theta3]);
 L1=0.5;
 L2=0.25;
 L3=1;
 theta1=pi/4;
 theta2=-pi/3;
 theta3=pi/2;
 
 % substitute values
 
 BTtip = vpa(subs(Ttip))
 
 tipPos = BTtip([1:3],4) %tip position relative to the base

 tipOrient = acosd(double(BTtip(2,2))) %angle between the x axes of base and z axis of the last link and first link


