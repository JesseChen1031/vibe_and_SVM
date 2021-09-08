
%% parameter
% cellsize=[6 6];
global classifier;

%% Main Structure
% |imageDatastore| recursively scans the directory tree containing the
% images. Folder names are automatically used as labels for each image.
Trainsample = imageDatastore('FinalSamples','IncludeSubfolders', true, 'LabelSource', 'foldernames');
% Testsample = imageDatastore('Test_samples');

% Extract HOG features and HOG visualization
Check = countEachLabel(Trainsample);
disp(Check);


img = readimage(Trainsample, 37);
[hogFeature, visual] = extractHOGFeatures(img);%,'CellSize',cellsize);


hogFeatureSize = length(hogFeature);

% Loop over the trainingSet and extract HOG features from each image. A
% similar procedure will be used to extract features from the testSet.

numTrain = numel(Trainsample.Files);
trainingFeatures = zeros(numTrain, hogFeatureSize, 'single');

%% extracting features
for i = 1:numTrain
    img = readimage(Trainsample, i);
    
     img = rgb2gray(img);
     
     % Apply pre-processing steps
     img = imbinarize(img);
    
    trainingFeatures(i, :) = extractHOGFeatures(img);%, 'CellSize', cellsize);  
end

trainingLabels = Trainsample.Labels;

classifier = fitcsvm(trainingFeatures,trainingLabels);

% save('classifier.mat','classifier');

%mat=classifier.mat;%读取训练好的数据

% % 测试
% numTest = length(Testsample.Files); 
% for i = 1:numTest 
%  testImage = readimage(Testsample,i); 
%  featureTest = extractHOGFeatures(testImage); 
%  [predictIndex,score] = predict(classifier,featureTest); 
%  figure;imshow(testImage);
%  title(['predictImage: ',char(predictIndex)]);
% end 





