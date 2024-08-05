%% System

% Define System matrices
A_1 = [-4 5;
      -1 -2];
A_2 = [3 6 3;
      1 2 1] * 1/4;
A_3 = [-1 0 -9 6;
      0 -3 6 -7] * 1/8;

% system states
x = casos.Indeterminates('x', 2, 1);
% x = casos.PS.sym('x', 2);

% create the system monomials:
z_1 = monomials(x, [1:1]);
z_2 = monomials(x, 2:2);
z_3 = monomials(x, 3:3);

z1 = casos.PS.sym('x', z_1)

% define f(x)
f = A_1*z_1 + A_2*z_2 + A_3*z_3;

% define Lyapunov function with decision variables
V = casos.PS.sym('q', monomials(x, 1:1), 'gram');

% define bilinear decision variable for bisection
t = casos.PS.sym('t');

% Vdot
Vdot = nabla(V, x)*f;

%% Solve

% Define quasiconvex problem
qcsos = struct('f', t, 'x', V, 'g', [V-x'*x; t*V-Vdot]);

% settings
% states cone
opts.Kx.l = 0;
opts.Kx.s = 1;

% constraint cone
opts.Kc.s = 2;


% ignore infeasibility
opts.error_on_fail = false;

% solve by bisection
S = casos.qcsossol('S','bisection',qcsos, opts);

% evaluate
sol = S();

fprintf('Minimum is %f.\n', double(sol.f));

lyap_str = str(sol.x);
fprintf('Lyapunov equation is: %s', lyap_str{1});