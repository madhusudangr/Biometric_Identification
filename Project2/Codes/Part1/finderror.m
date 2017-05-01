function [ errorRate errors] = finderror( class , labels_test , testdataSize )
%FINDERROR Summary of this function goes here
%   Detailed explanation goes here
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

