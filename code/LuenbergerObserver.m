%Luenberger Observer
M = 1000;
m1 = 100;
m2 = 100; 
l1 = 20;
l2 = 10;
g = 9.81;
A_org = [0 1 0 0 0 0; 
    0 0 -(m1*g)/M 0 -(m2*g)/M 0;
    0 0 0 1 0 0;
    0 0 -(m1*g + M*g)/(l1*M) 0 -(m2*g)/(l1*M) 0;
    0 0 0 0 0 1;
    0 0 -(m1*g)/(l2*M) 0 -(m2*g + M*g)/(l2*M) 0;];

B_org = [0;
    1/M;
    0;
    1/(M*l1);
    0;
    1/(M*l2);];

%For observer x
C_org = [1 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0;];

%For observer x theta2
% C = [1 0 0 0 0 0;
%     0 0 0 0 0 0;
%     0 0 0 0 1 0;];

%For observer x theta1 theta2
% C = [1 0 0 0 0 0;
%     0 0 1 0 0 0;
%     0 0 0 0 1 0;];

D_org = 0;

Q = [1000 0 0 0 0 0;
    0 1000 0 0 0 0;
    0 0 200 0 0 0;
    0 0 0 100 0 0;
    0 0 0 0 200 0;
    0 0 0 0 0 1000];

R = 1;

[K,S,E] = lqr(A_org, B_org, Q, R);
disp(K);

%Updated
Al = (A_org-B_org*K);

system = ss(Al,B_org,C_org,D_org);


e = eig(Al);

p = 8*(e); %Multiplier between 2 and 10, both inclusive
L = place(A_org', C_org', p)';
A_l = A_org - L*C_org;
system_updated = ss(A_l,B_org,C_org,D_org);

t = 0:0.1:1000;
u = 1*ones(size(t));
[y,t,x]=lsim(system_updated,u,t);
yyaxis left
plot(t,y(:,1));
hold on;
yyaxis left
plot(t,y(:,2), 'g');
hold on;
yyaxis left
plot(t,y(:,3), 'r');
hold on;
legend("cart position", "pendulum1", "pendulum2"); 




