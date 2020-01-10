%LQG Controller
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

C = [1 0 0 0 0 0;];
D = 0;

Q = [100 0 0 0 0 0;
    0 1000 0 0 0 0;
    0 0 2000 0 0 0;
    0 0 0 1000 0 0;
    0 0 0 0 20000 0;
    0 0 0 0 0 1000];

R = 1;
K = lqr(A,B,Q,R);
sys_kalman = ss(A, [B B], C, D);
[kest, L, P] = kalman(sys_kalman, 0.1 * eye(1), 1, [], 1, 1);

Ac = [A-B*K B*K;zeros(size(A)) A-L*C];
Bc = zeros(12,1);
Cc = [C zeros(size(C))];

sys_lqg = ss(Ac, Bc, Cc, D);

x0 = [ 3 ; 0 ; 0.1 ; 0 ;0.4 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0]
t = 0:0.1:1000;
u = zeros(size(t));
[y,t,x] = lsim(sys_lqg,u,t,x0);

plot(t,y(:,1));


