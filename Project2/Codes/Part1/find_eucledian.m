function [ eucl_Dist ] = find_eucledian( probe, training )
%FIND_EUCLEDIAN Summary of this function goes here
%   Detailed explanation goes here
% tot =0;
% for i=1:1:20
%     for j=1:1:20
%         tot = tot+((probe(i,j)-training(i,j)))^2;
%     end
% end
% eucl_Dist = sqrt(tot);

eucl_Dist = sqrt(sum(sum((probe(:,:) - training(:,:) ).^2)));

end

