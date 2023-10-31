function [ u ] = pd_controller(~, s, s_des, params)
%PD_CONTROLLER  PD controller for the height
%
%   s: 2x1 vector containing the current state [z; v_z]
%   s_des: 2x1 vector containing desired state [z; v_z]
%   params: robot parameters
%u = 0;


% FILL IN YOUR CODE HERE
%Note that the second derivative of Z_des is zero since z_des is a number
%check the utils folder for the robot parameters.
error = s_des - s
Kp = 50
Kv = 8.8
u = params.mass*(Kp*error(1) + Kv*error(2) + params.gravity)


end

