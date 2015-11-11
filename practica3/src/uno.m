% load examples on X and labels on y
load('ex3data1.mat');

m = size(X, 1);
rand_indices = randperm(m);
sel = X(rand_indices(1:100), :);

displayData( sel );


X = [ ones(size(X,1),1) , X ];
lambda = 0.1;

thetas = oneVsAll(X, y, 10, lambda);

[pred, label] = max(X * thetas', [], 2);
disp('% Model hits:');
disp(mean(double(label == y)) * 100);
