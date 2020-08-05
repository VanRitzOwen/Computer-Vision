I=imread('tray.pgm'); 
%pout_imadjust = imadjust(I);
%pout_histeq = histeq(I);
Ada = adapthisteq(I);
%figure(1)
%imshow(Ada);
%title('Image with Enhanced Contrast')

J = imnoise(Ada,'salt & pepper',0.05);
Kaverage = filter2(fspecial('average',2),J)/255;
%Kmedian = medfilt2(J);
%imshowpair(Kaverage,Kmedian,'montage');
%figure(3)
%imshow(Kaverage)

level=graythresh(Kaverage);
Result = imbinarize(Kaverage, level);
%Result = im2bw(pout_adapthisteq);
figure(2);
imshow(Result);
%imshowpair(Result,I,'montage');