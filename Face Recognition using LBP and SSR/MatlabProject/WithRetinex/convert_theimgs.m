function [  ] = convert_theimgs( )

imagepath = '/Users/madhusudangovindraju/Downloads/Sprin 2016/Biometric Identification/Project/Yale Data Set/YaleB';    
writepath = '/Users/madhusudangovindraju/Downloads/Sprin 2016/Biometric Identification/Project/Yale Data Set/YaleB/Images';    

[labelslist,imagelist ] = writeimgs2(imagepath,writepath);

end

function [labelslist,imagelist ] = writeimgs2(imagepath,writepath)
%READDATA Summary of this function goes here
%   Detailed explanation goes here
patternname = 'yale*';
labelslist = dir(fullfile(imagepath,patternname));
imagelist = cell(numel(labelslist),1); % there are 585 images in every folder. This is specific to this yale dataset.
%imdata = cell(numel(labelslist),1);%cell(1,numel(labelslist));
mkdir(writepath);
for j=1:numel(labelslist)
    
    s= [writepath '/' labelslist(j).name ];
    mkdir(s);
    patternname = '*.pgm';
    id =1;
     imagelist{j} = dir(fullfile(imagepath,labelslist(j).name,patternname));
    for k=1:numel(imagelist{j})
        img = imread(fullfile(imagepath,labelslist(j).name,imagelist{j}(k).name));
        disp(imagelist{j}(k).name);
        imwrite(img, strcat(s, sprintf('/%d.png',id)),'png');  
        id = id+1;
    end
end

% patternname = '*.pgm';
% imagelist = dir(fullfile(imagepath,patternname));
% imdata = cell(1,numel(imagelist));
% %%load data
% for k=1:numel(imagelist)
%     imdata{k} = imread(fullfile(imagepath,imagelist(k).name));
% end

beep on;beep;
end