function [ HOG_FeatureVectors ] = getHOGfeatures( I )
%GETHOGFEATURES Summary of this function goes here
%   Detailed explanation goes here
I = imresize(I, [128,64]);
Cellsize = 8; % every cell is 8*8 pixels
%Blocksize = 4 % every block has 4 cells so 16*16-pixels and 2*2-cells


%Here the image I is of size 128 * 64
%Calculate the image gradient and orientations
%[dx, dy] = imgradientxy(I);
[Gmag, Gdir] = imgradient(I);
%O = atan2(dy,dx); % orientations
O = Gdir;
%Normalize the angles the angles should only be in between 0 to 180. 
O(O < 0) = O( O <0) + 180;
O(O > 180) = O(O>180) - 180;

% now to calculate the histograms in every cell.
% Every cell will have 9 bins in it. of size 20.
%  0-20 21-40 41-60 61-80 81-100 101-120 121-140 141-160 161-180
%   bin1 bin2  bin3  bin4  bin5   bin6     bin7     bin8   bin9
% the number of cells are 16 * 8 and each of them have 9 bins so 
NumofBins = 9;
BinSize = 20;
OrientationBin = zeros(16,8,NumofBins);

HOG_FeatureVectors = []; 

for r=0:1:15 
    for c = 0:1:7
        %since we have to work on only 8*8 pixels at a time we copy those
        %into seperate temporary variables.
%         O_temp = O(( (r-1)*Cellsize : r*Cellsize ),( (c-1)*Cellsize : c*Cellsize ));
%         Mag_temp = Gmag(( (r-1)*Cellsize : r*Cellsize ),( (c-1)*Cellsize : c*Cellsize ));
%             startAt = (r* CellSize)+1;
%             endAt = (r+1)*Cellsize;
        %disp(r);disp(c);
        
        for i=(r* Cellsize)+1  :(r+1)*Cellsize 
            for j=(c*Cellsize)+1 : (c+1)*Cellsize
                bin =floor( O(i,j) / BinSize );
                bin = bin+1; %as we have bins starting from bin1 to bin 9 if ( O(i,j) / BinSize ) = 0, then it should go into bin 1;
                if(bin == 10)
                    bin =9;
                end
                BinMid = (bin-0.5)*BinSize;
                %disp(i);disp(j);
                if (bin~=9)
                    %BinMid = (bin-0.5)*BinSize;
                    OrientationBin(r+1,c+1,bin+1) = OrientationBin(r+1,c+1,bin+1) +( (O(i,j)-(BinMid)) /BinSize )*Gmag(i,j);
                    OrientationBin(r+1,c+1,bin) = OrientationBin(r+1,c+1,bin) + (BinSize-(O(i,j)-(BinMid)) /BinSize )*Gmag(i,j); 
                elseif(bin ==9)
                    OrientationBin(r+1,c+1,1) = OrientationBin(r+1,c+1,1) +( (O(i,j)-(BinMid)) /BinSize )*Gmag(i,j);
                    OrientationBin(r+1,c+1,bin) = OrientationBin(r+1,c+1,bin) + (BinSize-(O(i,j)-(BinMid)) /BinSize )*Gmag(i,j);
                end
            end
        end
        
    end
end



%Normalise the histograms calculated within the limits of each block. Each
%Block is 2*2 cells. 

for r=1:1:15 
    for c = 1:1:7
        reshaped = reshape(OrientationBin(r:r+1,c:c+1,:) ,[1,2*2*9] );
        n = norm(reshaped ); %finding the l2 norm to normalize the values
        h =  reshaped/ n; %Saving the histogram value
        HOG_FeatureVectors = [ HOG_FeatureVectors h];
    end
end





end

