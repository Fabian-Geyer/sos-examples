% options
opts.verbose = 1;
opts.conf_interval = [-4 -2];
opts.max_iter = 1000000;
opts.tolerance_abs = 1e-6;
opts.tolerance_rel = 1e-6;

% Indeterminates
x = casos.Indeterminates('x',2 ,1);
z1 = [x(1); x(2)];
z2 = [x(1)^2; x(1)*x(2); x(2)^2];
z3 = [x(1)^3; x(1)^2*x(2); x(1)*x(2)^2; x(2)^3];

% decision variables
t = casos.PS.sym('t');
% P = casos.PS.sym('p', [2 2])
P11 = casos.PS.sym('p11');
P12 = casos.PS.sym('p12');
P22 = casos.PS.sym('p22');
P = [P11 P12; P12 P22]
sos.x = [P11; P12; P22];
opts.Kx = struct('sos', [3]);

% objective
sos.f = t;

% dynamics
A1 = [-4 5; -1 -2];
A2 = 1/4*[3 6 3; 1 2 1];
A3 = 1/8*[-1 0 -9 6; 0 -3 6 -7];
f = A1*z1 + A2*z2 + A3*z3;

% constraints
V = x'*P*x; % lyapunov function
sos.g = [
    t*V - nabla(V, x)*f;
    V-x'*x;
];
opts.Kc = struct('sos', 2);

% solver
S = casos.qcsossol('S','bisection',sos,opts);
sol = S();

