function [predPerc classes precision recall] = computePercentageOneVsAll(predictions, y)

pred = double(predictions == y);
predPerc = mean(pred) * 100;

for i = 1:length(unique(y))
  yidx = find(y == i);
  classes(i) = double(mean(predictions(yidx) == i)) * 100;
  
  yclass = y == i;
  predclass = predictions == i;
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
