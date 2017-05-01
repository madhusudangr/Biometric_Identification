Readme :


1.This realtime face recognition has been made for 2 persons.

Steps to RUN

with HOG feature descriptor.

1.getdatafromCam.m

-change the path in line 2 to the point where you want to store the training data.
-keep separate folders for each person.

command to run  : getdatafromCam


2.one.m

-this is to train and create the SVM model
- this will automatically save the model into the workspace.
-change the path in line 6 to point to the location where the training data is stored.

command to run : one;

3.testfromCam.m

-this is to test the system after training

stepstorun : testfromCam( SVMModel );