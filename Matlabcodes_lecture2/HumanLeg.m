 %%            Human Leg 
 %%%%%%%%%%%% Excercise 3.5 %%%%%%%%%%%%%%%%%%%

clear all 
syms theta alp a d theta1 theta2 theta3 theta4 theta5 L1 L2 L3 real
 
 Tij=[cos(theta)         ,-sin(theta)         ,         0,           a;
       sin(theta)*cos(alp), cos(theta)*cos(alp), -sin(alp), -sin(alp)*d;
       sin(theta)*sin(alp), cos(theta)*sin(alp),  cos(alp), cos(alp)*d;
       0,               0,                  0,          1];
  
 DHparam =[0   0      0    theta1;... % Joint 1
           0   -pi/2  0   -theta2;... % Joint 2
           0   -pi/2  0   -theta3;... % Joint 3
           L1   0     0    theta4;... % Joint 4
           L2   0     0    theta5;... % Joint 5
           L3   0     0    0];        % Joint 6
[njoints,~]=size(DHparam); 
 for n=1:njoints
     T(n).matrix=subs(Tij, [a alp d theta], DHparam(n,:));
 end
%Now we construct the homogeneous transformation matrix
 Ttoe=T(1).matrix;
  for n=2:njoints
     Ttoe=Ttoe*T(n).matrix;
  end
 Ttoe = simplify(Ttoe) %simplified transformation matrix
 
 toePos = Ttoe(1:3,4) %toe position relative to base frame at the hip
 toeJ = jacobian(toePos,[theta1 theta2 theta3])
 