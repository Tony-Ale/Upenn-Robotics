mu = {[0.1, 0.5], [0.16, 0.56], [0.6, 0.1]};

h_1 = hsvSamples(:, 1);
s_1 = hsvSamples(:,2);

h_data1 = h_1(hsvSamples(:, 1)>0 & hsvSamples(:,1)<0.13);
h_data2 = h_1(hsvSamples(:,1) > 0.13 & hsvSamples(:,1)<0.22);
h_data3 = h_1(hsvSamples(:,1)>0.22);

s_data1 = s_1(hsvSamples(:,2)>0.29 & hsvSamples(:,2) < 0.7);
s_data2 = s_1(hsvSamples(:,2) > 0 & hsvSamples(:,2) < 1);
s_data3 = s_1(hsvSamples(:,2)>0 & hsvSamples(:,2) < 0.31);

count = 1; 
h_2 = 0;
s_2 = 0;
for v = 1:length(h_1)
    if h_1(v)>0 && h_1(v)<0.13
        h_2(count) = h_1(v);
        s_2(count) = s_1(v);
        count = count + 1;
    end
end


cov1 = [var(h_data1), std(h_data1)*std(s_data1); std(h_data1)*std(s_data1), var(s_data1)];
cov2 = [var(h_data2), std(h_data2)*std(s_data2); std(h_data2)*std(s_data2), var(s_data2)];
cov3 = [var(h_data3), std(h_data3)*std(s_data3); std(h_data3)*std(s_data3), var(s_data3)];

% cov11 = [1, 0; 0, 1]
% cov22 = [1, 0; 0, 1]
% cov33 = [1, 0; 0, 1]

cov11 = [0.0005, -0.0015; -0.0015, 0.02];
cov22 = [0.0005, -0.0045; -0.0045, 0.0725];
cov33 = [0.0005, -0.0005; -0.0005, 0.0035];

E = {cov11, cov22, cov33};
[mu_updated, E_updated] = EM_algorithm_trial(mu, E, 3, 2, h_1, s_1);

% Define the mean and covariance matrix of the Gaussian distribution
mu = [0.16, 0.45];           % Mean

% Generate a grid of points for visualization
%[x, y] = meshgrid([0.04:0.02:0.3], [0:0.1:1]);
%[x, y] = meshgrid(h_1, s_1);
%[x, y] = meshgrid(linspace(min(h_1), max(h_1), 6000), linspace(min(s_1), max(s_1), 6000));
x = linspace(0.04, 0.3, 1000);
y = linspace(0, 1, 1000);

[x, y] = meshgrid(x, y);

% Create a 2D Gaussian distribution
gaussian = mvnpdf([x(:), y(:)], mu_updated{1}, E_updated{1});
gaussian = reshape(gaussian, size(x));
% Overlay the Gaussian distribution
contour(x, y, gaussian, 'ShowText', 'on');

hold on
scatter(h_1, s_1, '.')
%scatter(hsvSamples(:,1),hsvSamples(:,2), '.');
xlim([0.04, 0.3])
xticks(0.04:0.02:0.3)
% Customize plot settings (labels, title, etc.)
%xlabel('X-axis');
%ylabel('Y-axis');
title('2D Gaussian Distribution Overlay');

% Add a colorbar to the plot
%colorbar;
