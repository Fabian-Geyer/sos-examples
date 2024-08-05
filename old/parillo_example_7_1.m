% define x_1, x_2 
x = casos.PS('x', 2, 1);

% define bound
g = casos.PS.sym('g');

% polynomial f
f = 4*x(1)^2 - 21/10*x(1)^4 + 1/3*x(1)^6 +x(1)*x(2) -4*x(2)^2 +4*x(2)^4;

% define sos problem
sos = struct('x', g, 'f', g , 'g', f+g);

% constraint is scalar SOS cone, i.e. g is 1-dimensional
opts = struct('Kc',struct('sos',1));


% solve by relaxation to SDP
S = casos.sossol('S','mosek',sos,opts);
% evaluate
sol = S();

% Note: gamma = -g;
fprintf('Minimum is %g.\n', full(-sol.f))
