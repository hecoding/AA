function [per classPred precision recall] = computePercentageOneVsAll(predictions, ys)
%each column is a vector of labels
classPred = zeros(1,size(ys,2));

for i = 1:size(ys,2)
  y = ys(:,i);
  currentPred = predictions(:,i);
  classPred(i) = mean(double(currentPred == y)) * 100;
  
  yclass = y == i;
  predclass = predictions(:,i) == i;
  truepos(:,i) = predclass & yclass;
  falsepos(:,i) = predclass & !yclass;
  falseneg(:,i) = !predclass & yclass;
end

truepos = sum(sum(truepos));
falsepos = sum(sum(falsepos));
falseneg = sum(sum(falseneg));
precision = truepos / (truepos + falsepos);
recall = truepos / (truepos + falseneg);

per = mean(classPred);

end