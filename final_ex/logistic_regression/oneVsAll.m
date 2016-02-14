function [all_theta] = oneVsAll(X, y, num_labels, lambda, iter = 200)
%ONEVSALL trains several classifiers applying logistic regression and returns
% the result in a matrix where each row is the trained classifier of each label.
% X is a row matrix with a 1 before each example and y is a vector with the labels

  all_theta = zeros(num_labels, size(X,2));
  options = optimset('GradObj','on','MaxIter',iter);

  for i = 1:num_labels;
    initial_theta = all_theta(i, :)';

    [all_theta(i, :)] = fmincg (@(t)(lrCostFunction(t, X, (y == i), lambda)), initial_theta, options);
  end

end
