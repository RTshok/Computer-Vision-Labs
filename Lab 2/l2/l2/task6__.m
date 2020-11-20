function [ ] = task6__()

file = imread('Pic1.jpg');
PQ = paddedsize(size(file)); 
F = fft2(file, PQ(1), PQ(2));
D = 100;
H = hp_filter('gaussian', PQ(1), PQ(2), D);
G = H .* F; 
g = real(ifft2(G)); 
g = g(1:size(file, 1), 1:size(file, 2)); 
imshow(double(g/256));

end