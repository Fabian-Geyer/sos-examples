% Polynomial Feasibility Problem

% indeterminate variales
x = casos.PS('x_1','x_2');

% polynomial
f = 2*x(1)^4 + 2*x(1)^3*x(2) - x(1)^2*x(2)^2 + 5*x(2)^4;

% scalar decision variable
g = casos.PS.sym('g');


% define SOS problem:
%   min g s.t. (f + g) is SOS
sos = struct('x',g,'f',g,'g',f+g);
% constraint is scalar SOS cone
opts = struct('Kc',struct('sos',1));

% solve by relaxation to SDP
S = casos.sossol('S','mosek',sos,opts);
% evaluate
sol = S();

fprintf('Minimum is %g.\n', full(sol.f))

