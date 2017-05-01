function [R,L] = single_scale_retinex(X,hsiz, normalize)
%http://www.mathworks.com/matlabcentral/fileexchange/26523-the-inface-toolbox-v2-0-for-illumination-invariant-face-recognition
% Default result
R=[];
L=[];

% Parameter checking
if nargin == 1
    hsiz = 15;
    normalize = 1;
elseif nargin ==2
    if isempty(hsiz)
        hsiz = 15;
    end
    normalize = 1;
elseif nargin == 3
    if isempty(hsiz)
        hsiz = 15;
    end
    
    if ~(normalize==1 || normalize==0)
        disp('Error: The third parameter can only be 0 or 1.');
        return;
     end
elseif nargin > 3
    disp('Error: Wrong number of input parameters!')
    return;
end

%Init. operations
[a,b]=size(X);
cent = ceil(a/2);
X1=normalize8(X)+0.01; %for the log operation

% Filter construction
filt = zeros(a,b);
summ=0;
for i=1:a
    for j=1:b
        radius = ((cent-i)^2+(cent-j)^2);
        filt(i,j) = exp(-(radius/(hsiz^2)));
        summ=summ+filt(i,j);
    end
end
filt=filt/summ;

% Filter image and adjust for log operation 
Z = ceil(imfilter(X1,filt,'replicate','same'));
if(sum(sum(Z==0))~=0)
    for i=1:a
        for j=1:b
            if Z(i,j)==0;
                Z(i,j)=0.01;
            end
        end
    end
end

% Produce illumination normalized image Y
R=log(X1)-log(Z);
L=log(Z);

% Do some postprocessing - this step is not necessary and can be skipped
if normalize ~= 0
    [R, dummy] =histtruncate(R, 0.2, 0.2);
    R=normalize8(R);
    L=normalize8(L);
end

