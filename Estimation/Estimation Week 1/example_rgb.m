% Robotics: Estimation and Learning 
% WEEK 3
% 
% This is an example code for collecting ball sample colors using roipoly
close all

imagepath = './train';
Samples = [];
hsvSamples = [];
for k=1:15
    % Load image
    I = imread(sprintf('%s/%03d.png',imagepath,k));
    hsvData = rgb2hsv(I);
        
    % You may consider other color space than RGB
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    % Considering HSV colour space
    h = hsvData(:,:,1);
    s = hsvData(:,:,2);
    v = hsvData(:,:,3);

    % Collect samples 
    disp('');
    disp('INTRUCTION: Click along the boundary of the ball. Double-click when you get back to the initial point.')
    disp('INTRUCTION: You can maximize the window size of the figure for precise clicks.')
    figure(1), 
    mask = roipoly(I); 
    figure(2), imshow(mask); title('Mask');
    sample_ind = find(mask > 0);
    
    R = R(sample_ind);
    G = G(sample_ind);
    B = B(sample_ind);
    
    h = h(sample_ind);
    s = s(sample_ind);
    v = v(sample_ind);
    
    Samples = [Samples; [R G B]];
    hsvSamples = [hsvSamples; [h, s, v]];
    
    disp('INTRUCTION: Press any key to continue. (Ctrl+c to exit)')
    pause
end


% visualize the sample distribution
figure (1)
scatter3(Samples(:,1),Samples(:,2),Samples(:,3),'.');
xlabel('Red');
ylabel('Green');
zlabel('Blue');

figure (2)
scatter3(hsvSamples(:,1),hsvSamples(:,2),hsvSamples(:,3),'.');
xlabel('Hue');
ylabel('Saturation');
zlabel('Value');

figure (5)
scatter(hsvSamples(:,1),hsvSamples(:,2),'.');
xlim([0.04, 0.3])
xticks(0.04:0.02:0.3)
title('Pixel Color Distribubtion');
xlabel('Hue');
ylabel('Saturation');
grid on
grid minor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [IMPORTANT]
%
% Now choose you model type and estimate the parameters (mu and Sigma) from
% the sample data.
%

