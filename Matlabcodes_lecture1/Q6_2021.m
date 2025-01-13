clear all;
clc;
%The given rotation matrix
R3 = [-0.224 -0.836 0.5;...
    -0.774 -0.158 -0.612;...
    0.591 -0.524 -0.612];

angle_x_z = acosd(0.591)
%%
%Euler parameters in the unit quaternion
ep4 = 0.5*sqrt(1 + R3(1,1) + R3(2,2) + R3(3,3));
ep1 = (R3(3,2) - R3(2,3))/(4*ep4)
ep2 = (R3(1,3) - R3(3,1))/(4*ep4)
ep3 = (R3(2,1) - R3(1,2))/(4*ep4)

ang = pi/6;%The given angle of rotation 
c1 = ep1/(sin(ang/2))
c2 = ep2/(sin(ang/2))
c3 = ep3/(sin(ang/2))