function estudio(fun, a, b, limit)
  x = [1:10:limit];

  f = mcint_vector(fun, a, b, x);
		
	plot(x, f , "linewidth", 2)
	xlabel( "puntos", "fontsize", 20)
	ylabel( "integral", "fontsize", 20)
	title( "Monte Carlo", "fontsize", 20)
  
endfunction