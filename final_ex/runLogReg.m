function runLogReg(path, Xtrain, ytrain, Xvalidation, yvalidation, Xtest, ytest, normalization = 'normalization')

oldpwd = cd (path);

warning('off', 'Octave:possible-matlab-short-circuit-operator');
num_labels = max(ytrain);
mtrain = size(Xtrain, 2);
Xtrain = Xtrain';
Xvalidation = Xvalidation';
Xtest = Xtest';
default_lambda = 0;
lambdas = [1,3,10,30,100,300,1000,3000,10000,30000,100000,300000,1000000,3000000,10000000,30000000,100000000,300000000];

if(strcmp(normalization, 'normalization'))
  save_thetas_name = 'thetas_norm.mat';
  disp('WITH DATA NORMALIZATION:');
  Xtrain = featureNormalize(Xtrain')';
  Xvalidation = featureNormalize(Xvalidation')';
  Xtest = featureNormalize(Xtest')';
else
  save_thetas_name = 'thetas.mat';
  disp('WITHOUT DATA NORMALIZATION:');
end

Xtrain = [ ones(size(Xtrain,1),1) , Xtrain ];
Xvalidation = [ ones(size(Xvalidation,1),1) , Xvalidation ];
Xtest = [ ones(size(Xtest,1),1) , Xtest ];

if(exist(save_thetas_name, 'file') == 2)
  load(save_thetas_name);
else
  thetas = oneVsAll(Xtrain, ytrain, num_labels, default_lambda);
  save (save_thetas_name, 'thetas');
end

%disp('Preliminary training without parameter regularization:');
%label = predict(Xtrain, thetas);
%printf('|  hits on training set: %d\n', computePercentageOneVsAll(label, ytrain));
%label = predict(Xvalidation, thetas);
%printf('|  hits on validation set: %d\n', computePercentageOneVsAll(label, yvalidation));

%plotError(1:20:mtrain, Xtrain, ytrain, Xvalidation, yvalidation,...
%          num_labels, default_lambda, normalization);

%[bestLambda time] = plotLambda(lambdas, Xtrain, ytrain, Xvalidation,...
%                        yvalidation, num_labels, normalization, 'logscale');
%disp('lambda-wise:');
%printf('  best lambda: %d\n', bestLambda);
%printf('  time to train best lambda model: %ds\n', time);

[bestLambda time bestPercentage] = plotPercentage(lambdas, Xtrain, ytrain,...
                                      Xvalidation, yvalidation,...
                                      num_labels, normalization, 'logscale');

printf('Best regularization parameter: %d\n', bestLambda);
printf('Hits on validation set: %d%%\n', bestPercentage);
printf('Time to train best percentage model: %ds\n', time);

if(exist(strcat('best_',save_thetas_name), 'file') == 2)
  load(strcat('best_',save_thetas_name));
else
  best_thetas = oneVsAll(Xtrain, ytrain, num_labels, bestLambda);
  save (strcat('best_',save_thetas_name), 'best_thetas');
end

[per classes precision recall] = computePercentageOneVsAll(predict(Xtest, best_thetas), ytest);
printf('\nHits on test set: %d%%\n\n', per);

for i = 1:length(classes)
  printf('Hits on class %i: %d%%\n', i, classes(i));
end

printf('Precision: %d\n', precision);
printf('Recall: %d\n', recall);
printf('Average: %d\n', (precision + recall)/2);
printf('F1 score: %d\n', 2 * ((precision * recall)/(precision + recall)));

cd (oldpwd);

end
