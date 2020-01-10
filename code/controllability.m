syms M m1 m2 l1 l2 g F;
% m1 = m2;
% M = m2;
l1 = l2;
A = [0 1 0 0 0 0; 
    0 0 -(m1*g)/M 0 -(m2*g)/M 0;
    0 0 0 1 0 0;
    0 0 -(m1*g + M*g)/(l1*M) 0 -(m2*g)/(l1*M) 0;
    0 0 0 0 0 1;
    0 0 -(m1*g)/(l2*M) 0 -(m2*g + M*g)/(l2*M) 0;];

B = [0;
    1/M;
    0;
    1/(M*l1);
    0;
    1/(M*l2);];

C = [B A*B A^2*B A^3*B A^4*B A^5*B];
rank(C);
disp(rank(C));

