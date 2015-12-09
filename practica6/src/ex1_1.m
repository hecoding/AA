load('ex6data1.mat');

C = 1;
max_passes = 20;

model = svmTrain(X, y, C,  @linearKernel , 1e-3, max_passes);
visualizeBoundaryLinear(X, y, model);
figure;

C = 100;
model = svmTrain(X, y, C,  @linearKernel , 1e-3, max_passes);
visualizeBoundaryLinear(X, y, model);