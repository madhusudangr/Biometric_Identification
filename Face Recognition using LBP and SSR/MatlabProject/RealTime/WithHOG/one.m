function [ Mdl ] = one(argument)

    %path where the input image is stored , these image have to be
    %processed and trained
    %imagepath = '/Users/madhusudangovindraju/Downloads/Sprin 2016/Biometric Identification/Project/Yale Data Set/YaleB';
    imagepath = '/Users/madhusudangovindraju/Downloads/Sprin 2016/Biometric Identification/Project/MatlabProject/Extra Credit/TrainingData';
    % path where you want the training data to be stored. This program will
    % create the space to store the processed training data. No need to give a
    % specific folder. Processed training data is the one where the
    % training images are cut the retines alrogithm in applied to it them
    % the processed,cropped image is stored in this location after extrating the HOG features
    
   
        %----uncomment the line below if you dont need
        
       
        [labelslist, imagelist, imdata ] = readdata2(imagepath);
        
        x =imresize(imdata{1}{1}, [322,322]);
        [R,~] = single_scale_retinex(rgb2gray(x));
        R = normalize8(R,0);
        tempfeatures = extractHOGFeatures(R);
        featureSet = zeros(numel(imagelist),size(tempfeatures,2)); % we want all the features to be in a single array with labes also in the same format to give it to train the classifier.
        labelSet = cell((numel(imagelist{1}) +numel(imagelist{2})),1);
        f = 1;
          for l=1:1:numel(labelslist)
              for i=1:1:numel(imagelist{l})
                  x =imresize(imdata{l}{i}, [322,322]);
                  [R,~] = single_scale_retinex(rgb2gray(x));
                  R = normalize8(R,0);
                    featureSet(f,:) = extractHOGFeatures(R);
                    labelSet{f,1} = labelslist(l); % the last two chars will specify the person.
                    %------ uncomment the line below to save the training images
                    %imwrite(croppedimg, strcat(s, sprintf('/%d.png',id)),'png');% saving the copy of the image before applying the retinex algorithm.
                    %id = id+1;
                    f = f+1;
              end
          end
    

        Mdl = fitcsvm(featureSet,labelSet);
        assignin('base','SVMModel',Mdl);  
    beep on;beep;
end

function [labelslist,imagelist, imdata ] = readdata2(imagepath)
    
    patternname ='*-data';
    labelslist = dir(fullfile(imagepath,patternname));
    imdata = cell(numel(labelslist),1);
    imagelist = cell(numel(labelslist),1);
    for i = 1:numel(labelslist)
        patternname = '*.png';  
        imagelist{i} = dir(fullfile(imagepath,labelslist(i).name,patternname));
        for k=1:numel(imagelist{i})
                imdata{i}{k} = imread(fullfile(imagepath,labelslist(i).name,imagelist{i}(k).name));
        end
        
    end
    
end