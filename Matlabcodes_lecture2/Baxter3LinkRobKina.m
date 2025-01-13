%https://groups.google.com/a/rethinkrobotics.com/forum/#!topic/brr-users/5X1-6w-Ja1I
%+---+-----------+-----------+-----------+-----------+                               
%| j |     theta |         d |         a |     alpha |                               
%+---+-----------+-----------+-----------+-----------+                               
%|  1|         q1|  0.2703|    0.069|     -1.571|                               
%|  2|         q2|          0|          0|      1.571|                               
%|  3|         q3|  0.3644|    0.069|     -1.571|                               
%|  4|         q4|          0|          0|      1.571|                               
%|  5|         q5|  0.3743|      0.01|     -1.571|                               
%|  6|         q6|          0|          0|      1.571|                               
%|  7|         q7|  0.2295|          0|            0|                               
%+---+-----------+-----------+-----------+-----------+  
syms q1 q2 q3 q4 q5 q6 q7; %Symbolic joint angle variables
%pi = sym(pi);

%This DH table is for the last kinematic structure of the slides
% column-1, 2, 3 for a, alpha, d
DH = [
    0.069 -1.571  0.2703;...   
    0 1.571  0;...   
    0.069 -1.571 0.3644;...        
    0 1.571 0;...
    0.01 -1.571 0.3743;...
    0 1.571 0;...
    0 0 0.2295];  

TN = length(DH); %Number of frame transformations to be performed

qrange = [];
qrange = [q1;q2;q3;q4;q5;q6;q7]; 

%Transformation matrix (eq 3.6 from page 75-Craig book)
for j=1:TN
    th = qrange(j,1);
    T{j} = [cos(th) -sin(th)*cos(DH(j,2)) sin(th)*sin(DH(j,2)) DH(j,1)*cos(th);...
        sin(th) cos(th)*cos(DH(j,2)) -cos(th)*sin(DH(j,2)) DH(j,1)*sin(th);...
        0 sin(DH(j,2)) cos(DH(j,2)) DH(j,3);...
        0 0 0 1];
end

Tr{1} = T{1}; 
for j = 2:TN
    Tr{j} = Tr{j-1}*T{j};
end
%The above for loop will do the following:
%Tr{2} = Tr{1}*T{2};
%Tr{3} = Tr{2}*T{3};
%Tr{4} = Tr{3}*T{4};
%Tr{5} = Tr{4}*T{5};
%Tr{6} = Tr{5}*T{6};
%Tr{7} = Tr{6}*T{7};

tip = simplify(Tr{TN});
%
tipPos = tip([1:3],4);
%keyboard;
Jtip = jacobian(tipPos,qrange);

%Question-1
%Find the orientation of z-axis of the last link relative to the
%base link
%Question-2
%Compute the Jacobian matrix when all joints have rotated by pi/6, and find the speed
%vector of the tip if all joints are rotated by pi/10 [rad/sec] at this joint configuration.


