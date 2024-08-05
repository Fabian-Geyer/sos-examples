%% system

% system states
x = casos.PS('x', 2, 1);

% system equation
f = [-x(2);
    x(1)+ ( x(1)^2 - 1 ) * x(2)];

% matrix P s.t. V(x) = x^T*P*x
P = [1.5 -0.5;
    -0.5 1];
% Lyapunov Candidate
V = x'*P*x

% Time derivative of V
Vdot = nabla(V, x) * f

% monomial vector
z = monomials(x, 1:2)
% according decision variables
s = casos.PS.sym('q', z, 'gram')

% bilinear decision variable
g = casos.PS.sym('g')

% helper for negativity
l = 1e-006*x'*x

%% solve bisection (high level)

% define quasiconvex SOS problem
qcsos = struct('x',s,'f',-g,'g',s*(V-g)-Vdot-l);

% settings
% states + constraint are SOS cones
opts.Kx = struct('sos', 1);
opts.Kc = struct('sos', 1);

% ignore infeasibility
opts.error_on_fail = false;

% solve by bisection
S = casos.qcsossol('S','bisection',qcsos,opts);
% evaluate
sol = S();

fprintf('Minimum is %g.\n', full(sol.f))
