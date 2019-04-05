function [X1, X2, X3, X4, X5] = get_img(X, colour_space, idx)

if colour_space == 1
    X1 = reshape(X(idx(1), :, :), [96, 96]);
    X2 = reshape(X(idx(2), :, :), [96, 96]);
    X3 = reshape(X(idx(3), :, :), [96, 96]);
    X4 = reshape(X(idx(4), :, :), [96, 96]);
    X5 = reshape(X(idx(5), :, :), [96, 96]);
    
else
    X1 = reshape(X(idx(1), :, :), [96, 96, 3]);
    X2 = reshape(X(idx(2), :, :), [96, 96, 3]);
    X3 = reshape(X(idx(3), :, :), [96, 96, 3]);
    X4 = reshape(X(idx(4), :, :), [96, 96, 3]);
    X5 = reshape(X(idx(5), :, :), [96, 96, 3]);
    
end

end