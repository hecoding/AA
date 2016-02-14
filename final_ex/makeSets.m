function [Xtrain ytrain Xvalidation yvalidation Xtest ytest] = ...
          makeSets(data_path, attributes, trainPercentage, valPercentage, testPercentage, Xdirection, ydirection)
% only run once to divide examples into training, cross validation and test sets
% each X column must be an example
% Xdirection and ydirection are the direction to cut the sets

[X y] = importImages(data_path, attributes);
if(strcmp(ydirection, 'column'))
  my = size(y, 2);
else
  my = size(y, 1);
end
Xtrain = [];
Xvalidation = [];
Xtest = [];
ytrain = [];
yvalidation = [];
ytest = [];

for i = 1:my
  % find where the current class examples are
  idx = find(y(:,i));
  
  % split them and distribute into training, validation and test sets
  [tr v ts] = splitDataSet(X(:,idx), trainPercentage, valPercentage, testPercentage, Xdirection);
  Xtrain = [Xtrain tr];
  Xvalidation = [Xvalidation v];
  Xtest = [Xtest ts];
  % the same for the labels
  [tr v ts] = splitDataSet(y(idx,:), trainPercentage, valPercentage, testPercentage, ydirection);
  ytrain = [ytrain; tr];
  yvalidation = [yvalidation; v];
  ytest = [ytest; ts];
end

shuffle = randperm(size(Xtrain,2));
Xtrain = Xtrain(:,shuffle);
ytrain = ytrain(shuffle,:);

shuffle = randperm(size(Xvalidation,2));
Xvalidation = Xvalidation(:,shuffle);
yvalidation = yvalidation(shuffle,:);

end
