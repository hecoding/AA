function I = mcint_vector(fun, a, b, num_puntos)
	x = [a:0.1:b];
	maximo = max(fun(x));
  % se hace un vector de aleatorios con el numero de puntos mas grande
	puntos = rand(max(num_puntos), 2) .* [b - a, maximo] .+ [a, 0];
  
  I = [];
  for i = num_puntos;
    % para cada num_puntos se coje solo los aleatorios necesarios (1:i, 1)
	  I = [I length(find( fun(puntos(1:i, 1)) > puntos(1:i, 2) == 1 )) ./ i * (b - a) * maximo];
  endfor
	
	%plot(puntos(:,1)', puntos(:,2)', "rx", "linewidth", 2, x, fun(x), "linewidth", 2);
	%xlabel("x", "fontsize", 20);
	%ylabel("f(x)", "fontsize", 20);
	%set(gca, "xlim", [a, b], "ylim", [0, maximo]);
  
endfunction