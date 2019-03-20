function [cieq, ceq] = constraintsFunction(c,theta,x,N,K,LAMBDA,PSI,run_F,run_h, term_F, term_h)
%% Constraint function of nonlinear MPC for pendulum swing-up and balancing control
%
% Inputs:
%   u:      optimization variable, from time k to time k+N-1 
%   x:      current state at time k
%   Ts:     controller sample time
%   N:      prediction horizon
%
% Output:
%   cineq:      inequality constraints applied across prediction horizon
%   ceq:    equality constraints (empty)
%

%% Nonlinear MPC design parameters

% conseq_num  = 8;
ALPHA = 0.99; % λ ∈ (0, 1), λ can be chosen arbitrarily close to 1, the obtained
% invariant set can be used as a reliable polyhedral approximation to the maximal invariant set 


%% Inequality constraints calculation
cieq = [];
% ceq = zeros(N*conseq_num,1);
% Apply cons_num*N state constraints across prediction horizon, from time
% k+1 to k+N
xk = x;
ck = c(:,1);
n=size(xk,1); m=size(ck,1);
for k=1:N
    if (k<N)
        % inequality constraints
        
        % obtain new state at next prediction step
        [xk1, uk, E] = getTransitions(xk, ck, K, theta, LAMBDA,PSI);
        Xs=E(1:n,:); Us= E(n+1:n+m);
        % H-representation of constraints
        F = run_F; % columns represent vector x1 x2 x3 x4 u
        h = run_h;
        run_h_as = run_h*ALPHA;
        cieq_run = [F*[xk1;uk]-h;...
                    F*[Xs;Us]-run_h_as];
        cieq  = [cieq; cieq_run];
        % update plant state and input for next step
        xk = xk1;
        if k<N
            ck = c(:,k+1);
        end
    else
%         cieq_T = term_F*[xk1;theta]-term_h;
        cieq_T = [];
        cieq = [cieq; cieq_T];
    end
       
end

%% No equality constraints
ceq = [];

end