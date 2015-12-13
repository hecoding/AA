function [trainSet validationSet testSet] = splitDataSet(data, trainPerc, valPerc, testPerc)
% split 'data' dataset into three subsets using the given percentages

train_indices = 1:round(size(data,2)*trainPerc/100);
validation_indices = (round(size(data,2)*trainPerc/100)+1):(round(size(data,2)*trainPerc/100)+round(size(data,2)*valPerc/100));
test_indices = (round(size(data,2)*trainPerc/100)+round(size(data,2)*valPerc/100)+1):size(data,2);

trainSet = data(:,train_indices);
validationSet = data(:,validation_indices);
testSet = data(:,test_indices);

end
