%-----------Exercise-3.1-------------------
clear all;
syms l1 l2 theta1 theta2 d2 real

% DH table
%     ai alphai di thetai
DH = [0  0      0 theta1;... % Joint 1
      l1 0      d2 theta2;... % Joint 2
      l2 0      0 0];   % Joint 3  

 %Now we can separate them to DH parameter columns
a = DH(:,1);
alp = DH(:,2);
d = DH(:,3);
th = DH(:,4);

TN = size(DH,1); %number of homogeneous transformation matrices
%Finding each transformation matrix using Khalil and Dombre variation method (eq 38)
for i = 1:TN
    T(i).A =  [cos(th(i)) -sin(th(i)) 0 a(i);...
               sin(th(i))*cos(alp(i)) cos(th(i))*cos(alp(i)) -sin(alp(i)) -sin(alp(i))*d(i);...
               sin(th(i))*sin(alp(i)) cos(th(i))*sin(alp(i)) cos(alp(i)) cos(alp(i))*d(i);...
               0 0 0 1];
end

%Now we construct the homogeneous transformation matrix for the tip with
%respect to the base frame
Ttip = T(1).A; 
for i = 2:TN
    Ttip = Ttip*T(i).A;
end
Ttip = simplify(Ttip) %simplified transformation matrix from tip to base

tipPos_exp=Ttip(1:3,4) %Expression of the Position of the tip

%Now we can substitute joint angle values to find the tip position and
%orientation

BTtip = vpa(subs(Ttip,[theta1,theta2,l1,l2,d2],[pi/6,pi/6,0.2,0.3,0.1])); %substitute values in the transformation matrix

tipPos = BTtip([1:3],4) %tip position relative to the base

tipOrient = acosd(double(BTtip(1,1))) %angle between the x axis of last link and first link 
%%