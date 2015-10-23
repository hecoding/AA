data = load('ex1data1.txt');
m = size(data, 1);
X = [ones(m, 1), data(:,1)];
y = data(:, 2);
theta = zeros(2, 1); % METER POR PARAMETRO
range = [5 23];

plot(X(:, 2), y, 'rx', 'linewidth', 1, 'markersize', 8, range, range * theta(2) + theta(1));
xlabel('beneficio en 10.000s', 'fontsize', 10);
ylabel('poblacion en 10.000s', 'fontsize', 10);

equis = [-10:0.1:10];
ygriega = [-1:0.1:4];
[equis ygriega] = meshgrid(equis, ygriega);

zeta = cost([vec(equis) vec(ygriega)], X, y);
zeta = reshape(zeta, size(equis));


figure;
surface(equis, ygriega, zeta);
xlabel('\theta_0', 'fontsize', 10);
ylabel('\theta_1', 'fontsize', 10);
zlabel('J(\theta)', 'fontsize', 10);
view(-35, 30);
grid on;

figure;
contour(equis, ygriega, zeta, logspace(-2, 3, 20));
xlabel('\theta_0', 'fontsize', 10);
ylabel('\theta_1', 'fontsize', 10);
hold on;
plot(theta_hist(:, 1), theta_hist(:, 2), 'rx', 'markersize', 8);
hold on;
plot(theta(1), theta(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);