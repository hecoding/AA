data = load('ex1data2.txt');
m = size(data, 1);
X = [ones(m, 1), data(:, 1:2)];
y = data(:, 3);

[X mu sigma] = normalizeAttrib(X);
X(:,1) = 1;

%plot3(data(:,1), data(:,2), data(:,3), 'r.', 'linewidth', 1, 'markersize', 8);

