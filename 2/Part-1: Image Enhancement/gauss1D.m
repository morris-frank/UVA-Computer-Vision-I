function G = gauss1D( sigma , kernel_size )
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    %% solution
    rad = floor(kernel_size / 2);
    X = -rad:rad;
    unnormG = 1/(sigma * sqrt(2*pi)) .* exp(-0.5 * X.^2 ./ sigma^2);
    G = unnormG ./ sum(unnormG, 'all');
 end
