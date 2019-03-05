function G = gauss1D( sigma , kernel_size )
    G = zeros(1, kernel_size);
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    %% solution
    X = [-floor(kernel_size/2):floor(kernel_size/2)];
    g = 1/(sqrt(2*pi)*sigma)*exp(-X.^2/(2*sigma^2));
    G = g./sum(g);
end
