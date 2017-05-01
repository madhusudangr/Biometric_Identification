function demo(Mdl)

imagepath = '/Users/madhusudangovindraju/Downloads/Sprin 2016/Biometric Identification/Project/Yale Data Set/YaleB/Images/yaleB11';    
faceDetector = vision.CascadeObjectDetector();
img = imread(fullfile(imagepath,'21.png'));
imshow(img);
pause;
[R,L] = single_scale_retinex(img);
R = normalize8(R,0);
imshow(R);
pause;
bbox = step(faceDetector,R);
 for j=1:size(bbox,1)
croppedimg = imcrop(R,bbox);
imshow(croppedimg)
pause;
 end
new_f = getHOGfeatures(R);
P = predict(Mdl,new_f); 
disp(P);
pause;
end