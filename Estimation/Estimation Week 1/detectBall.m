% Robotics: Estimation and Learning 
% WEEK 1
% 
% Complete this function following the instruction. 
function [segI, loc] = detectBall(I)
% function [segI, loc] = detectBall(I)
%
% INPUT
% I       120x160x3 numerial array 
%
% OUTPUT
% segI    120x160 numeric array
% loc     1x2 or 2x1 numeric array 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hard code your learned model parameters here
%
mu = [0.1630, 0.5668];
sig = [0.0013, -0.0026; -0.0026, 0.0296]; 
thre = 5;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find ball-color pixels using your model
% 
% hue = image_hsv(:, :, 1);
% sat = image_hsv(:, :, 2);
% ball = [];
% data = [hue(:), sat(:)];
% for i = 1:length(hue)
%     pdf = mvnpdf(data(i, :), mu, sig);
%     pdf
%     if pdf > thre
%         ball = [ball; data(i, :)];
%     end
% end

prob = zeros(size(I(:,:,1)));
I = rgb2hsv(I);
I(:, 1, 1)
size(I)
for i = 1 : size(I,2)
    prob(:,i) = mvnpdf(double([I(:,i,1) I(:,i,2)]), mu, sig);
end
ball = prob > thre;

size(ball)
CC = bwconncomp(ball);
% Filter out the biggest section from the mask and push it to Segmented
% Image
numPixels = cellfun(@numel,CC.PixelIdxList);
[~,idx] = max(numPixels);

segI =  false(size(ball));
segI(CC.PixelIdxList{idx}) = true;

s = regionprops(CC, 'Centroid');
loc = s(idx).Centroid;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do more processing to segment out the right cluster of pixels.
% You may use the following functions.
%   bwconncomp
%   regionprops
% Please see example_bw.m if you need an example code.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the location of the ball center
%

% segI = 
% loc = 
% 
% Note: In this assigment, the center of the segmented ball area will be considered for grading. 
% (You don't need to consider the whole ball shape if the ball is occluded.)

end
