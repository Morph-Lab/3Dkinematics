clear all;%Clear all variables from memory
syms alpha beta gamma real;%Define symbolic variable to have real numbers
%%
%Rotation by alpha around z axis
Rz = [cos(alpha) -sin(alpha) 0;... %Use ... to go to the next row. It looks better that way
    sin(alpha) cos(alpha) 0;...
    0 0 1];
%Rotation by beta around y axis
Ry = [cos(beta) 0 sin(beta);...
    0 1 0;...
    -sin(beta) 0 cos(beta)];
%Rotation by gamma around x axis
Rx = [1 0 0;...
    0 cos(gamma) -sin(gamma);...
    0 sin(gamma) cos(gamma)];
%%
%First do a X-Y-Z fixed angle rotation to create a target axis frame
Rxyzfixed = simplify(Rz*Ry*Rx);
%%
%Then use Z-Y-X Euler rotation to rotate the base frame to the traget frame
%in 3 successive rotations around moving frames.
% R(z,y,x) = 0^R_1(alpha) * 1^R_2(beta) * 2^R_t(gamma)
Rzyxmoving = simplify(Rz*Ry*Rx);%Numerically same as Rxyzfixed, but I keep them separate
Rlatex = latex(Rzyxmoving);%This is to generate the latext code for slides
%%
close all;%Close all figures
clc;%Clear screen
%Define unit vectors of axes
x0 = [1 0 0]';
y0 = [0 1 0]';
z0 = [0 0 1]';
%Assign them as fields in frame0 structure
frame0.x = x0;
frame0.y = y0;
frame0.z = z0;
%Angles of rotation matrix
angles.alpha = pi/6;%z
angles.beta = pi/3;%y
angles.gamma = pi/4;%x
%%
labels = {'x_t','y_t','z_t'};%These labels will be used in the plot below
rotationtype = 'initialize';% I use several cases of plotting below. 
%Initialise is to display the base frame and the target frame
para.trans = 0.2; %Transparency of the arrows to show the frame axes
para.width = 0.02; %Width of the arrows in the frame
%Now call the 3D rotation function
%%
lastframe = rotate3D(frame0,angles,Rxyzfixed,labels,rotationtype,para);
%lastframe is the coordinates of the last frame after doing multiple steps
%of rotating the axes
hold on;
%%
frame0.x = x0;
frame0.y = y0;
frame0.z = z0;
para.trans = 0.1;
para.width = 0.01;
%Rotation around z axis: R_z(alpha)
rotationtype = 'other';
labels = {' ',' ',' '};
%Rotate in 5 steps to show the intermediate steps of rotating axes
for i = 1:5
    angles.alpha = i*(pi/6)/5;%z
    angles.beta = 0;%y
    angles.gamma = 0;%x
    if i == 5
        labels = {'x_1','y_1','z_1'};
    end
    trans = 0.1;
    lastframe1 = rotate3D(frame0,angles,Rzyxmoving,labels,rotationtype,para);

    pause(1);
    drawnow;
end
%%
frame0.x = x0;
frame0.y = y0;
frame0.z = z0;
%Rotation around y axis: 2^R_1(beta)
rotationtype = 'other';
labels = {' ',' ',' '};
para.trans = 0.1;
para.width = 0.01;
for i = 1:5
    angles.alpha = pi/6;%z
    angles.beta = i*(pi/3)/5;%y
    angles.gamma = 0;%x
    if i == 5
        labels = {'x_2','y_2','z_2'};
    end
    lastframe2 = rotate3D(frame0,angles,Rzyxmoving,labels,rotationtype,para);

    pause(1);
    drawnow;
end
%%
frame0.x = x0;
frame0.y = y0;
frame0.z = z0;
%Rotation around x axis: t^R_2(gamma)
rotationtype = 'other';
labels = {' ',' ',' '};
para.trans = 0.1;
para.width = 0.01;
for i = 1:5
    angles.alpha = pi/6;%z
    angles.beta = pi/3;%y
    angles.gamma = i*(pi/4)/5;%x
    if i == 5
        labels = {'x_t','y_t','z_t'};
    end
    trans = 0.1;
    lastframe3 = rotate3D(frame0,angles,Rzyxmoving,labels,rotationtype,para);
 
    pause(1);
    drawnow;
end



