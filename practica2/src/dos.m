data = load('ex2data2.txt');
y = data(:, 3);

% Obtain vectors with negative and positive example indices
neg = find (y == 0);
pos = find (y == 1);

% Draw examples
hold on;
plot(data(pos, 1), data(pos, 2), 'k+', 'MarkerSize', 7);
plot(data(neg, 1), data(neg, 2), 'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 7);
xlabel('Microchip Test 1', 'fontsize', 10);
ylabel('Microchip Test 2', 'fontsize', 10);
legend('Pass', 'Fail');
legend('boxoff');

X = mapFeature(data(:,1), data(:,2));


options = optimset('GradObj', 'on', 'MaxIter', 400);

% Obtain the optimal theta
lambda = 1;
[theta, cst] = fminunc(@(t)(costRegulariz(t, X, y, lambda)), zeros(1, size(X, 2)), options);
plotDecisionBoundary(theta', X, y);

disp('Percentage of well classified examples:'); disp(percentage(theta, X, y));
