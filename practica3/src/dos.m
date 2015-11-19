% load examples on X and labels on y
load('ex3data1.mat');

% load neural network
load('ex3weights.mat');
% Theta1 es de dimension 25x401
% Theta2 es de dimension 10x26

pred = forwardProp(Theta1, Theta2, X, 10);
[temp, label] = max(pred, [], 2);
disp('% of model hits:');
disp(mean(double(label == y)) * 100);
