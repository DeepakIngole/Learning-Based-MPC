function [xk, u] = learnedModel(x, u, data)
%% Discrete-time learned dynamic model 
% Inputs:
%   x: states at time k
%   u: input at time k
%   data: struct with (X, Y) obervations for estimation
%
% Outputs:
%   xk: states at time k+1
%
%% Discrete time state-space model of the non-square LTI system for tracking
A = [1.01126321746508,-0.0100340214950357,6.46038913508018e-05,1.93716902346107e-07; ...
    0.0100340214950357,0.995515380253533,-0.0127681799951143,-5.57226765949308e-05; ...
    0,0,0.957038195891878,0.00792982548734094; ...
    0,0,-7.92982548734093,0.602405619103784];
B = [4.95338239742896e-07; ...
    -0.000193159646826652; ...
    0.0429618041081219; ...
    7.92982548734093];
C = [1,0,0,0;...
    0,1,0,0;...
    0,0,1,0;...
    0,0,0,1];
% D = [0;0;0;0];
xk = A*x + B*u + oracle(x,u,data);
% y = C*x;
end