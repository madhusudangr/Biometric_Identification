function [ ConfusionMatrix ] = plotGraphs( SimilarityMatrix , uniquelabels, Big_Scores, Big_Scores2 )

ConfusionMatrix = zeros(size(uniquelabels,1));

for i=1:size(uniquelabels,1)
        
%         for ii=1:size(SimilarityMatrix{i},1)
            for jj=1:size(SimilarityMatrix{i},2)
                if ( SimilarityMatrix{i}(2,jj) ~= 0     &&  SimilarityMatrix{i}(3,jj) ~= 0 )
                    v1 = SimilarityMatrix{i}(2,jj);
                    v2 = SimilarityMatrix{i}(3,jj);
                    i1 = find(uniquelabels == v1);
                    i2 = find(uniquelabels == v2);
                    ConfusionMatrix(i2,i1) = ConfusionMatrix(i1,i2) + 1; 
                end
                
            end
%         end

end


%%----- Plotting the Genuine and Imposter Matches -------

Genuinescores = diag(ConfusionMatrix);
I = eye(15,15);
ImposterScores = ConfusionMatrix(~I);
Maxval = max( max(Genuinescores), max(ImposterScores));
Minval = min(min(Genuinescores),min(ImposterScores));
range = floor(Minval) :2:ceil(Maxval);
h_Genuinescores = histc(Genuinescores,range);
h_Imposterscores = histc(ImposterScores,range);
PDF_Genuinescores = h_Genuinescores / 15;
PDF_Imposterscores = h_Imposterscores /((15*15)-15);
Maxval = max( max(PDF_Genuinescores), max(PDF_Imposterscores));
Minval = min(min(PDF_Genuinescores),min(PDF_Imposterscores));
range = floor(Minval) :0.5:floor(Minval);
range = linspace(0,1,6);
%range = transpose(range);
plot(range,PDF_Genuinescores,range,PDF_Imposterscores);
%plot(PDF_Genuinescores) ; hold on; plot(PDF_Imposterscores);
xlabel('Matches');
ylabel('Probablity');
title('Genuine and Imposter Match Distribution'); 
legend('No of Genuine Matches','No of Imposter Matches');

%%----- givinv out the sample of testing images------------
testingimgs = '/Users/madhusudangovindraju/Downloads/Sprin 2016/Biometric Identification/Project/MatlabProject/Training_Testing/yaleB19/testing';
trainingimgs = '/Users/madhusudangovindraju/Downloads/Sprin 2016/Biometric Identification/Project/MatlabProject/Training_Testing/yaleB19/training';
    figure;
    t = 1;
    patternname = '*.png';
     imagelist = dir(fullfile(trainingimgs,patternname));
    for k=1:numel(imagelist)
        x = imread(fullfile(trainingimgs,imagelist(k).name));
        subplot(7,6,t),imshow(x);
        t = t+1;
    end
    figure
    t = 1;
    patternname = '*.png';
     imagelist = dir(fullfile(testingimgs,patternname));
    for k=1:numel(imagelist)
        x = imread(fullfile(testingimgs,imagelist(k).name));
        subplot(4,3,t),imshow(x);
        t = t+1;
    end



        
%%------ Plotting the ROC Curve for the sytem --------
MinOfFolder = inf;
MaxOfFolder = 0;
%Finding the min and max value of the scores
for i=1:size(uniquelabels,1)
    MaxOfFile = 0;
    MinOfFile = inf;
    for j=1:size(Big_Scores{i},1)
        MaxVal = 0;
        MinVal = inf;
        if(~isempty(  Big_Scores{i}(j)))
            MaxVal = max(Big_Scores{i}(j),MaxVal);
            MinVal = min(Big_Scores{i}(j),MinVal);
            MaxOfFile = max(MaxVal,MaxOfFile);
            MinOfFile = min(MinVal,MinOfFile);
        end 
    end
    MaxOfFolder = max(MaxOfFile,MaxOfFolder);
    MinOfFolder = min(MinOfFile,MinOfFolder);
end
       
m = (MaxOfFolder - MinOfFolder)/15;
siz = (size(uniquelabels,1) * size(uniquelabels,1)) - 15;
NumberofImposterMatches = zeros(16,1); % zeros(siz,15);
NumberofGenuineMatches = zeros(16,1);   %zeros(15,15);
I = 1;
G = 1;t=1;
for threshold = MinOfFolder : m : MaxOfFolder
    
    %------FalseMatchRate for this "threshold"
    
    for i=1:size(uniquelabels,1)
                %for jj=1:size(SimilarityMatrix{i},2)
                %    [a,b]=hist(SimilarityMatrix{1}(1,:),unique(SimilarityMatrix{1}(1,:)));
                for jj=1:size(Big_Scores{i},1)
                    if(SimilarityMatrix{i}(1,jj) ==0)
                        if(Big_Scores{i}(jj)<=threshold)
                            NumberofImposterMatches(t) = NumberofImposterMatches(t) + 1;
                        end
                    %else if(SimilarityMatrix{i}(1,jj) ==1)
                    elseif (SimilarityMatrix{i}(1,jj) ==1)
                        if(Big_Scores{i}(jj)<=threshold)
                            NumberofGenuineMatches(t) = NumberofGenuineMatches(t) + 1;
                        end
                        
                            
                    end
                    
                end
    end  
    
  t = t+1;  
end
TotalNumberofGenuineComparisons = size(uniquelabels,1)*size(SimilarityMatrix{1},2);
G = NumberofGenuineMatches / TotalNumberofGenuineComparisons; G = G * 100;
TotalNumberofImposterComparisons = (size(uniquelabels,1) * size(SimilarityMatrix{1},2))^2 - TotalNumberofGenuineComparisons;
I = NumberofImposterMatches / TotalNumberofImposterComparisons; I = I * 100;

figure ,plot(I, G);
trapz(I,G)
xlabel('False Match Rate(%)');
ylabel('Genuine Match Rate(%)');
title('RoC Curve'); 
%legend('No of Genuine Matches','No of Imposter Matches');

%----------------------------------------
%--------FMR vs FNMR graph--------------
% to calculate the equal error rate

FMR =  I;
FNMR = 1-G;
r = 1:1:16;
figure ,plot(r,FMR, r,FNMR);
xlabel('Threshold');
ylabel('Error Rate(%)');
title('FMR vs FNMR curve'); 
legend('FMR','FNMR');


%---------------------------------------
% plot the cmc curve.
%totalNnumber of comparisons = 12*15 * 12*15
siz = size(uniquelabels,1)*size(Big_Scores2{i},1);
count =zeros(siz,1);
prID = 1;
for i=1:size(uniquelabels,1)
    for jj=1:size(Big_Scores2{i},1)
        for kk=1:size(Big_Scores2{i},2)
            if(Big_Scores2{i}(jj,kk) <= Big_Scores2{i}(jj,i))
                count(prID) = count(prID)+1;
            end
        end
        prID = prID+1;
    end
    
end
rankT_system_hist = histc(count,(1:1:siz));
rankT_system_pdf = rankT_system_hist ./ siz ; 
pointRank_system = zeros([siz,1]);
pointRank_system(1)=rankT_system_pdf(1);
for i=2:1:siz
    pointRank_system(i)=rankT_system_pdf(i)+pointRank_system(i-1);
end
figure, plot((1:1:siz),pointRank_system);
xlabel('Rank(t)');
ylabel('Rank-t Identification Percentage');
title('CMC Curve');

%-------d-prime value
GScore = [];
IScore = [];
for i=1:size(uniquelabels,1)
    for jj=1:size(Big_Scores2{i},1)
        for kk=1:size(Big_Scores2{i},2)
            GScore = [GScore; Big_Scores2{i}(jj,i)];
            temp = Big_Scores2{i}(jj,:);
            IScore = [IScore; temp(Big_Scores2{i}(jj,:) ~= Big_Scores2{i}(jj,i))];   %count(prID) = count(prID)+1;
            
        end
        
    end
    
end

Dprime = sqrt(2)*abs(mean(GScore)- mean(mean(IScore)))/sqrt(std(GScore)^2 + std(std(IScore))^2);






end

