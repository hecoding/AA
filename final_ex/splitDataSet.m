function [trainSet validationSet testSet] ...
         = splitDataSet(data, trainPerc, valPerc, testPerc, direction)
% Split 'data' dataset into three subsets using the given percentages.
% 'direction' must be 'row' or 'column' to split row-wise or column-wise

if ~exist('direction', 'var') || isempty(direction) 
	disp('error: you must pass a direction to split into');
  continue;
end

if (strcmp(direction, 'row'))
  m = size(data,2);
else
  m = size(data,1);
end

train_indices = 1 : round( m * trainPerc / 100 );
validation_indices = (round( m * trainPerc / 100) + 1 ) ...
                      : ...
                     (round( m * trainPerc / 100 ) + round(m * valPerc / 100));
test_indices = (round( m * trainPerc / 100 ) + round( m * valPerc / 100) + 1)...
               : ...
                m;

if (strcmp(direction, 'row'))
  trainSet = data(:,train_indices);
  validationSet = data(:,validation_indices);
  testSet = data(:,test_indices);
else
  trainSet = data(train_indices,:);
  validationSet = data(validation_indices,:);
  testSet = data(test_indices,:);
end

end
