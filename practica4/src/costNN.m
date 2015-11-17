function [J grad] = costNN(params_rn, num_entradas, num_ocultas, num_etiquetas , X, y, lambda)
  % compute the cost and gradient of a 2-layer neural network.

  Theta1 = reshape(params_rn(1:num_ocultas * (num_entradas + 1)), num_ocultas, (num_entradas + 1));
  Theta2 = reshape(params_rn((1 + (num_ocultas * (num_entradas + 1))):end), num_etiquetas, (num_ocultas + 1));
  
  J = 0;
  Theta1_grad = zeros(size(Theta1));
  Theta2_grad = zeros(size(Theta2));
  m = length(y);
  
  % forward propagation
  a1 = [ones(size( X,1),1) X];                 %Xix401
  a2 = [ones(size(a1,1),1) sig(a1 * Theta1')]; %Xix26
  h  = sig(a2 * Theta2');                      %Xix10
  
  % cost computation
  labels = y == [1:10];
  
  J = (
        sum(-sum( labels .* log(h) + (1 - labels) .* log(1 - h) )) % cost
        +
        ( sum(sumsq(Theta1, 2)) + sum(sumsq(Theta2, 2)) ) * lambda / 2 % regularization
      )
      / m;
  
  
  
  
  %grad = (sum((sig(X * theta) - y) .* X) + lambda * theta') ./ m;
  %grad = grad';
  grad = 0;

end