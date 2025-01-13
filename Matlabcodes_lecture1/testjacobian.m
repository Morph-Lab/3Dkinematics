syms a b c alpha theta real;

P = [a*cos(alpha)+b*cos(alpha + theta);...
    a*sin(alpha)+b*sin(alpha + theta);...
    c];

J = jacobian(P,[alpha theta]);

F = [2 1 3]';

tau = J'*F