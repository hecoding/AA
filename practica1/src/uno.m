data = load("ex1data1.txt");
m = size(data, 1);
X = [ones(m, 1), data(:,1)];
y = data(:, 2);
theta = zeros(2, 1);

plot(X(:, 2), y, "rx", "linewidth", 1, "markersize", 8);
xlabel("beneficio en 10.000s", "fontsize", 10);
ylabel("poblacion en 10.000s", "fontsize", 10);

%X = [-10:10];
%Y = [-1:4];
%[X Y] = meshgrid(X,Y);
%surface(X, Y, J(X, Y, data, m));
%J(X, Y, data, m)