classdef ModelPredictiveControl < handle
    
    properties (SetAccess = private)
        sys % linear sys
        optcon; % optimal contol solver object
        Xc
        w_min; w_max; % lower and upper bound of system noise
        % each vector has the same dim as that of system
    end
    
    methods (Access = public)
        
        function obj = ModelPredictiveControl(sys, Xc, Uc, N, varargin)
            obj.sys = sys;
            obj.Xc = Xc
            obj.optcon = OptimalControler(sys, Xc, Uc, N);
            if numel(varargin)==2 % wanna write in Julia... 
                obj.w_min = varargin{1}
                obj.w_max = varargin{2}
            else % if no arguments, no system noise
                obj.w_min = zeros(2, 1)
                obj.w_max = zeros(2, 1)
            end
        end
        
        function [] = simulate(obj, Tsimu, x_init)
            x = x_init;
            [x_nominal_seq] = obj.optcon.solve(x);
            x_seq_real = [x];
            u_seq_real = [];
            propagate = @(x, u, w) obj.sys.A*x+obj.sys.B*u + w;
            
            for i=1:Tsimu
                [x_nominal_seq, u_nominal_seq] = obj.optcon.solve(x);
                u = u_nominal_seq(:, 1);
                w = rand(2, 1).*(obj.w_max - obj.w_min)+obj.w_min;
                x = propagate(x, u, w);
                x_seq_real = [x_seq_real, x];
                u_seq_real = [u_seq_real, u];

                clf;
                Graphics.show_convex(obj.Xc, 'm');
                Graphics.show_trajectory(x_nominal_seq, 'gs-');
                Graphics.show_trajectory(x, 'b*-');
                pause(0.2)
            end
        end
    end
    
end
