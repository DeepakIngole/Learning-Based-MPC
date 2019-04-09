addpath('../src/')
addpath('../src/utils/')

%the usage is mostly same as tubeMPC
A = [1 1; 0 1];
B = [0.5; 1]; 
Q = diag([1, 1]);
R = 0.1;
mysys = LinearSystem(A, B, Q, R);

Xc_vertex = [2, -2; 2 2; -10 2; -10 -2];
Uc_vertex = [1; -1];
Xc = Polyhedron(Xc_vertex);
Uc = Polyhedron(Uc_vertex);

% Unlike tube-MPC, this generic MPC doesn't guarantee the robustness. So if you
% add some noise (determined by w_min and w_max), and running the simulation 
% multiple times the state may hit the constraint Xc sometimes, which results in error.
% Please do some experiments.
w_min = [0; -0.06];
w_max = [0; 0.05];
mpc = ModelPredictiveControl(mysys, Xc, Uc, 3, w_min, w_max);
x_init = [-7; -2];
mpc.simulate(30, x_init);

