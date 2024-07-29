x = casos.Indeterminates('x');
y = casos.Indeterminates('y');

F = 2*x^4 + 2*x^3*y -x^2*y^2 + 5*y^4;

% using lower bound
g = casos.PS.sym('g');

% define SOS problem:
sos = struct('f', g , 'x', g, 'g', F+g);

opts = struct('Kc', struct('sos', 1))

% solve
S = casos.sossol('S','sedumi',sos,opts);
% evaluate
sol = S();

fprintf('Minimum is %g.\n', full(sol.f))