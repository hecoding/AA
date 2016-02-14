function whatIs(X, show = 0)
load best_thetas;
num_hidden_neurons = 25;
num_labels = 4;
num_input = 3840;
attributes = {'left', 'right', 'straight', 'up'};

h = forwardProp_pure(best_thetas, num_input, num_hidden_neurons, num_labels, X);

printf("%d%% %s\n", h(1) * 100, attributes{1});
printf("%d%% %s\n", h(2) * 100, attributes{2});
printf("%d%% %s\n", h(3) * 100, attributes{3});
printf("%d%% %s\n", h(4) * 100, attributes{4});

[perc, pred] = max(h, [], 2);
printf("\nit's %s with %d%%\n", attributes{pred}, perc * 100);

if(show)
  imshow(reshape(X,60,64))
end

end
