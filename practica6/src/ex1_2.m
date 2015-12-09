load('ex6data2.mat');

C = 1;
sigma = 0.1;

model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
visualizeBoundary(X, y, model);
