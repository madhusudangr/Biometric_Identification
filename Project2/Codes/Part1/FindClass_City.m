function [ errorRate, class , city_Dist ] = FindClass_City(K,testdataSize , trainingdataSize)


%image Extraction ------------------
[imgs_training labels_training] = readMNIST('train-images.idx3-ubyte','train-labels.idx1-ubyte',trainingdataSize, 30);
[imgs_test labels_test] = readMNIST('t10k-images.idx3-ubyte','t10k-labels.idx1-ubyte',testdataSize, 30);
[imgs_test] = rearrange(imgs_test);
[imgs_training] = rearrange(imgs_training);


city_Dist = zeros([testdataSize,trainingdataSize]);
 for testCount=1:1:testdataSize
     for trainingCount = 1:1:trainingdataSize
         a = [];
         a = imgs_test(testCount,:);
         a = [a; imgs_training(trainingCount,:)];
         D = pdist(a,'cityblock');
         city_Dist(testCount,trainingCount) = D;
     end
 end
 val=0;
 col=0;
% K  = 5;
NearestNeighbours_Distance = zeros([testdataSize,K]);
the_weight = [];
the_labels = [];
temp = [];
for i=1:1:testdataSize
    A = zeros([1,trainingdataSize]);
    A = sort( city_Dist(i,:));
    %finding the least K distances
    for j=1:1:K
        NearestNeighbours_Distance(i,j) = A(1,j);
    end
   %finding the count of each element in the K nearest neighbours
   uniq = unique(NearestNeighbours_Distance(i,:)); %K nearest neighbour similarities
   uniq_count = histc(NearestNeighbours_Distance(i,:),the_labels);
   index =[];
   for j=1:length(uniq)
       index = [index find(city_Dist(i,:)==uniq(j))];
   end
   labels_NN = [];
   for j=1:length(index)
       labels_NN = [labels_NN labels_training(index(j))];
   end
   the_labels = unique(labels_NN);
   the_weight = histc(labels_NN,the_labels);
   index = find(the_weight==max(the_weight));
   class(i) = the_labels(index(1)); % always taking the first if we have a tie
end

errorRate =0 ;
errors = zeros([testdataSize],1);
wrongcount =0;
for i=1:1:testdataSize
    if(class(i) ~= labels_test(i))
        wrongcount = wrongcount+ 1;
        errors(i) = 1;
    end
end
errorRate = (wrongcount/testdataSize)*100;       

end

