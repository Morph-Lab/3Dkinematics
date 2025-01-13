clear all;%Clear all variables from memory
syms alpha beta gamma real;%Define symbolid variable to have real numbers

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
close all;
clc;
%Axes of base frame
x0 = [1 0 0]';
y0 = [0 1 0]';
z0 = [0 0 1]';

frame0.x = x0;
frame0.y = y0;
frame0.z = z0;
%%
%Rotation around the z-axis
angles.alpha = pi/6;%z
angles.beta = 0;%y
angles.gamma = 0;%x

labels = {'x_i','y_i','z_i'};
rotationtype = 'individual';
para.trans = 0.2;%Transparency of the arrow
para.width = 0.02;%Width of arrow
%Call the rotate3D function in the same folder
lastframe = rotate3D(frame0,angles,Rz,labels,rotationtype,para);
hold off;
%%
%Rotation around the y-axis
angles.alpha = 0;%z
angles.beta = pi/6;%y
angles.gamma = 0;%x

labels = {'x_i','y_i','z_i'};
rotationtype = 'individual';
para.trans = 0.2;
para.width = 0.02;
lastframe = rotate3D(frame0,angles,Ry,labels,rotationtype,para);
hold off;
%%
clc;
%Rotation around the x-axis
angles.alpha = 0;%z
angles.beta = 0;%y
angles.gamma = pi/6;%x

labels = {'x_i','y_i','z_i'};
rotationtype = 'individual';
para.trans = 0.2;
para.width = 0.02;
lastframe = rotate3D(frame0,angles,Rx,labels,rotationtype,para);
hold off;