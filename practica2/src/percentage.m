function p = percentage(theta, X, y)
  m = length(y);
  
  successes = find( (sig(X * theta') >= 0.5) == y );
  
  p = length(successes) / m * 100;

end