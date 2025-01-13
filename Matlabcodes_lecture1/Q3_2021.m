syms q1 q2 q3 real; %Symbolic joint angle variables
syms l1 l2 l3 real;
%This DH table is for the last kinematic structure of the slides
% column-1, 2, 3 for 
%|a | d |alpha |
DH = [
    l1  0  pi/4;...   
    0  l2  pi/2;...   
    l3  0 0];  

TN = length(DH); %Number of frame transformations to be performed

qrange = [q1;q2;q3]; %Joint angle vector

%Transformation matrix
%[            cos(th),           -sin(th),           0,             a]
%[ cos(alpha)*sin(th), cos(alpha)*cos(th), -sin(alpha), -d*sin(alpha)]
%[ sin(alpha)*sin(th), sin(alpha)*cos(th),  cos(alpha),  d*cos(alpha)]
% [                  0,                  0,           0,             1]

%Transformation matrix (See lecture notes)
for j=1:TN
    th = qrange(j,1); %Pick each joint angle
    T{j} = [cos(th) -sin(th) 0 DH(j,1);...
        sin(th)*cos(DH(j,3)) cos(th)*cos(DH(j,3)) -sin(DH(j,3)) -DH(j,2)*sin(DH(j,3));...
        sin(th)*sin(DH(j,3)) cos(th)*sin(DH(j,3)) cos(DH(j,3)) DH(j,2)*cos(DH(j,3));...
        0 0 0 1];
end

Tr3 = vpa(simplify(T{1}*T{2}*T{3}));
Tr2 = vpa(simplify(T{1}*T{2}));
Tr1 = vpa(simplify(T{1}));

Tr1

format bank;
J3 = jacobian(Tr3([1:3],end),[q1,q2,q3])
latex(J3);
