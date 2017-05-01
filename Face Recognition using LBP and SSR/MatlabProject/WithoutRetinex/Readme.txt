

Extract the file Testing_Training and keep it in the same folder as the program files

Run the commands in the following order to test the system.

Step 1: To read the input images and create the training data and the SVM model.

%change the paths in the line6 and line12 before running the file
%this function One saves the svm model on to the workspace.


One('make');


Step 2: To test the model

%change the path in line3


[SimilarityMatrix, uniquieLabels,Big_Scores,Big_Scores2 ] = two( SVMModel);

SimilarityMatrix : This matrix gives all the results and comparisons; uset to plot the graphs
uniquieLabels : this array returnes a list of unique variables.
Big_Scores : are the socres returned for the SVM that is used to plot the graph.
SVMModel: The model trained with my training set is available inthe folder. Which can be used.
Additional Functions

1. To seperate the data into trainning and testing images

    stps_Seprte_training_nd_testing

2. To convert the images in the yale dataset which is in the .pgm format to .png format to understand the working better

    convert_theimgs
3. to read the images from a given folder

[ labelslist,imagelist, imdata ] = readdata2( imagepath );

imagepath: the path where the image can be picked from
imdata : all the images in a cell format

4. To plot the different graphs required for measuring the system's performance use the ffile below.

[ ConfusionMatrix ] = plotGraphs( SimilarityMatrix , uniqueLabels, Big_Scores,Big_Scores2);

5.getHOGfeatures() - this function will extract HOG features from the input image.

6.matlab.mat - contains the confusion matrix, images in "imdata", similarity matrix, and the scores for the prediction