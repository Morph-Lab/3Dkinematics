clear all;%Clear all variables from memory
syms R1 R2 R3 R4 P1 P2 P3 P4 real;%Define symbolid variable to have real numbers

T1 = [R1 P1;0 1];
T2 = [R2 P2;0 1];
T4 = [R4 P4;0 1];
%%
T3 = inv(T1*T2)*T4