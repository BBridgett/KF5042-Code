% Get number of words 
numWords = size(data,1);
% Partition the data into training and testing using built-in function
% 'cvpartition' using a 90:10 ratio: 90% for the training data and 10% for test data 
cvp = cvpartition(numWords,'HoldOut',0.01); 

%holdout fewer if applying model
dataTrain = data(training(cvp),:); dataTest = data(test(cvp),:);
wordsTrain = dataTrain.Word; 
XTrain = word2vec(emb,wordsTrain);
YTrain = dataTrain.Label;

% Train a support vector machine (SVM) Classifier which classifies
% word vectors into positive and negative categories (binary classification) 
model = fitcsvm(XTrain,YTrain);