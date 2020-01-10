%LQR Controller
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

C = [1 0 0 0 0 0;
    0 0 1 0 0 0;
    0 0 0 0 1 0;];

D = 0;

Q = [1000 0 0 0 0 0;
    0 1000 0 0 0 0;
    0 0 200 0 0 0;
    0 0 0 100 0 0;
    0 0 0 0 200 0;
    0 0 0 0 0 1000];

R = 0.01;

[K,S,E] = lqr(A, B, Q, R);
disp(K);

%Updated
A = (A-B*K);

system = ss(A,B,C,D);


t = 0:0.1:500;
u = 1000*ones(size(t));
[y,t,x]=lsim(system,u,t);

yyaxis left
plot(t,y(:,1));
yyaxis right
plot(t, [y(:,2), y(:,3)]);
legend('cart', 'pendulum1', 'pendulum2');

%Lyapunov indirect method
e = eig(A);
disp(e);
disp("Since all the eigen values have negative real part, the system is locally stable");

