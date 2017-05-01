function [ output_args ] = stps_Seprte_training_nd_testing( input_args )

take_imgs_from_here ='/Users/madhusudangovindraju/Downloads/Sprin 2016/Biometric Identification/Project/Yale Data Set/YaleB/Images' ;
Put_imgs_here = '/Users/madhusudangovindraju/Downloads/Sprin 2016/Biometric Identification/Project/MatlabProject/Training_Testing';

%with some previous work I have seperated this working files as follows
training = [1,5,7,8,24,36,37,38,39,42,66,67,70,72,73,74,131,132,135,196,197,261,265,266,297,326,330,333,335,474,491,492,521,522,525,557,559,562];
testing = [ 18,25,31,50,52,191,192,311,341,566,574,473];


%making sure that the file is present
mkdir(Put_imgs_here);

%now reading the files to check for what all folder there in that location
%with the pattern"yale.."
patternname = 'yale*';
folderslist = dir(fullfile(take_imgs_from_here,patternname));
for i=1:numel(folderslist)
    mkdir(fullfile(Put_imgs_here,folderslist(i).name));
    %make the seperate folders for training and testing
    mkdir(fullfile(Put_imgs_here,folderslist(i).name,'training'));
    mkdir(fullfile(Put_imgs_here,folderslist(i).name,'testing'));
    %to find out what all imgs are there inside the folder
    patternname = '*.png';
     imagelist{i} = dir(fullfile(take_imgs_from_here,folderslist(i).name,patternname));
     for j=1:numel(imagelist{i})
         
         
         %now to check where to put the image file (in testing folder or
         %training folder so check the id with the 2 arrays training and
         %testing
         len = length(imagelist{i}(j).name)-4;
         id = imagelist{i}(j).name(1:len);
         %take the image to be put in f
         f = fullfile(take_imgs_from_here,folderslist(i).name,imagelist{i}(j).name);
         %check where to put the file
         if( ismember( str2num(id) , training))
             %if id comes in training put it in training folder
             putlocation = fullfile(Put_imgs_here,folderslist(i).name,'training');
             copyfile(f,putlocation);
         else if(ismember( str2num(id) , testing))
                 putlocation = fullfile(Put_imgs_here,folderslist(i).name,'testing');
                 copyfile(f,putlocation);
             end
         end
     end
    
end



end

