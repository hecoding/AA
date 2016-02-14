function [Z Ureduce mean deviation] = runDimReduction(path, Xtrain, ytrain, Xval, yval, Xtest, ytest)
%Each column must be an example of the X matrix
oldpwd = cd (path);

min_percentage = 99;

% preprocess data doing mean normalization and feature scaling (if the case)
[Xtrain mean deviation] = preprocessData(Xtrain);

% run PCA
[U S V] = pca(Xtrain);

% choose number of principal components
k = chooseK(S, min_percentage / 100);
printf('  The number of principal components for which a %d%% of variance is retained is: %i\n', min_percentage, k);

% reduce components
Ureduce = U(:, 1:k);
Z = Ureduce' * Xtrain;

% let's do 2D data visualization
plotData([Xtrain Xval Xtest], U, [ytrain; yval; ytest]);

cd (oldpwd);
end
