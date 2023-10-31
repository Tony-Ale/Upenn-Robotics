function [ predictx, predicty, state, param ] = kalmanFilter( t, x, y, state, param, previous_t )
%UNTITLED Summary of this function goes here
%   Four dimensional state: position_x, position_y, velocity_x, velocity_y

    %% Place parameters like covarainces, etc. here:
    % P = eye(4)
    % R = eye(2)

    % Check if the first time running this function
    if previous_t<0
        state = [x, y, 0, 0];
        param.P = 0.1 * eye(4);
        predictx = x;
        predicty = y;
        return;
    end

    %% TODO: Add Kalman filter updates
    A = [1, 0, 0.033, 0;0, 1, 0, 0.033;0, 0, 1, 0;0, 0, 0, 1];
    B = [0.5*0.033^2, 0; 0, 0.5*0.033^2; 0.033, 0; 0, 0.033];
    Q = 1000000* eye(4);
    Qm = 0.1 * eye(4);
    R = 0.1*eye(2);
    H = eye(2, 4);
    
    state = A*state';
    P = A*param.P*A' + Q;
    
    K = P*H'/(H*P*H' + R);
    Yr = [x;y];
    state = state + K*(Yr - H*state);
    
    param.P = P - K*H*P;
    
    state = state';
    predictx = state(1);
    predicty = state(2);
end
