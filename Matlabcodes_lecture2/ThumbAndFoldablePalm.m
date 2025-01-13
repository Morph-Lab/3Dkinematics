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
