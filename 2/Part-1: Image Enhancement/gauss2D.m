function G = gauss2D( sigma , kernel_size )
    %% solution
    unnormG = gauss1D(sigma, kernel_size)' * gauss1D(sigma, kernel_size);
    G = unnormG ./ sum(unnormG, 'all');
end
