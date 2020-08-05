f=imread('brains.pgm');

figure(1);
level=graythresh(f);
result=imbinarize(f,0.74);

imshow(result);