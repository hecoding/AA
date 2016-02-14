function plotData(X, U, y)

Ureduce = U(:, 1:2);
Z = Ureduce' * X;

idx1 = find(y == 1);
idx2 = find(y == 2);
idx3 = find(y == 3);
idx4 = find(y == 4);

figure;
hold on;
plot(Z(1,idx1), Z(2,idx1), '.r', 'linewidth', 2, 'markersize', 8);
plot(Z(1,idx2), Z(2,idx2), '.g', 'linewidth', 2, 'markersize', 8);
plot(Z(1,idx3), Z(2,idx3), '.b', 'linewidth', 2, 'markersize', 8);
plot(Z(1,idx4), Z(2,idx4), '.m', 'linewidth', 2, 'markersize', 8);
title('Data representation in 2D');
legend('left', 'right', 'straight', 'up');
hold off;

%imshow (reshape(X (:,230), 60,64));

end
