% load examples on X and labels on y
load('ex3data1.mat');

m = size(X, 1);
rand_indices = randperm(m);
sel = X(rand_indices(1:100), :);

displayData( sel );
