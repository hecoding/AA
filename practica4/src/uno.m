warning('off', 'Octave:possible-matlab-short-circuit-operator');
load('ex4data1.mat');

m = size(X, 1);
num_examples = 400;
num_hidden_neurons = 25;
num_labels = 10;
Theta1 = randWeights(num_examples, num_hidden_neurons);
Theta2 = randWeights(num_hidden_neurons, num_labels);
initial_nn = [Theta1(:) ; Theta2(:)];
num_iter = 50;
lambda = 1;

options = optimset('MaxIter', num_iter);
costFunction = @(p) costNN(p,num_examples, num_hidden_neurons, num_labels, X, y, lambda);

% optimize the thetha matrices of the neural network
[nn_params, cost] = fmincg(costFunction, initial_nn, options);

% obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:num_hidden_neurons * (num_examples + 1)), num_hidden_neurons, (num_examples + 1));
Theta2 = reshape(nn_params((1 + (num_hidden_neurons * (num_examples + 1))):end), num_labels, (num_hidden_neurons + 1));

% do the forward propagation
h1 = sig([ones(m, 1) X] * Theta1');
h2 = sig([ones(m, 1) h1] * Theta2');
[temp, pred] = max(h2, [], 2);

disp('% of hits:');
disp(mean(double(pred == y)) * 100);
