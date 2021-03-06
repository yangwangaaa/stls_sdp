% Solve approximate GCD problem

% construct space of sylvester matrices
D = [6 5]; % degrees of f1 and f2
d = 4; % degree of the gcd
noise = 5e-1;
[PP,n,k,m] = sylvester_struct(D,d);

% generate random polynomials
g = randn(1,d+1); % gcd
h1 = randn(1,D(1)-d+1);
h2 = randn(1,D(2)-d+1);
f1 = conv(g,h1); f1 = f1/norm(f1); % poly1
f2 = conv(g,h2); f2 = f2/norm(f2); % poly2
f1 = f1 + noise*randn(1,D(1)+1); % add noise
f2 = f2 + noise*randn(1,D(2)+1);

% construct Sylvester matrix
u1 = [f1 f2];
U1 = applyAffineMap(PP,u1);
disp('random Sylvester matrix')
disp(U1)

% find nearest rank deficient Sylvester matrix
tic
[opt,u,U,z,X] = sdp_stls(PP,u1);
toc
disp(opt)
disp('rank deficient Sylvester matrix')
disp(U)