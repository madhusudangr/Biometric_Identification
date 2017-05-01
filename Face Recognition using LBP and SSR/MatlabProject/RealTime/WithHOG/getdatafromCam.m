function [ output_args ] = getdatafromCam( input_args )
s = '/Users/madhusudangovindraju/Downloads/Sprin 2016/Biometric Identification/Project/MatlabProject/Extra Credit/TrainingData';
cams = webcamlist;
cam = webcam(1);
runLoop = true;
%f = figure;
videoPlayer = vision.VideoPlayer;
faceDetector = vision.CascadeObjectDetector();
frameNo = 0;

    while runLoop
        img =snapshot(cam);
        bbox = step(faceDetector,img);
        frameNo = frameNo +1;
        for j=1:size(bbox,1)
            croppedimg = imcrop(img,bbox(j,:));
            label = frameNo;
            imwrite(croppedimg, strcat(s, sprintf('/%d.png',label)),'png');
            img = insertObjectAnnotation(img, 'rectangle', bbox(j,:),label,'Color',{'yellow'});
        end

        step(videoPlayer, img);
        runLoop = isOpen(videoPlayer);
    end

end


function my_closereq(src,callbackdata)
% Close request function 
% to display a question dialog box 
   selection = questdlg('Close This Figure?',...
      'Close Request Function',...
      'Yes','No','Yes'); 
   switch selection, 
      case 'Yes',
         delete(gcf)
      case 'No'
      return 
   end
end
