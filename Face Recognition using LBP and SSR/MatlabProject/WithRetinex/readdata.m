

function [labelslist,imagelist, imdata ] = readdata(imagepath)
%READDATA Summary of this function goes here
%   Detailed explanation goes here
patternname = 'yale*';
labelslist = dir(fullfile(imagepath,patternname));
imagelist = cell(numel(labelslist),1); % there are 585 images in every folder. This is specific to this yale dataset.
imdata = cell(numel(labelslist),1);%cell(1,numel(labelslist));
for j=1:numel(labelslist)
    patternname = '*.pgm';
     imagelist{j} = dir(fullfile(imagepath,labelslist(j).name,patternname));
    for k=1:numel(imagelist{j})
        imdata{j,k} = imread(fullfile(imagepath,labelslist(j).name,imagelist{j}(k).name));
    end
end

% patternname = '*.pgm';
% imagelist = dir(fullfile(imagepath,patternname));
% imdata = cell(1,numel(imagelist));
% %%load data
% for k=1:numel(imagelist)
%     imdata{k} = imread(fullfile(imagepath,imagelist(k).name));
% end


end

