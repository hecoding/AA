function I = mcint_iterativo(fun, a, b, num_puntos)
	x = [a:0.1:b];
	maximo = max(fun(x));
	puntos = rand(num_puntos, 2) .* [b - a, maximo] .+ [a, 0];
  
	num_debajo = 0;
	for i=1:num_puntos
		if (fun(puntos(i,:)(1)) > puntos(i,:)(2))
			num_debajo++;
		endif
	endfor
  
  I =  num_debajo / num_puntos * (b-a) * maximo;
	
	plot(puntos(:,1)', puntos(:,2)', "rx", "linewidth", 2, x, fun(x), "linewidth", 2);
	xlabel("x", "fontsize", 20);
	ylabel("f(x)", "fontsize", 20);
	set(gca, "xlim", [a, b], "ylim", [0, maximo]);
  
endfunction