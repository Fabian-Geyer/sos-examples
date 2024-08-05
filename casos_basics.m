% going through the readme step-by-step.

%% casos.PD -> Polynomial with constant (double) coefficients

% scalar zero:
scalarZero = casos.PD(0)
% zero matrix
zeroMatrix = casos.PD([0 0;0 0])
% constant matrix
matrixConst = casos.PD([4 -23; 0.4 3.23])
% back to matrix in Matlab
matrixConstMatlab = full(matrixConst)

% extra functionality (create zero matrices)
nByMZeros = casos.PD.zeros(4,5) % equivalent: casos.PD(3,2)
nByNZeros = casos.PD.zeros(4)

% same with ones
nByMOnes = casos.PD.ones(4,5) % equivalent: casos.PD(3,2)
nByNOnes = casos.PD.ones(4)

% and identity
identityMatrix = casos.PS.eye(4)

% (---- the above also works with casos.PS ----)

%% Indeterminates
% These are basically the x of a polynomial. They are not decision
% variables

% tuples e.g. x in R^3
xInR3 = casos.Indeterminates('x', 3)
xyInR2 = casos.Indeterminates('x', 'y')


x = casos.Indeterminates('x', 2)
% use Indeterminate in polynomial
f = [-x(2); x(1) + (x(1)^2 - 1)*x(2)]
u = [1 -4; 0 -2]*x

% use with symbolic coefficients
K_Symbolic = casos.PS.sym('k', [2, 2])
u_Symbolic = K_Symbolic*x


%% Monomial patterns -> wtf?
% e.g. z = [1 x1 x2 x1^2 x1*x2 x2^2]
monom = monomials(x, [0:2])
mon = casos.PS.sym('z', monom)


%% casos.PS -> polynomials with symbolic coeffients
% These coefficients can be decision variables in the optimization

% nx1 symbolic vector 
dVec = casos.PS.sym('d', 4)
% nxm symbolic matrix
dMatrix = casos.PS.sym('d',[4,5])

x = casos.Indeterminates('x',2)
z = monomials(x, 1:2);
% equivalent to Q*z (degree stays the same)
Qz = casos.PS.sym('s', z)

% equivalent to z'Qz (up to degree 2*d)
zQz = casos.PS.sym('q', z, 'gram');

%% Functions between polynomials

% one dimensional function
x = casos.PS.sym('x', 1)
f = casos.Function('f', {x}, {x^3})
res1 = f(2) % eval

% simple two dimensional input and output
x = casos.PS.sym('x',2);
exprOut = [4+x(1)^2; x(2)+x(1)^4]
f = casos.Function('f',{x}, {exprOut})
res2 = f([2,1]); % eval

% 2x2 matrix function -> add one to every entry
q = casos.PS.sym('q', [4,4]);
f = casos.Function('f', {q}, {q+ones(4,4)})
res3 = f(q);

% multiply matrices
A = casos.PS.sym('a', [2,2]);
B = casos.PS.sym('b', [2,2]);
f = casos.Function('f', {A, B}, {A*B})

res4= f([1 1;1 1], [3 2;1 0])