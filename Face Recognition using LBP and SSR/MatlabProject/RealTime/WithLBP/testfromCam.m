function [ output_args ] = testfromCam( SVMModel )

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
            croppedimg =imresize(croppedimg, [322,322]);
            [R,~] = single_scale_retinex(rgb2gray(croppedimg));
            R = normalize8(R,0);
            f = extractLBPFeatures(R);
            [P] = predict(SVMModel,f);
%             if P == 1
%                 label = 'Madhu';
%             else
%                 label = 'DontKnow';
%             end
            img = insertObjectAnnotation(img, 'rectangle', bbox(j,:),P,'Color',{'yellow'});
        end
        step(videoPlayer, img);
        runLoop = isOpen(videoPlayer);
    end









end

