function [models] = trainOneVsAll(X, ys, C, kernelf)
%X have column-vectors examples and ys are columns labels too.
% returns a vector of models.
num_etiquetas = size(ys,2);

for i = 1:num_etiquetas;
  y = ys(:,i);
  models(i) = svmTrain(X', y, C, kernelf);
end

end
