function h = forwardProp(Theta1, Theta2, X, label_num)
  pred = zeros(label_num, 1);
  
  a1 = [ones(size( X,1),1) X];                 %Xix401
  a2 = [ones(size(a1,1),1) sig(a1 * Theta1')]; %Xix26
  h  = sig(a2 * Theta2');                      %Xix10

end