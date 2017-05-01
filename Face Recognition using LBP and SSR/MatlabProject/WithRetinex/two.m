function [SimilarityMatrix, uniquieLabels,Big_Scores, Big_Scores2 ] = two( Model)

imagepath = '/Users/madhusudangovindraju/Downloads/Sprin 2016/Biometric Identification/Project/MatlabProject/Training_Testing';
[ labelslist,imagelist, imdata ] = readdata2_test(imagepath);
%NormalizedCroppedImages = cell(1,0); ---- no need this one here just
%display the results.
faceDetector = vision.CascadeObjectDetector();
SimilarityMatrix = cell(size(labelslist,1),1);
Big_Scores = cell(size(labelslist,1),1);
Big_Scores2 = cell(size(labelslist,1),1);
%now to find what are the different faces available in the face images
%given in the testing folder and match it with one of the available classes
%fromm the training dataset


%calculating all the different labels available
uniquieLabels = zeros(size(labelslist,1),1);
for l=1:1:numel(labelslist)
    uniquieLabels(l) = str2num( labelslist(l).name(6:end));
end


    for l=1:1:numel(labelslist)
            disp(labelslist(l).name);
            %should store all the detection results in this array
            tempSimilarityMatrix = zeros(3,numel(imagelist{l}));
            tempScore = zeros(numel(imagelist{l}),1);
            tempScore2 = zeros(numel(imagelist{l}),15);
            for i=1:1:numel(imagelist{l})
                
                %read the data one by one
                img = cell2mat(imdata(l,i));
                bbox = step(faceDetector,img);
                %bbox = step(faceDetector,cell2mat(NormalizedCroppedImages(1,i)));
                for j=1:size(bbox,1)
                    croppedimg = imcrop(img,bbox(j,:));
                    %imshow(img);
                    %pause;
                    [R,L] = single_scale_retinex(croppedimg);
                    R = normalize8(R,0);
                    %imshow(R);
                    %pause;
                    disp(imagelist{l}(i).name);
                    croppedimg = imresize(R, [128 128]);
                    f = getHOGfeatures(R);
                    [P,score] = predict(Model,f);
                    
                    disp('Prediction----');
                    disp(P);
                    if ( str2num(labelslist(l).name(6:end)) == P )
                        tempSimilarityMatrix(1,i) = 1;
                        tempSimilarityMatrix(2,i) = P;
                        tempSimilarityMatrix(3,i) = str2num(labelslist(l).name(6:end));
                        tempScore(i) = min(abs(score));
                        tempScore2(i,:) = (abs(score));
                        
                    else
                        tempSimilarityMatrix(1,i) = 0;
                        tempSimilarityMatrix(2,i) = P;
                        tempSimilarityMatrix(3,i) = str2num(labelslist(l).name(6:end));
                        tempScore(i) = min(abs(score));
                        tempScore2(i,:) = (abs(score));
                    end
                    
                end
                 

            end
            SimilarityMatrix{l} = tempSimilarityMatrix; 
            Big_Scores{l} = tempScore;
            Big_Scores2{l} = tempScore2;
    end

end


function [ labelslist,imagelist, imdata ] = readdata2_test( imagepath )

patternname = 'yale*';
labelslist = dir(fullfile(imagepath,patternname));
imagelist = cell(numel(labelslist),1); % there are38 images in every folder. This is specific becuase i have split the training data set and test set as follows yale dataset.
imdata = cell(numel(labelslist),1);%cell(1,numel(labelslist));
for j=1:numel(labelslist)
    patternname = '*.png';
     imagelist{j} = dir(fullfile(imagepath,labelslist(j).name,'testing',patternname));
    for k=1:numel(imagelist{j})
        imdata{j,k} = imread(fullfile(imagepath,labelslist(j).name,'testing',imagelist{j}(k).name));
    end
end
%assignin('base','imdata',imdata);

beep on; beep;


end


