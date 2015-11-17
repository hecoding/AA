load('ex4data1.mat');

load('ex4weights.mat');
% Theta1 es de dimensión 25 x 401
% Theta2 es de dimensión 10 x 26

params_rn = [Theta1(:) ; Theta2(:)];
num_entradas = 400;
num_ocultas = 25;
num_etiquetas = 10;
lambda = 1;

costNN(params_rn, num_entradas, num_ocultas, num_etiquetas , X, y, lambda);