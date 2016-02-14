function s = sigDeriv(x)

  s = sig(x) .* (1 - sig(x));

end