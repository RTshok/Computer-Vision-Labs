function H = bsfilter(type, M, N, D0, P, n)
% Computes frequency domain bandstop or narrowband filters.
%   H = bsfilter(type, M, N, D0, W, n) creates the transfer function of
%   a band-stop filter, H, of the specified type and size (M-by-N).
%   Cutoff frequency is D0.
%   In case of bandstop filter P defines bandwidth.
%   In case of narrowband filter P defines point to suppress.
%
%   'bs-btw'      Butterworth bandstop filter of order n
%   'bs-gaussian' Gaussian bandstop filter
%   'nb-btw'      Butterworth narrowband filter of order n
%   'nb-gaussian' Gaussian narrowband filter
%

    % dftuv
    [u, v] = meshgrid((0:(N - 1)) - N / 2, (0:(M - 1)) - M / 2);
    if (strncmpi(type, 'nb', 2) == 1)
        u = circshift(u, floor(P));
        v = circshift(v, floor(P));
    else
        u = fftshift(u);
        v = fftshift(v);
    end

    % D^2 and D
    D_2 = u .^ 2 + v .^ 2;
    D = sqrt(D_2);
    D0_2 = D0 .* D0;

    % Transfer function
    switch (type)
    case 'bs-btw'
        if (nargin == 5)
            n = 1;
        end
        H = 1 ./ (1 + (D * P ./ (D_2 - D0_2)) .^ (2 * n));
        
    case 'bs-gaussian'
        H = 1 - exp(-0.5 .* (((D_2 - D0_2) ./ (D * P)) .^ 2));
        
    case 'nb-btw'
        if (nargin == 5)
            n = 1;
        end
        H = 1 - 1 ./ (1 + (D ./ D0) .^ (2 * n));
        
    case 'nb-gaussian'
        H = 1 - exp(-(D_2) ./ (2 * D0_2));
        
    end
   
end
