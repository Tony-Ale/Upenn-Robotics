close all;
clear;

% Hover
%z_des = 0;

% Step
z_des = 1;

% Given trajectory generator
trajhandle = @(t) fixed_set_point(t, z_des);

% This is your controller
controlhandle = @controller;

% Run simulation with given trajectory generator and controller
[t, z] = height_control(trajhandle, controlhandle);

%additional code by me
[a,b] = min(abs(z-(0.9*z_des))) % 90% of 1 metre, that is z_des 
rise_time = t(b) % Time to get to 0.9m

peak_overshoot = ((max(z) - z_des)/z_des)*100
