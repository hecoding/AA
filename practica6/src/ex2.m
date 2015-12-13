Xeasy_ham = parseEmail('easy_ham', 2551);
Xhard_ham = parseEmail('hard_ham', 250);
Xspam = parseEmail('spam', 500);

% split mails into train, validation, test sets.
% each one has 60% easy_ham, 20% hard_ham, 20% spam
trainSubsetPercentage = 60;
validationSubsetPercentage = 20;
testSubsetPercentage = 20;

[trainSet validationSet testSet] = splitDataSet(Xeasy_ham, trainSubsetPercentage, validationSubsetPercentage, testSubsetPercentage);

[trainTemp validationTemp testTemp] = splitDataSet(Xhard_ham, trainSubsetPercentage, validationSubsetPercentage, testSubsetPercentage);
trainSet = [trainSet trainTemp];
validationSet = [validationSet validationTemp];
testSet = [testSet testTemp];
ytrainSet = zeros(1, columns(trainSet));
yvalidationSet = zeros(1, columns(validationSet));
ytestSet = zeros(1, columns(testSet));

[trainTemp validationTemp testTemp] = splitDataSet(Xspam, trainSubsetPercentage, validationSubsetPercentage, testSubsetPercentage);
trainSet = [trainSet trainTemp];
validationSet = [validationSet validationTemp];
testSet = [testSet testTemp];
ytrainSet = [ytrainSet ones(1, columns(trainTemp))];
yvalidationSet = [yvalidationSet ones(1, columns(validationTemp))];
ytestSet = [ytestSet ones(1, columns(testTemp))];

% train with several combinations of C and sigma (gaussian kernel) parameters
nums = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
%   compute variations with repetition
vars = unique(nchoosek(repmat(nums,1,2),2),'rows');
%   vector with the percentage of hits of each model
percentages = zeros(size(vars), 1);
elapsed_time = zeros(size(vars), 1);

for i = 1:size(vars, 1)
  C = vars(i, 1);
  sigma = vars(i, 2);
  
  tic();
  model = svmTrain(trainSet', ytrainSet', C, @(x1, x2) gaussianKernel(x1, x2, sigma));
  elapsed_time(i) = toc();
  
  pred = svmPredict(model, validationSet');
  percentages(i) = mean(double(pred == yvalidationSet')) * 100;
end

%   size and color are relative. bigger (or colder) means less time to compute
scatter3(vars(:,1), vars(:,2), percentages,...
         0.45*(max(elapsed_time) - elapsed_time), elapsed_time, '.');
box on;
set(gca, 'xscale', 'log');
set(gca, 'yscale', 'log');
xlabel('C');
ylabel('\sigma');
zlabel('% of hits');

% test with the most succesful model
bestModelIndex = find(percentages == max(percentages));
C = vars(bestModelIndex, 1);
sigma = vars(bestModelIndex, 2);
model = svmTrain(trainSet', ytrainSet', C, @(x1, x2) gaussianKernel(x1, x2, sigma));

pred = svmPredict(model, testSet');
disp('The selected model made a % of hits of:');
disp(mean(double(pred == ytestSet')) * 100)
