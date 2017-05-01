function [ class  eucl_Dist] = FindClass( EntireTestdata,EntireTrainingData,K,labels_training,testdataSize , trainingdataSize )
%FINDCLASS Summary of this function goes here
%   Detailed explanation goes here
class = zeros([testdataSize,1]);
probe = zeros([20,20]);
gallery = zeros([20,20]);
eucl_Dist = zeros([testdataSize,trainingdataSize]);
 for testCount=1:1:testdataSize
     for trainingCount = 1:1:trainingdataSize
         for i=1:1:20
             for j=1:1:20
                 probe(i,j) = EntireTestdata(i,j,testCount);
                 gallery(i,j) = EntireTrainingData(i,j,trainingCount);
             end
         end
         eucl_Dist(testCount,trainingCount) = find_eucledian(probe, gallery);
     end
 end
 val=0;
 col=0;
% K  = 5;
NearestNeighbours_Distance = zeros([testdataSize,K]);
for i=1:1:testdataSize
    A = zeros([1,trainingdataSize]);
    A = sort( eucl_Dist(i,:));
    %finding the least K distances
    for j=1:1:K
        NearestNeighbours_Distance(i,j) = A(1,j);
    end
   %finding the count of each element in the K nearest neighbours
   uniq = unique(NearestNeighbours_Distance(i,:)); %K nearest neighbour similarities
   index =[];
   for j=1:length(uniq)
       index = [index find(eucl_Dist(i,:)==uniq(j))];
   end
   labels_NN = [];
   for j=1:length(index)
       labels_NN = [labels_NN labels_training(index(j))];
   end
   uniq_labelsNN = unique(labels_NN);
   count_LabelsNN = histc(labels_NN,uniq_labelsNN);
   index = find(count_LabelsNN==max(count_LabelsNN));
   class(i) = uniq_labelsNN(index(1)); % always taking the first if we have a tie
end
  
end

