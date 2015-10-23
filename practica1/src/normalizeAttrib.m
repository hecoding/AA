function [X_norm, mu, sigma] = normalizeAttrib(X)
  
  mu = mean(X);
  sigma = std(X);
  X_norm = (X - mu) ./ sigma;
  
endfunction