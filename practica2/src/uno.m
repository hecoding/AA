data = load('ex2data1.txt');
m = size(data, 1);
X = [ones(m, 1), data(:,1:2)];
y = data(:, 3);

% Obtain vectors with negative and positive example indices
neg = find (y == 0);
pos = find (y == 1);

% Draw examples
plot(X(neg, 2), X(neg, 3), 'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 7);
hold on;
plot(X(pos, 2), X(pos, 3), 'k+', 'MarkerSize', 7);
xlabel('Exam 1 score', 'fontsize', 10);
ylabel('Exam 2 score', 'fontsize', 10);
legend('Admitted', 'Not Admitted');
legend('boxoff');


options = optimset('GradObj', 'on', 'MaxIter', 400);

% Obtain the optimal theta
[theta, cst] = fminunc(@(t)(cost(t, X, y)), [0 0 0] , options);
plotDecisionBoundary(theta, X, y);

disp('Percentage of well classified examples:'); disp(percentage(theta, X, y));
