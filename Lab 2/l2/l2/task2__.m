function [ ] = task2__()

file = imread('Pic1.jpg');
file = imnoise(file, 'salt & pepper');
PQ = paddedsize(size(file)); 
F = fft2(file, PQ(1), PQ(2));
D = 100;
n = 1;
H = lp_filter('btw', PQ(1), PQ(2), D, n);
G = H .* F; 
g = real(ifft2(G)); 
g = g(1:size(file, 1), 1:size(file, 2)); 
imshow(double(g/256));

subplot(121);
imshow(file);
subplot(122);
imshow(double(g/256));

end