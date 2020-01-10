%Observability
M = 1000;
m1 = 100;
m2 = 100; 
l1 = 20;
l2 = 10;
g = 9.81;
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

%x
C1 = [1 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0;];

%theta1 theta2
C2 = [0 0 0 0 0 0;
    0 0 1 0 0 0;
    0 0 0 0 1 0;];

%x theta2
C3 = [1 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 1 0;];

%x theta1 theta2
C4 = [1 0 0 0 0 0;
    0 0 1 0 0 0;
    0 0 0 0 1 0;];

ob1 = obsv(A,C1);
if rank(ob1) == 6
    disp("System is observable");
else
    disp("System is not observable");
end

ob2 = obsv(A,C2);
if rank(ob2) == 6
    disp("System is observable");
else
    disp("System is not observable");
end

ob3 = obsv(A,C3);
if rank(ob3) == 6
    disp("System is observable");
else
    disp("System is not observable");
end

ob4 = obsv(A,C4);
if rank(ob4) == 6
    disp("System is observable");
else
    disp("System is not observable");
end