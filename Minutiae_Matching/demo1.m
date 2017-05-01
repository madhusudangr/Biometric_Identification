function [ output_args ] = demo1( input_args )
%DEMO1 Summary of this function goes here
%   Detailed explanation goes here
clc;
clear;


save('demo');
disp('0101.txt and 0102.txt');
[SimilarityMatrix Del] = matchingV2_1('0101.txt','0102.txt',5,10);
assignin('base', 'SimilarityMatrix_1112', SimilarityMatrix);
assignin('base', 'Del_1112', Del);
save('demo');
disp('0101.txt and 0202.txt');
[SimilarityMatrix Del] = matchingV2_1('0101.txt','0202.txt',5,10);
assignin('base', 'SimilarityMatrix_1122', SimilarityMatrix);
assignin('base', 'Del_1122', Del);
save('demo');
disp('0101.txt and 0302.txt')
[SimilarityMatrix Del] = matchingV2_1('0101.txt','0302.txt',5,10);
assignin('base', 'SimilarityMatrix_1132', SimilarityMatrix);
assignin('base', 'Del_1132', Del);
save('demo');
disp('0101.txt and 0402.txt');
[SimilarityMatrix Del] = matchingV2_1('0101.txt','0402.txt',5,10);
assignin('base', 'SimilarityMatrix_1142', SimilarityMatrix);
assignin('base', 'Del_1142', Del);
save('demo');
disp('0101.txt and 0502.txt');
[SimilarityMatrix Del] = matchingV2_1('0101.txt','0502.txt',5,10);
assignin('base', 'SimilarityMatrix_1152', SimilarityMatrix);
assignin('base', 'Del_1152', Del);
save('demo');



% disp('0201.txt and 0102.txt');
% [SimilarityMatrix Del] = matchingV2_1('0201.txt','0102.txt',40,45);
% assignin('base', 'SimilarityMatrix_2112', SimilarityMatrix);
% assignin('base', 'Del_2112', Del);
% save('demo');
% disp('0201.txt and 0202.txt');
% [SimilarityMatrix Del] = matchingV2_1('0201.txt','0202.txt',40,45);
% assignin('base', 'SimilarityMatrix_2122', SimilarityMatrix);
% assignin('base', 'Del_2122', Del);
% save('demo');
% disp('0201.txt and 0302.txt');
% [SimilarityMatrix Del] = matchingV2_1('0201.txt','0302.txt',40,45);
% assignin('base', 'SimilarityMatrix_2132', SimilarityMatrix);
% assignin('base', 'Del_2132', Del);
% save('demo');
% disp('0201.txt and 0402.txt');
% [SimilarityMatrix Del] = matchingV2_1('0201.txt','0402.txt',40,45);
% assignin('base', 'SimilarityMatrix_2142', SimilarityMatrix);
% assignin('base', 'Del_2142', Del);
% save('demo');
% save('demo');
% disp('0201.txt and 0502.txt');
% [SimilarityMatrix Del] = matchingV2_1('0201.txt','0502.txt',40,45);
% assignin('base', 'SimilarityMatrix_2152', SimilarityMatrix);
% assignin('base', 'Del_2152', Del);
% save('demo');


% disp('0301.txt and 0102.txt');
% [SimilarityMatrix Del] = matchingV2_1('0301.txt','0102.txt',20,25);
% assignin('base', 'SimilarityMatrix_3112', SimilarityMatrix);
% assignin('base', 'Del_3112', Del);
% save('demo');
% disp('0301.txt and 0202.txt');
% [SimilarityMatrix Del] = matchingV2_1('0301.txt','0202.txt',20,25);
% assignin('base', 'SimilarityMatrix_3122', SimilarityMatrix);
% assignin('base', 'Del_3122', Del);
% save('demo');
% disp('0301.txt and 0302.txt');
% [SimilarityMatrix Del] = matchingV2_1('0301.txt','0302.txt',20,25);
% assignin('base', 'SimilarityMatrix_3132', SimilarityMatrix);
% assignin('base', 'Del_3132', Del);
% save('demo');
% disp('0301.txt and 0402.txt');
% [SimilarityMatrix Del] = matchingV2_1('0301.txt','0402.txt',20,25);
% assignin('base', 'SimilarityMatrix_3142', SimilarityMatrix);
% assignin('base', 'Del_3142', Del);
% save('demo');
% save('demo');
% disp('0301.txt and 0502.txt');
% [SimilarityMatrix Del] = matchingV2_1('0301.txt','0502.txt',20,25);
% assignin('base', 'SimilarityMatrix_3152', SimilarityMatrix);
% assignin('base', 'Del_3152', Del);
% save('demo');




% disp('0401.txt and 0102.txt');
% [SimilarityMatrix Del] = matchingV2_1('0401.txt','0102.txt',50,55);
% assignin('base', 'SimilarityMatrix_4112', SimilarityMatrix);
% assignin('base', 'Del_4112', Del);
% save('demo');
% disp('0401.txt and 0202.txt');
% [SimilarityMatrix Del] = matchingV2_1('0401.txt','0202.txt',50,55);
% assignin('base', 'SimilarityMatrix_4122', SimilarityMatrix);
% assignin('base', 'Del_4122', Del);
% save('demo');
% disp('0401.txt and 0302.txt');
% [SimilarityMatrix Del] = matchingV2_1('0401.txt','0302.txt',50,55);
% assignin('base', 'SimilarityMatrix_4132', SimilarityMatrix);
% assignin('base', 'Del_4132', Del);
% save('demo');
% disp('0401.txt and 0402.txt');
% [SimilarityMatrix Del] = matchingV2_1('0401.txt','0402.txt',50,55);
% assignin('base', 'SimilarityMatrix_4142', SimilarityMatrix);
% assignin('base', 'Del_4142', Del);
% save('demo');
% save('demo');
% disp('0401.txt and 0502.txt');
% [SimilarityMatrix Del] = matchingV2_1('0401.txt','0502.txt',50,55);
% assignin('base', 'SimilarityMatrix_4152', SimilarityMatrix);
% assignin('base', 'Del_4152', Del);
% save('demo');

% disp('0501.txt and 0102.txt');
% [SimilarityMatrix Del] = matchingV2_1('0501.txt','0102.txt',40,45);
% assignin('base', 'SimilarityMatrix_5112', SimilarityMatrix);
% assignin('base', 'Del_5112', Del);
% save('demo');
% disp('0501.txt and 0202.txt');
% [SimilarityMatrix Del] = matchingV2_1('0501.txt','0202.txt',40,45);
% assignin('base', 'SimilarityMatrix_5122', SimilarityMatrix);
% assignin('base', 'Del_5122', Del);
% save('demo');
% disp('0501.txt and 0302.txt');
% [SimilarityMatrix Del] = matchingV2_1('0501.txt','0302.txt',40,45);
% assignin('base', 'SimilarityMatrix_5132', SimilarityMatrix);
% assignin('base', 'Del_5132', Del);
% save('demo');
% disp('0501.txt and 0402.txt');
% [SimilarityMatrix Del] = matchingV2_1('0501.txt','0402.txt',40,45);
% assignin('base', 'SimilarityMatrix_5142', SimilarityMatrix);
% assignin('base', 'Del_5142', Del);
% save('demo');
% save('demo');
% disp('0501.txt and 0502.txt');
% [SimilarityMatrix Del] = matchingV2_1('0501.txt','0502.txt',40,45);
% assignin('base', 'SimilarityMatrix_5152', SimilarityMatrix);
% assignin('base', 'Del_5152', Del);
% save('demo');






end

