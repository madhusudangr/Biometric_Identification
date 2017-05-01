function [ Mdl ] = one(argument)

    %path where the input image is stored , these image have to be
    %processed and trained
    %imagepath = '/Users/madhusudangovindraju/Downloads/Sprin 2016/Biometric Identification/Project/Yale Data Set/YaleB';
    imagepath = '/Users/madhusudangovindraju/Downloads/Sprin 2016/Biometric Identification/Project/MatlabProject/Training_Testing';
    % path where you want the training data to be stored. This program will
    % create the space to store the processed training data. No need to give a
    % specific folder. Processed training data is the one where the
    % training images are cut the retines alrogithm in applied to it them
    % the processed,cropped image is stored in this location after extrating the HOG features
    ProcesseddataLocation = '/Users/madhusudangovindraju/Downloads/Sprin 2016/Biometric Identification/Project/MatlabProject/Training_Testing/ProcessedData';
    
    if(strcmp(argument, 'make'))
        %----uncomment the line below if you dont need
        mkdir(ProcesseddataLocation);
        [labelslist,imagelist, imdata ] = readdata2(imagepath);
        NormalizedCroppedImages = cell(numel(labelslist),1);
        NormalizedCroppedLabels = cell(numel(labelslist),1);
        featureSet = zeros(numel(labelslist)*numel(imagelist{1}),3780); % we want all the features to be in a single array with labes also in the same format to give it to train the classifier.
        labelSet = zeros(numel(labelslist)*numel(imagelist{1}),1);

%         NormalizedCroppedImages = {};
%         NormalizedCroppedLabels = {};
        faceDetector = vision.CascadeObjectDetector();
        f =1; % to traverse the featureSet and the labelSet
        for l=1:1:numel(labelslist)
            disp(labelslist(l).name);
            id =0;
            s= [ProcesseddataLocation '/' labelslist(l).name ];
            mkdir(s);
            for i=1:1:numel(imagelist{l})
                %read the data one by one
                img = cell2mat(imdata(l,i));
                %apply singlescaleretinex algorithm to the image and store the
                %corrected image
                %[R,L] = single_scale_retinex(img);
                %img = normalize8(R,0);
                bbox = step(faceDetector,img);
                %bbox = step(faceDetector,cell2mat(NormalizedCroppedImages(1,i)));
                for j=1:size(bbox,1)
                    croppedimg = imcrop(img,bbox(j,:));
                    croppedimg = imresize(croppedimg, [128,64]);
%                     siz = size(NormalizedCroppedImages{l},1);
%                     [R,L] = single_scale_retinex(croppedimg);
%                     NormalizedCroppedImages{l,siz+1} = R; % this is for just later reference purposes
%                     NormalizedCroppedLabels{l,siz+1} = labelslist(l).name; %this is for later reference purposes
                    disp(imagelist{l}(i).name);
                    %featureSet(f,:) = extractHOGFeatures(R);
%                     R = normalize8(R,0);
                    %featureSet(f,:) = getHOGfeatures(R);
                    featureSet(f,:) = getHOGfeatures(croppedimg);
                    labelSet(f,1) = str2double(labelslist(l).name(6:7)); % the last two chars will specify the person.
                    %------ uncomment the line below to save the training images
                    %imwrite(croppedimg, strcat(s, sprintf('/%d.png',id)),'png');% saving the copy of the image before applying the retinex algorithm.
                    id = id+1;
                    f = f+1;
                end
            end
        end
        %saving all the data for further references
        %---- comment the lines below if they are not be required
%         assignin('base','NormalizedCroppedImages', NormalizedCroppedImages);
%         assignin('base','NormalizedCroppedLabels',NormalizedCroppedLabels);
%         assignin('base','featureSet',featureSet);
%         assignin('base','labelSet',labelSet);
        
        %X = NormalizedCroppedImages;
        %Y = NormalizedCroppedLabels;
        %creating the SVM Model for classification.
        Mdl = fitcecoc(featureSet,labelSet);
        assignin('base','SVMModel',Mdl);
    elseif(strcmp(argument,'clean'))
        rmdir(ProcesseddataLocation,'s'); % 's' is for removing all the sub directories.
    end    
    beep on;beep;
end