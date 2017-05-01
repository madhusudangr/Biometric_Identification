function [ labelslist,imagelist, imdata ] = readdata2( imagepath )

patternname = 'yale*';
labelslist = dir(fullfile(imagepath,patternname));
imagelist = cell(numel(labelslist),1); % there are 585 images in every folder. This is specific to this yale dataset.
imdata = cell(numel(labelslist),1);%cell(1,numel(labelslist));
for j=1:numel(labelslist)
    patternname = '*.png';
     imagelist{j} = dir(fullfile(imagepath,labelslist(j).name,'training',patternname));
    for k=1:numel(imagelist{j})
        imdata{j,k} = imread(fullfile(imagepath,labelslist(j).name,'training',imagelist{j}(k).name));
    end
end
assignin('base','imdata',imdata);
% patternname = '*.pgm';
% imagelist = dir(fullfile(imagepath,patternname));
% imdata = cell(1,numel(imagelist));
% %%load data
% for k=1:numel(imagelist)
%     imdata{k} = imread(fullfile(imagepath,imagelist(k).name));
% end

beep on; beep;



end

