%f=imread('tray.pgm');
I=imread('tray.pgm');  
J = imnoise(I,'salt & pepper',0.02);
Kaverage = filter2(fspecial('average',3),J)/255;
Kmedian = medfilt2(J);
imshowpair(Kaverage,Kmedian,'montage');
Result = im2bw(Kmedian);
%imshow(Result);
%title('Result');