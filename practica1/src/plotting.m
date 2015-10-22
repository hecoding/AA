data = load("ex1data1.txt");
m = size(data, 1);
X = [ones(m, 1), data(:,1)];
y = data(:, 2);
theta = zeros(2, 1);

plot(X(:, 2), y, "rx", "linewidth", 1, "markersize", 8);
xlabel("beneficio en 10.000s", "fontsize", 10);
ylabel("poblacion en 10.000s", "fontsize", 10);

equis = [-10:0.1:10];
ygriega = [-1:0.1:4];
[equis ygriega] = meshgrid(equis, ygriega);
zeta = zeros(size(equis));

for i = 1:size(equis, 1);
  for j = 1:size(equis, 2);
    zeta(i, j) = cost([equis(i, j) ygriega(i, j)], X, y);
  endfor
endfor

figure;
surface(equis, ygriega, zeta);
xlabel("theta0", "fontsize", 10);
ylabel("theta1", "fontsize", 10);
zlabel("J(theta)", "fontsize", 10);
view(-35, 30);
grid on;

figure;
contour(equis, ygriega, zeta, logspace(-2, 3, 20));
xlabel("theta0", "fontsize", 10);
ylabel("theta1", "fontsize", 10);