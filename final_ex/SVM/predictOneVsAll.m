function preds = predictOneVsAll(models, X)

num_etiquetas = length(models);

for i = 1:num_etiquetas;
  model = models(i);
  preds(:,i) = svmPredict(model, X');
end

end