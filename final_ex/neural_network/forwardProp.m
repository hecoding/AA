function [accuracy classes precision recall] = forwardProp(params_rn, num_entradas, num_ocultas, num_etiquetas , X, y)
m = size(X, 1);

% obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(params_rn(1:num_ocultas * (num_entradas + 1)), num_ocultas, (num_entradas + 1));
Theta2 = reshape(params_rn((1 + (num_ocultas * (num_entradas + 1))):end), num_etiquetas, (num_ocultas + 1));

% do the forward propagation
h1 = sig([ones(m, 1) X] * Theta1');
h2 = sig([ones(m, 1) h1] * Theta2');
[temp, pred] = max(h2, [], 2);

accuracy = mean(double(pred == y)) * 100;

for i = 1:num_etiquetas
  idx = find(y == i);
  classes(i) = double(mean(pred(idx) == i)) * 100;
  
  yclass = y == i;
  predclass = pred == i;
  truepos(:,i) = predclass & yclass;
  falsepos(:,i) = predclass & !yclass;
  falseneg(:,i) = !predclass & yclass;
end

truepos = sum(sum(truepos));
falsepos = sum(sum(falsepos));
falseneg = sum(sum(falseneg));
precision = truepos / (truepos + falsepos);
recall = truepos / (truepos + falseneg);

end