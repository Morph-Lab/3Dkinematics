%-----------Exercise-3.2-------------------
clear all;
syms L1 L2 L3 theta1 theta2 real
%%Option-1
% i ai alphai      di thetai
DH1 = [0  0         0  theta1;...   % Joint 1
      L1 sym(pi)/2 0 theta2;...   % Joint 2
      L3 0         L2  0];          % Joint 3 

%Now we can separate them to DH parameter columns
a = DH1(:,1);
alp = DH1(:,2);
d = DH1(:,3);
th = DH1(:,4);

TN = size(DH1,1); %number of homogeneous transformation matrices
%Finding each transformation matrix using Khalil and Dombre variation method (eq 38)
for i = 1:TN
    T(i).A =  [cos(th(i)) -sin(th(i)) 0 a(i);...
               sin(th(i))*cos(alp(i)) cos(th(i))*cos(alp(i)) -sin(alp(i)) -sin(alp(i))*d(i);...
               sin(th(i))*sin(alp(i)) cos(th(i))*sin(alp(i)) cos(alp(i)) cos(alp(i))*d(i);...
               0 0 0 1];
end

%transformtion matrix for each link
Link1 = T(1).A
Link2 = T(2).A
Link3 = T(3).A

%Now we construct the homogeneous transformation matrix for the tip
Ttip = T(1).A; 
for i = 2:TN
    Ttip = Ttip*T(i).A;
end

Ttip1 = simplify(Ttip) %simplified transformation matrix from tip to base

tipPos_exp1 = Ttip1(1:3,4) %Expression of the Position of the tip
  
%%
%%Option-2
% i ai alphai      di thetai
DH2 = [0  0         0  theta1;...   % Joint 1
      L1 sym(pi)/2 L2 theta2;...   % Joint 2
      L3 0         0  0];          % Joint 3  

 %Now we can separate them to DH parameter columns
a = DH2(:,1);
alp = DH2(:,2);
d = DH2(:,3);
th = DH2(:,4);

TN = size(DH2,1); %number of homogeneous transformation matrices
%Finding each transformation matrix using Khalil and Dombre variation method (eq 38)
for i = 1:TN
    T(i).A =  [cos(th(i)) -sin(th(i)) 0 a(i);...
               sin(th(i))*cos(alp(i)) cos(th(i))*cos(alp(i)) -sin(alp(i)) -sin(alp(i))*d(i);...
               sin(th(i))*sin(alp(i)) cos(th(i))*sin(alp(i)) cos(alp(i)) cos(alp(i))*d(i);...
               0 0 0 1];
end

%transformtion matrix for each link
Link1 = T(1).A
Link2 = T(2).A
Link3 = T(3).A

%Now we construct the homogeneous transformation matrix for the tip
Ttip = T(1).A; 
for i = 2:TN
    Ttip = Ttip*T(i).A;
end

Ttip2 = simplify(Ttip) %simplified transformation matrix from tip to base

tipPos_exp2 = Ttip2(1:3,4) %Expression of the Position of the tip

%Now we can substitute joint angle values to find the tip position and
%orientation

BTtip = vpa(subs(Ttip,[theta1,theta2,L1,L2,L3],[pi/6,pi/6,0.3,0.2,0.3])); %substitute values

tipPos = BTtip([1:3],4) %tip position relative to the base

tipOrient = acosd(double(BTtip(1,1))) %angle between the x axes of last link and first link
%%