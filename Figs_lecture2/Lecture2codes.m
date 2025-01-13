%-----------Exercise-3.1-------------------
clear all;
syms L1 L2 theta1 theta2 theta3 

% DH table
%     ai alphai di thetai
DH = [0  0      0 theta1;... % Joint 1
      L1 0      0 theta2;... % Joint 2
      L2 0      0 theta3];   % Joint 3  

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

BTtip = vpa(subs(Ttip,[theta1,theta2,theta3,L1,L2],[pi/6,pi/6,0,0.2,0.3])); %substitute values in the transformation matrix

tipPos = BTtip([1:3],4) %tip position relative to the base

tipOrient = acosd(double(BTtip(1,1))) %angle between the x axis of last link and first link 
%%
%-----------Exercise-3.2-------------------
clear all;
syms L1 L2 L3 theta1 theta2

% i ai alphai      di thetai
DH = [0  0         0  theta1;...   % Joint 1
      L1 sym(pi)/2 L2 theta2;...   % Joint 2
      L3 0         0  0];          % Joint 3  

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

%transformtion matrix for each link
Link1 = T(1).A
Link2 = T(2).A
Link3 = T(3).A

%Now we construct the homogeneous transformation matrix for the tip
Ttip = T(1).A; 
for i = 2:TN
    Ttip = Ttip*T(i).A;
end

Ttip = simplify(Ttip) %simplified transformation matrix from tip to base

tipPos_exp=Ttip(1:3,4) %Expression of the Position of the tip

%Now we can substitute joint angle values to find the tip position and
%orientation

BTtip = vpa(subs(Ttip,[theta1,theta2,L1,L2,L3],[pi/6,pi/6,0.3,0.2,0.3])); %substitute values

tipPos = BTtip([1:3],4) %tip position relative to the base

tipOrient = acosd(double(BTtip(1,1))) %angle between the x axes of last link and first link
%%
%-----------Exercise-3.3-------------------
clear all;
syms L0 L1 L2 theta1 theta2 theta3

%     ai alphai    di thetai
DH = [0     0      L0 theta1;...   % Joint 1
      0 -sym(pi)/2 L1 theta2;...   % Joint 2
      0 sym(pi)/2  L2 theta3];     % Joint 3  

 %Now we can separate them to DH parameter columns
a = DH(:,1);
alp = DH(:,2);
d = DH(:,3);
th = DH(:,4);

TN = size(DH,1);
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

Ttip = simplify(Ttip) %simplified transformation matrix from tip to base

%%           Review for tutorial 
%---------------   Example 1  -------------------

%Now we can substitute joint angle values to find the tip position and
%orientation

tipPos_exp = Ttip([1:3],4) %tip position as a function

J = jacobian(tipPos_exp,[theta1,theta2,theta3]) %Jacobian matrix 

BTtip = vpa(subs(Ttip,[theta1,theta2,theta3,L0,L1,L2],[pi/6,pi/6,pi/6,0.3,0.2,0.3])); %substitute values

tipPos = BTtip([1:3],4) %tip position relative to the base

tipOrient = acosd(double(BTtip(1,1))) %angle between the x axes of last link and first link

%%            Past paper
%%%%%%%%%% Q2. Angular and end-point speeds %%%%%%%%%%%%%%%%%%%
clear all 
syms theta alp a d theta1 theta2 theta3 L1 L2 L3
 
 Tij=[cos(theta)         ,-sin(theta)         ,         0,           a;
       sin(theta)*cos(alp), cos(theta)*cos(alp), -sin(alp), -sin(alp)*d;
       sin(theta)*sin(alp), cos(theta)*sin(alp),  cos(alp), cos(alp)*d;
       0,               0,                  0,          1];
 % DH parameters
 DHparam =[0    0   L1  theta1;... % Joint 1
           0  -pi/2 0   -theta2;... % Joint 2
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
 theta2=pi/3;
 theta3=pi/2;
 
 % substitute values
 
 BTtip = vpa(subs(Ttip))
 
 tipPos = BTtip([1:3],4) %tip position relative to the base

 tipOrient = acosd(double(BTtip(2,2))) %angle between the y axes of last link and first link


%%            Robotic Hoof
%%%%%%%%%% Excercise 3.4 %%%%%%%%%%%%%%%%%%%
clear all 
syms theta alp a d theta1 theta2 theta3 L1 L2 L3
 
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
 
 %%            Human Leg 
 %%%%%%%%%%%% Excercise 3.5 %%%%%%%%%%%%%%%%%%%

clear all 
syms theta alp a d theta1 theta2 theta3 theta4 theta5 L1 L2 L3
 
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
 
 %%        The thumb and the foldable palm 
 %%%%%%%%%%%% Excercise 3.6 %%%%%%%%%%%%%%%%%%%
clear all
syms gam l1 l2 l3 l4 l5 l6 theta1 theta2 theta3 theta4 theta5 theta6 theta7;
syms thumbtip thumbmcp;
%pi = sym(pi);

%Lengths in mm
l1 = 25;
l2 = 25; 
l3 = 32;
l4 = 20;
l5 = 30;
l6 = 20;
gam = sym(pi)/3;

% i ai alphai di thetai
DH = [0 0          0  sym(pi)+gam;...
     l1 sym(pi)/2  l2 sym(pi)/2+theta1;...   % Palm (flexion/extension)  -65,-125
     0  sym(pi)/2  l3 theta2;...   % TM joint (flexion/extension)-10,60
     0  -sym(pi)/2 0  sym(pi)/2+theta3;...        % TM joint (pronation/supination) -160,-120
     0  sym(pi)/2  0  3*sym(pi)/2+theta4;...       % TM joint (adduction/abduction) -50 0
     l4 sym(pi)/2  0  theta5;...        % MCP joint (flexion/extension)0 60
     0  -sym(pi)/2 0  theta6;...  % MCP joint (adduction/abduction)  0,-40
     l5 sym(pi)/2  0  theta7;...
     l6 0 0 0];  % IP joint (flexion/extension)0,50

%Now we can separate them to DH parameter columns
a = DH(:,1);
alp = DH(:,2);
d = DH(:,3);
th = DH(:,4);

TN = length(DH);
%Transformation matrix (eq 38)
for i = 1:length(DH)
    T(i).A =  [cos(th(i)) -sin(th(i)) 0 a(i);...
               sin(th(i))*cos(alp(i)) cos(th(i))*cos(alp(i)) -sin(alp(i)) -sin(alp(i))*d(i);...
               sin(th(i))*sin(alp(i)) cos(th(i))*sin(alp(i)) cos(alp(i)) cos(alp(i))*d(i);...
               0 0 0 1];
end
%%

%Now we construct the homogeneous transformation matrix for the tip
Ttip = T(1).A; 
for i = 2:length(DH)
    Ttip = Ttip*T(i).A;
end

Ttip = vpa(Ttip); %Use variable precision arithmetic to substitute the values in the symbolic equation
Ttip = simplify(Ttip)
%%
%Now we construct the homogeneous transformation matrix for the MCP joint 6
%joint
Tmcp = T(1).A; 
for i = 2:7% it is up to 7 because of the initial referencial frame 0'
    Tmcp = Tmcp*T(i).A;
end

Tmcp = vpa(Tmcp); %Use variable precision arithmetic to substitute the values in the symbolic equation
Tmcp = simplify(Tmcp)
%%
%
thumbtip = Ttip([1:3],4);
%keyboard;
thumbmcp = Tmcp([1:3],4);
Thrange = [theta1, theta2, theta3, theta4, theta5, theta6, theta7];
Jtip = jacobian(thumbtip,Thrange)
Jmcp = jacobian(thumbmcp,Thrange)

%%
Th_tip = vpa(subs(thumbtip,Thrange,[0, 0, 0, 0, 0, 0, 0]))
Th_mcp = vpa(subs(thumbmcp,Thrange,[0, 0, 0, 0, 0, 0, 0]))
%% %Finding the position of the thimbtip when joint angles are:
%Thrange = [pi/10, pi/6, 0, -pi/6, pi/3, pi/10, pi/3];
Th_tip = vpa(subs(thumbtip,Thrange,[pi/10, pi/6, 0, pi/6, pi/3, pi/10, pi/3]))
Th_mcp = vpa(subs(thumbmcp,Thrange,[pi/10, pi/6, 0, pi/6, pi/3, pi/10, pi/3]))
