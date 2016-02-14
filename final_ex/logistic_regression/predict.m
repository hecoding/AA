function label = predict(X, thetas)

[pred, label] = max( sig(X * thetas') , [], 2);

end
