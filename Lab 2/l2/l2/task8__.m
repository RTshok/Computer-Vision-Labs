function [ ] = task8__()

file = imread('Pic2.jpg');
file = imnoise(file, 'salt & pepper');
PQ = paddedsize(size(file)); 
F = fft2(file, PQ(1), PQ(2));
D = 150;
H = lp_filter('ideal', PQ(1), PQ(2), D);
G = H .* F; 
g = real(ifft2(G)); 
g = g(1:size(file, 1), 1:size(file, 2));

file1 = imread('Pic2.jpg');
file1 = imnoise(file1, 'salt & pepper');

H = fspecial('average', [3 3]);
I = imfilter(file1, H);

subplot(131);
imshow(file);
subplot(132);
imshow(double(g/256));
subplot(133);
imshow(I);

end