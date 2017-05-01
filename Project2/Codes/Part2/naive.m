function [ prediction errorRate h ] = naive( testdataSize, trainingdataSize , bin )
%NAIVE Summary of this function goes here
%   Detailed explanation goes here
    %class = [0:1:9];
   
    %extracting image----------------------
    [imgs_test labels_test] = readMNIST('t10k-images.idx3-ubyte','t10k-labels.idx1-ubyte',testdataSize, 300);
    [imgs_test] = rearrange(imgs_test);
    [imgs_training labels_training] = readMNIST('train-images.idx3-ubyte','train-labels.idx1-ubyte',trainingdataSize, 50);
    [imgs_training] = rearrange(imgs_training);
    

    
    h= [];
    b = 1/bin;
    range = 0:b:1;
    class = unique(labels_training);
    priori = [];
    %training ----------------------
    for c= 1:1:size(class,1)
        img = imgs_training(find(labels_training == class(c)),:); 
        for i=1:1:size(img,2)
            H = histogram(img(:,i),range);
            h(c,i,:) = H.Values; %this gets the histogram values
            h(c,i,:) =( h(c,i,:) ./ size(img,1)); % calculate the pdf for the histogram values
            h(c,i,h(c,i,:) == 0) = 0.0001;     
        end
        priori(c) = ( size(img,1) / size(imgs_training,1) );
    end
    
    
    
    %test ---------------------------
    v =0;
    likelihood = [];
    posteriori = [];
    prediction = [];
    temp =[];
    for i= 1:1:size(imgs_test,1)
        
            for k=1:1:size(imgs_test,2)
                for c = 1:1:size(class,1)
                    v = abs(fix(imgs_test(i,k) / H.BinWidth)); %the vvariance goes negative sometimes
                    arr = h(c,k,:);
                    if (v < bin)
                        v= v+1; % this is because 0 goes to index 1 and 0.99&1 goes to last bin  
                    end
                    likelihood(c,k) = arr(v); %getting the likelihood
                    if (likelihood(c,k) == 0)
                        likelihood(c,k) = 10^(-12);
                    end
                end
            end
            for c=1:1:size(class,1)
                posteriori(c) = prod(likelihood(c,:)) * priori(c) ; %calculating the posteriori for every class
            end
            temp = class((posteriori == max(posteriori))); %taking the max posteriori's class are the prediction
            prediction(i) = temp(1);
    end
    
   %calculating error Rate ---------------------------
   e=0;
   for i= 1:1:size(imgs_test,1)
       if(prediction(i) ~= labels_test(i))
           e = e+1;
       end
   end
   errorRate = (e / size(imgs_test,1))*100;

end

