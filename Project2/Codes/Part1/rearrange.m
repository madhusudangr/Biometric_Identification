function [ img ] = rearrange( M )
%REARRANGE Summary of this function goes here
%   Detailed explanation goes here
temp = [];
img = [];
for i=1:1:20
for j=1:1:20
temp = [temp M(i,j,1)];
end
end
img = [img temp];


for r=2:1:size(M,3)
    temp =[];
    for i=1:1:20
        for j=1:1:20
            temp = [temp M(i,j,r)];
        end
    end
    img = [img ; temp];
end



end

