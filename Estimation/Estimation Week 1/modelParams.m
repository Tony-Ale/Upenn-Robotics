clc

% Change the index of mu_updated and E_updated to visualize for a different
% mean and covariance matrix.

mu = {[0.1, 0.5], [0.16, 0.56], [0.6, 0.1]};

h_1 = hsvSamples(:, 1);
s_1 = hsvSamples(:,2);

cov11 = [0.0005, -0.0015; -0.0015, 0.02];
cov22 = [0.0005, -0.0045; -0.0045, 0.0725];
cov33 = [0.0005, -0.0005; -0.0005, 0.0035];

E = {cov11, cov22, cov33};
[mu_updated, E_updated] = EM_algorithm(mu, E, 3, 2, h_1, s_1);


% Generate a grid of points for visualization
x = linspace(0.04, 0.3, 1000);
y = linspace(0, 1, 1000);
[x, y] = meshgrid(x, y);

% Create a 2D Gaussian distribution
% change mu and E to visulaize for different parameters
gaussian = mvnpdf([x(:), y(:)], mu_updated{1}, E_updated{1});
gaussian = reshape(gaussian, size(x));

% Overlay the Gaussian distribution
contour(x, y, gaussian);
%contour(x, y, gaussian, 'ShowText', 'on');

hold on
scatter(h_1, s_1, '.')

xlim([0.04, 0.3])
xticks(0.04:0.02:0.3)

% Customize plot settings (labels, title, etc.)
xlabel('Hue');
ylabel('Saturation');
title('2D Gaussian Distribution Overlay');

