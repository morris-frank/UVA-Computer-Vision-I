function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface


if nargin == 2
    path_type = 'column';
end

[h, w] = size(p);
height_map = zeros(h, w);

switch path_type
    case 'column'
        % =================================================================
        % YOUR CODE GOES HERE
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value
        
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        for j = 1:h
            S1 = sum(q(1:j, :), 1);
            S_column(j, :) = S1;
        end
        height_map = S_column;

        % =================================================================
               
    case 'row'
        
        % =================================================================
        % YOUR CODE GOES HERE
        for i = 1:w
            S2 = sum(p(:, 1:i), 1);
            S_row(:, i) = S2;
        end
        
        height_map = S_row;

        % =================================================================
          
    case 'average'
        
        % =================================================================
        % YOUR CODE GOES HERE
        
        for i = 1:w
            S2 = sum(p(:, 1:i), 1);
            S_row(:, i) = S2;
        end
        
        for j = 1:h
            S1 = sum(q(1:j, :), 1);
            S_column(j, :) = S1;
        end
        
        height_map = (S_row + S_column)/2;

        % =================================================================
        
end


end

