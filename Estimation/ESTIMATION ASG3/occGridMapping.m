% Robotics: Estimation and Learning 
% WEEK 3
% 
% Complete this function following the instruction. 
function myMap = occGridMapping(ranges, scanAngles, pose, param)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%Parameters 

% the number of grids for 1 meter.
myResol = param.resol;
% the initial map size in pixels
myMap = zeros(param.size);
% the origin of the map in pixels
myorigin = param.origin; 

% 4. Log-odd parameters 
lo_occ = param.lo_occ;
lo_free = param.lo_free; 
lo_max = param.lo_max;
lo_min = param.lo_min;

N = size(pose,2);
for j = 1:N % for each time,
      
    % Find grids hit by the rays (in the gird map coordinate)
    x = pose(1, j);
    y = pose(2, j);
    theta = pose(3, j);
    rays = ranges(:, j);
    resolve_xaxis = rays .* cos(theta + scanAngles);
    resolve_yaxis = -rays .* sin(theta + scanAngles);
    
    position = [resolve_xaxis'; resolve_yaxis'] + [x;y];
  
    
    % Find occupied-measurement cells and free-measurement cells
    grid_index = ceil(myResol * position) + myorigin;
    
    % Robot position.
    orig = ceil(myResol * [x;y]) + myorigin; % start point
    
    % grid index is also end point
    for i = 1:size(grid_index, 2)
        %get cells in between
        [freex, freey] = bresenham(orig(1),orig(2),grid_index(1, i),grid_index(2, i)); 
        % convert to 1d index
        free = sub2ind(size(myMap),freey,freex);
        % Update the log-odds
        % set end point value 
        myMap(grid_index(2, i),grid_index(1, i)) = myMap(grid_index(2, i),grid_index(1, i)) + lo_occ;
        % set free cell values
        myMap(free) = myMap(free) - lo_free;
    end
    
    myMap = min(myMap, lo_max);
    myMap = max(myMap, lo_min);

    
    % Saturate the log-odd values
    

    % Visualize the map as needed
%    imagesc(myMap); 
%    hold on;
%    plot(orig(1), orig(2), '--r');
%    colormap('gray'); axis equal;
%    pause(0.001)

end

end

