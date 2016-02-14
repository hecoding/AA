faces_path = 'faces';
attributes = {'left', 'right', 'straight', 'up'};
data_matrix_name = 'data.mat';
log_reg_path = 'logistic_regression';
neural_network_path = 'neural_network';
svm_path = 'SVM';
clustering_path = 'clustering';
dim_path = 'dimensionality_reduction';

%===============================================================================

disp('Loading data...');
% skip if variables already in memory
if ((exist('Xtrain', 'var') != 1) || (exist('ytrain', 'var') != 1))
  % if not in memory check if the data's been saved (pre-treated) else treat it
  if(exist(data_matrix_name, 'file') == 2)
    load(data_matrix_name);
  else
    [Xtrain ytrain Xvalidation yvalidation Xtest ytest] ...
      = makeSets(faces_path, attributes, 60, 20, 20, 'row', 'column');
    save data.mat Xtrain ytrain Xvalidation yvalidation Xtest ytest;
  end
end

%===============================================================================
% traduce the labels to logistic regression format
ytrain_log_reg = ytrain(:,1) + 2 * ytrain(:,2) + 3 * ytrain(:,3) + 4 * ytrain(:,4);
yvalidation_log_reg = yvalidation(:,1)+2*yvalidation(:,2)+3*yvalidation(:,3)+4*yvalidation(:,4);
ytest_log_reg = ytest(:,1) + 2 * ytest(:,2) + 3 * ytest(:,3) + 4 * ytest(:,4);

%===============================================================================

disp('Completed. Press any key to begin logistic regression training.');
%pause; close; clc;

%runLogReg(log_reg_path, Xtrain, ytrain_log_reg,...
%                        Xvalidation, yvalidation_log_reg,...
%                        Xtest, ytest_log_reg, 'no_normalization');

%runLogReg(log_reg_path, Xtrain, ytrain_log_reg,...
%                        Xvalidation, yvalidation_log_reg,...
%                        Xtest, ytest_log_reg, 'normalization');

%===============================================================================

%disp('Completed. Press any key to begin Neural Network training.');
%pause; close; clc;

%runNNTraining(neural_network_path, Xtrain, Xvalidation, Xtest, ...
%              ytrain_log_reg, yvalidation_log_reg, ytest_log_reg,
%              'no_normalization');

%runNNTraining(neural_network_path, Xtrain, Xvalidation, Xtest, ...
%              ytrain_log_reg, yvalidation_log_reg, ytest_log_reg,
%              'normalization');

%===============================================================================

disp('Completed. Press any key to begin SVM training.');
%pause; close; clc;

%runSVMTraining(svm_path, Xtrain, ytrain, Xvalidation, yvalidation, Xtest, ytest, 'no_normalization');

%runSVMTraining(svm_path, Xtrain, ytrain, Xvalidation, yvalidation, Xtest, ytest, 'normalization');

%===============================================================================

disp('Completed. Press any key to begin example clustering.');
%pause; close; clc;

%runClustering(clustering_path, [Xtrain Xvalidation Xtest]');

%===============================================================================

disp('Completed. Press any key to begin dimensionality reduction.');
%pause; close; clc;

%[Ztrain Ureduce mu sigma] = runDimReduction(dim_path, Xtrain, ytrain_log_reg, Xvalidation, yvalidation_log_reg, Xtest, ytest_log_reg);
%Zvalidation = compressData(Ureduce, Xvalidation, mu, sigma);
%Ztest = compressData(Ureduce, Xtest, mu, sigma);

%XZtrain = decompressData(Ureduce, Ztrain);

%imshow(reshape(Xtrain(:,1), 60, 64)); figure;
%imshow(reshape(XZtrain(:,1), 60, 64));
