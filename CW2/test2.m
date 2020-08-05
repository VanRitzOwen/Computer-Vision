% stereo.m
% A simple script for stereo
% 
% G.J. Edwards   gje@sv1.smb.man.ac.uk
%
% Notes for NAT/CJT..... I could make this considerably quicker by vectorizing
% 			the matching completely, but it would be for 
%			a beginner to understand.
% 			 You can ignore any concatenation warnings  
%			it's just warning you about concatenating
% 			empty vectors.
%			 I could probably fix it, but anyway.

% Load your images here, I've just generated some random data
% -----------------------------------------------------------
%left_image = rand(100,100);
%right_image = rand(100,100);
left_image = imread('shaft3rec.l.pgm');
right_image = imread('shaft3rec.r.pgm');
% Find the edges ( like this for instance, but however you like)
% -------------------------------------------------------------
left_edge_image = edge(left_image,'sobel');
right_edge_image = edge(right_image,'sobel');

% Display everything
% ------------------
figure(1);
subplot(2,2,1);
imagesc(left_image);
axis image, axis off, colormap gray;
title('Left Image');
subplot(2,2,2);
imagesc(right_image);
axis image, axis off, colormap gray;
title('Right Image');

subplot(2,2,3);
imagesc(left_edge_image);
axis image, axis off, colormap gray;
title('Left Edge Image');
subplot(2,2,4);
imagesc(right_edge_image);
axis image, axis off, colormap gray;
title('Right Edge Image');


% Now do the matching ( a basic understanding of Matlab is needed here )
% -----------------------------------------------------------------------
num_rows = size(left_image,1);
num_cols = size(right_image,2);
array_of_disparities = [];

for r = 1:num_rows
	left_edge_pixels = find(left_edge_image(r,:));
	for i = left_edge_pixels
		i1 = find(right_edge_image(r,:));
		disparities = (i1 - i)';
        min_dis = min(abs(disparities));
        idxofmin = find(abs(disparities)==min_dis);
        finalmatch = disparities(idxofmin);
        if (length(finalmatch)>1)
            finalmatch(1)=[];
        end
        input = [i,r, finalmatch];
		%num_matches = size(disparities,1);
		%left_coords = repmat([i,r],num_matches,1);
		array_of_disparities = [array_of_disparities; [i,r, finalmatch] ]; 
	end
end
% Display the table of candidate matches
% --------------------------------------
%array_of_disparities

dis_row =  size(array_of_disparities,1);
stereo = [];
k=9000;
focal=17;
pixel=0.011;
for k=1:dis_row
    z=1/((array_of_disparities(k,3))*pixel);
    x = z*(array_of_disparities(k,1)*pixel/focal);
    y= z*(array_of_disparities(k,2)*pixel/focal);
    stereo=[stereo;[x,y,z]];
end

figure(2)
scatter(stereo(:,1),stereo(:,2))











