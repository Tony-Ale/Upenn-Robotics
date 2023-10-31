function [route,numExpanded] = DijkstraGrid (input_map, start_coords, dest_coords)
% Run Dijkstra's algorithm on a grid.
% Inputs : 
%   input_map : a logical array where the freespace cells are false or 0 and
%   the obstacles are true or 1
%   start_coords and dest_coords : Coordinates of the start and end cell
%   respectively, the first entry is the row and the second the column.
% Output :
%    route : An array containing the linear indices of the cells along the
%    shortest route from start to dest or an empty array if there is no
%    route. This is a single dimensional vector
%    numExpanded: Remember to also return the total number of nodes
%    expanded during your search. Do not count the goal node as an expanded node.


% set up color map for display
% 1 - white - clear cell
% 2 - black - obstacle
% 3 - red = visited
% 4 - blue  - on list
% 5 - green - start
% 6 - yellow - destination

cmap = [1 1 1; ...
        0 0 0; ...
        1 0 0; ...
        0 0 1; ...
        0 1 0; ...
        1 1 0; ...
	0.5 0.5 0.5];

colormap(cmap);

% variable to control if the map is being visualized on every
% iteration
drawMapEveryTime = true;

[nrows, ncols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(nrows,ncols);

map(~input_map) = 1;   % Mark free cells
map(input_map)  = 2;   % Mark obstacle cells

% Generate linear indices of start and dest nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
dest_node  = sub2ind(size(map), dest_coords(1),  dest_coords(2));

map(start_node) = 5;
map(dest_node)  = 6;

% Initialize distance array
distanceFromStart = Inf(nrows,ncols);

% For each grid cell this array holds the index of its parent
parent = zeros(nrows,ncols);

distanceFromStart(start_node) = 0;

% keep track of number of nodes expanded 
numExpanded = 0;

% Main Loop
while true
    
    % Draw current map
    map(start_node) = 5;
    map(dest_node) = 6;
    
    % make drawMapEveryTime = true if you want to see how the 
    % nodes are expanded on the grid. 
    if (drawMapEveryTime)
        image(1.5, 1.5, map);
        grid on;
        axis image;
        drawnow;
    end
    
    % Find the node with the minimum distance
    [min_dist, current] = min(distanceFromStart(:));
    
    if ((current == dest_node)) %|| isinf(min_dist))
        break;
    end;
    
    % Update map
    map(current) = 3;         % mark current node as visited
    %distanceFromStart(current) = Inf; % remove this node from further consideration
    
    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(distanceFromStart), current);
    
   % ********************************************************************* 
    % YOUR CODE BETWEEN THESE LINES OF STARS
    
    % Visit each neighbor of the current node and update the map, distances
    % and parent tables appropriately.
    [n,m] = size(distanceFromStart)
    if map(current) ~=  6 % that is so far you are not at the destination point
        if i-1 > 0 % ensures that you dont go outside the matrices boundary
         v1 = sub2ind(size(distanceFromStart), i-1, j) % Linear indices above current indices or node 
         if map(v1) == 1 || map(v1) == 6 % ensures the cell is free not visited an exception for the goal node
          distanceFromStart(v1) = distanceFromStart(current) + 1
          parent(v1) = current
          map(v1) = 4 % cells that you are intending to visit are coloured blue... visited cells are red
         end
        end
        if j+1 <= m
         v2 = sub2ind(size(distanceFromStart), i, j+1) % right of current
         if map(v2) == 1 || map(v2) == 6
             distanceFromStart(v2) = distanceFromStart(current) + 1
             parent(v2) = current
             map(v2) = 4
         end
        end
        if i+1 <= n
         v3 = sub2ind(size(distanceFromStart), i+1, j) % below current node
         if map(v3) == 1 || map(v3) == 6
          distanceFromStart(v3) = distanceFromStart(current) + 1
          parent(v3) = current
          map(v3) = 4
         end
        end
        if j-1 > 0
         v4 = sub2ind(size(distanceFromStart), i, j-1) % left of current node
         if map(v4) == 1 || map(v4) == 6
          distanceFromStart(v4) = distanceFromStart(current) + 1
          parent(v4) = current
          map(v4) = 4
         end
        end
    end 
    
    distanceFromStart(current) = Inf; 
    map(current) = 3 % colour the current visited cell red
    numExpanded = numExpanded + 1 
    
    
    
    
    %*********************************************************************

end

%% Construct route from start to dest by following the parent links
if (isinf(distanceFromStart(dest_node)))
    route = [];
else
    route = [dest_node];
    
    while (parent(route(1)) ~= 0)
        route = [parent(route(1)), route];
    end
    
        % Snippet of code used to visualize the map and the path
    for k = 2:length(route) - 1        
        map(route(k)) = 7;
        pause(0.1);
        image(1.5, 1.5, map);
        grid on;
        axis image;
    end
end
% code to determine route
% p = dest_node
% f = 1
% while true 
%     
%     path = parent(p)
%     p = path
%    % route(f) = path
%     f = f + 1
%     
%     if path == start_node
%         break;
%     end
% end
    

end
