function [SimilarityMatrix, counts ] = matchingV2_1( a , b , theta_threshold, dir_threshold )
%MATCHING Summary of this function goes here
%   Detailed explanation goes here
SetA = load(a); %probe
SetB = load(b);%gallery

% %-------------------------- this is for testing purpose
% % comment this block while running 
% A = [];
% B = [];
% for i=1:1:10
% A = [A;SetA(i,:)];
% B = [B;SetB(i,:)];
% end
% SetA = A;
% SetB = B;
% % ---------------------------------------------------
global thetaNot;
global dirNot;
thetaNot = theta_threshold;
dirNot = dir_threshold;
disp('--------starting----------');
A =[];
D =[];
%creating the accumulator

[tempD,tempA]  = Accumulator(SetA , SetB); 
A = [A; tempA];
D = [D; tempD];
disp('Accumulator Value collected');
B = max(A);
[row,col] = find(A == B);
peaks = [];
for i=1:size(row,1)
    peaks = [peaks ; D( row(i),: ) ];
    
end
peaks = mean(peaks);
%now for value in the peaks we have to remap the SetB and check
%for the number of mathces btw SetA and SetB
SimilarityMatrix = [];
disp('starting to polupate the similarity Matrix');
for i=1:size(peaks,1)
    NewSetB = remap(peaks(i,:) , SetB);
    [numberofMatches, counts] = find_numberofMatches(SetA,NewSetB);
    score = numberofMatches / ( size(SetA,1) * size(SetB,1) );
    SimilarityMatrix = [SimilarityMatrix; peaks(i,1), peaks(i,2), peaks(i,3), numberofMatches, score] ;
end
end

function [D,A] = Accumulator( SetA , SetB)
D = [];
global thetaNot;
global dirNot;

for i=1:size(SetA,1)
    for j=1:size(SetB,1)
        Xi = SetA(i,1);
        Yi = SetA(i,2);
        Xj = SetB(j,1);
        Yj = SetB(j,2);
        theta = SetB(j,3);
        for t = 0:1:360;
            %fprintf('i=%d,j=%d,t=%d \n',i,j,t);
            theta = theta+t;
            if(theta >= 360)
                theta = mod(theta,360);
            end
            dd = min( abs(theta - SetA(i,3)) , 360-(abs(theta - SetA(i,3)))  );
            if( dd <= thetaNot)
                [del] = [Xi ;Yi] - [cosd(theta) -sind(theta) ; sind(theta) cosd(theta)]*[Xj; Yj];
                delX = del(1,1);
                delY = del(2,1);
                new = [cosd(theta) -sind(theta) ; sind(theta) cosd(theta)]*[Xj; Yj] + [delX; delY];
                newXj = new(1,1);
                newYj = new(2,1);
                sd = sqrt(  (newYj - Yi)^2  +  (  newXj-Xi )^2  );
                if( dd <= thetaNot && sd <= dirNot)
                   D = [D; delX delY theta];
                end
            end
            
        end
    end
end
A = zeros(size(D,1),1);
%accumulator quantization
disp('Accumulator quantization');
for i=1:size(D,1)
    for j=1:size(D,2)
        dd = min( abs(D(i,3) - D(j,3)) , 360-(abs(D(i,3) - D(j,3)))  );
        sd = sqrt(  (D(i,2) - D(j,2))^2  +  (  (D(i,1) - D(j,1))^2 ) );
        if( dd <= 3 && sd <= 2)
            A(i) =  A(i)+1 ; 
        end
    end
end




end

function newSetB = remap(A , SetB)
%disp('inside remap');
newSetB = zeros(size(SetB,1),3);
    for i=1:size(SetB,1)
        theta = A(1,3);
        oldX = SetB(i,1);
        oldY = SetB(i,2);
        delX = A(1,1);
        delY = A(1,2);
        new = [cosd(theta) -sind(theta) ; sind(theta) cosd(theta)]*[oldX; oldY] + [delX; delY];
        newX = new(1,1);
        newY = new(2,1);
        newSetB(i,:) =[newX newY theta]; 
    end
end

function [numberofMatches, count] = find_numberofMatches(SetA,SetB)
%disp('inside number of matches function');
numberofMatches = 0;
global thetaNot;
global dirNot;
count = zeros(  (size(SetA,1) * size(SetB,1))   ,   1);
for i=1:size(SetA,1)
    for j=1:size(SetB,1)
        dd = min( abs(SetB(j,3) - SetA(i,3)) , 360-(abs(SetB(j,3) - SetA(i,3)))  );
        sd = sqrt( ( SetB(j,1) - SetA(i,1))^2  +  (  SetB(j,2)-SetA(i,2) )^2  );
        if( dd <= thetaNot && sd <= dirNot)
            count(i*j,1) = count(i*j,1) +1;
        end
    end
end

numberofMatches = sum(count);

end
