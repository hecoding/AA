function h2 = forwardProp_pure(params_rn, num_entradas, num_ocultas, num_etiquetas , X)
m = size(X, 1);

% obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(params_rn(1:num_ocultas * (num_entradas + 1)), num_ocultas, (num_entradas + 1));
Theta2 = reshape(params_rn((1 + (num_ocultas * (num_entradas + 1))):end), num_etiquetas, (num_ocultas + 1));

% do the forward propagation
h1 = sig([ones(m, 1) X] * Theta1');
h2 = sig([ones(m, 1) h1] * Theta2');

end