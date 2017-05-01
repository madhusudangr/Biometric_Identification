function [ R ] = ssr( img )

[row col] = size(img);
img = normalize8(img,0);
%first to normalize the image
maxV = max(max(img));
minV = min(min(img));
range = maxV - minV;
img = (img - minV) ./ (maxV-minV);
%the surround function 'sf'
center = floor(row/2);
sf = zeros(row,col);
for r = 1:row
    for c = 1:col
        rad = sqrt((center-r)^2 + (center-c)^2) ; 
        sf(r,c) = exp(-(rad)^2/225); % here 225 is the C3.
    end
end
filteredImg = ceil(imfilter(img,sf,'replicate','same'));
filteredImg(filteredImg == 0) = 0.01; 
R = log(img) - log(filteredImg);
L = log(filteredImg);
R = normalize8(img,0);


end

