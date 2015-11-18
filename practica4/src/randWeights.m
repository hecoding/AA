function W = randWeights(L_in, L_out)
  epsilon = sqrt(6) / sqrt(L_in + L_out); % a good way to determine epsilon
  
  W = rand(L_out, L_in + 1) * (2 * epsilon) - epsilon; 

end