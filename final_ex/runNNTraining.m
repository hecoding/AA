function runNNTraining(path, Xtrain, Xvalidation, Xtest, ...
                             ytrain, yvalidation, ytest,
                             normalization = 'normalization')

oldpwd = cd (path);

mtrain = size(Xtrain, 2);
Xtrain = Xtrain';
Xvalidation = Xvalidation';
Xtest = Xtest';
num_hidden_neurons = 25;
num_labels = 4;
num_iter = 80;
default_lambda = 0;
lambdas = [0,0.001,0.003,0.01,0.03,0.1,0.3,1,3,10];

if(strcmp(normalization, 'normalization'))
  save_thetas_name = 'thetas.mat';
  disp('WITH DATA NORMALIZATION:');
  [Xtrain mu sigma] = featureNormalize(Xtrain);
  Xvalidation = bsxfun(@minus, Xvalidation, mu);
  Xvalidation = bsxfun(@rdivide, Xvalidation, sigma);
  Xtest = bsxfun(@minus, Xtest, mu);
  Xtest = bsxfun(@rdivide, Xtest, sigma);
else
  save_thetas_name = 'thetas_norm.mat';
  disp('WITHOUT DATA NORMALIZATION:');
end

if(exist(save_thetas_name, 'file') == 2)
  load(save_thetas_name);
else
  [hits thetas] = runNN(Xtrain, ytrain, num_hidden_neurons, num_labels, num_iter, default_lambda);
  save (save_thetas_name, 'thetas');
end

%disp('Preliminary training without regularization parameter:');
%printf('|  hits on training set: %d\n', forwardProp(thetas, size(Xtrain,2),...
%                              num_hidden_neurons, num_labels , Xtrain, ytrain));
%printf('|  hits on validation set: %d\n', forwardProp(thetas,...
%size(Xvalidation,2), num_hidden_neurons, num_labels, Xvalidation, yvalidation));

%plotError(1:20:mtrain, Xtrain, ytrain, Xvalidation, yvalidation,...
%          num_hidden_neurons, num_labels, num_iter, default_lambda, normalization);

[bestLambda lambdaTime] = plotLambda(lambdas, Xtrain, ytrain, Xvalidation,...
                        yvalidation, num_hidden_neurons, num_labels, num_iter, normalization, 'logscale');
printf('Best regularization parameter: %d\n', bestLambda);
printf('Time to train less error model: %ds\n', lambdaTime);

%[bestLambda percTime bestPercentage] = plotPercentage(
%                                     lambdas, Xtrain, ytrain, Xvalidation, yvalidation, ...
%                                     num_hidden_neurons, num_labels,num_iter,...
%                                     normalization, 'logscale');
%printf('Best regularization parameter: %d\n', bestLambda);
%printf('Hits on validation set: %d%%\n', bestPercentage);
%printf('Time to train best percentage model: %ds\n', percTime);

if(exist(strcat('best_',save_thetas_name), 'file') == 2)
  load(strcat('best_',save_thetas_name));
else
  [tmp best_thetas] = runNN(Xtrain, ytrain, num_hidden_neurons, num_labels, num_iter, bestLambda);
  save (strcat('best_',save_thetas_name), 'best_thetas');
end

[per classes precision recall] = forwardProp(best_thetas, size(Xtest,2), num_hidden_neurons, num_labels, Xtest, ytest);

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
