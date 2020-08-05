I = imread("tray.pgm");
W = fspecial('gaussian', [150,150], 100);
K = imfilter(I, W, 'replicate');

%figure(1);
%subplot(121); imshow(I); title('Original Image');
%subplot(122); imshow(K); title('After Filter');

final = imsubtract(I, K);

F=im2double(final);
N = brighten(F,0.9);

%figure(2);
%subplot(121); imshow(F); title('Filtered Image');
%subplot(122); imshow(N); title('Brightened Image');

level=graythresh(N);
Result = imbinarize(N,0.2);
figure(3);
imshow(Result);