function [J grad] = costNN(params_rn, num_entradas, num_ocultas, num_etiquetas , X, y, lambda)
  % compute the cost and gradient of a 2-layer neural network.

  Theta1 = reshape(params_rn(1:num_ocultas * (num_entradas + 1)), num_ocultas, (num_entradas + 1));
  Theta2 = reshape(params_rn((1 + (num_ocultas * (num_entradas + 1))):end), num_etiquetas, (num_ocultas + 1));
  
  J = 0;
  Theta1_grad = zeros(size(Theta1));
  Theta2_grad = zeros(size(Theta2));
  m = length(y);
  
  % forward propagation
  a1 = [ones(m,1) X];                %Xix401
  z2 = a1 * Theta1';                 %Xix25
  a2 = [ones(size(a1,1),1) sig(z2)]; %Xix26
  z3 = a2 * Theta2';                 %Xix10
  h  = sig(z3);
  
  % cost computation
  labels = y == [1:num_etiquetas];
  
  J = (
        sum(-sum( labels .* log(h) + (1 - labels) .* log(1 - h) )) % cost
        +
        ( sum(sumsq(Theta1, 2)) + sum(sumsq(Theta2, 2)) ) * lambda / 2 % regularization
      ) / m;
  
  
  % back propagation
  for i = 1:m
    
    % we don't need to recompute h
    
    for k = 1:num_etiquetas
      d3(k) = h(i,k) - (y(i) == k);
    end
    
    d2 = Theta2' * d3' .* sigDeriv([1 z2(i,:)])'; % 26x10 * 10x1 .* 26x1 = 26x1
    d2 = d2(2:end);
    
    Theta1_grad = Theta1_grad + d2 * a1(i,:);
    Theta2_grad = Theta2_grad + d3' * a2(i,:);
  
  end
  
  Theta1_grad = Theta1_grad / m;
  Theta2_grad = Theta2_grad / m;
  
  grad = [vec(Theta1_grad) ; vec(Theta2_grad)];

end
