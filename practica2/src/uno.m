data = load('ex2data1.txt');
m = size(data, 1);
X = [ones(m, 1), data(:,1:2)];
y = data(:, 3);

% Obtiene un vector con los índices de los ejemplos negativos
negativos = find (y == 0);
positivos = find (y == 1);

% Dibuja los ejemplos negativos
plot(X(negativos, 2), X(negativos, 3), 'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 7);
hold on;
plot(X(positivos, 2), X(positivos, 3), 'k+', 'MarkerSize', 7);
xlabel('Exam 1 score', 'fontsize', 10);
ylabel('Exam 2 score', 'fontsize', 10);
legend('Admitted', 'Not Admitted');
legend('boxoff');
