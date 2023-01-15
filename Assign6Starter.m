%% Assignment 6
%% Prepare workspace

close all
clear
X = csvread('sdata.csv');

%% Display data

% Use rotate tool in the figure to view data from different angles
figure
scatter3( X(:,1), X(:,2), X(:,3), 'r.', 'LineWidth', 3 )
xlabel('x_1')
ylabel('x_2')
zlabel('x_3')

hold on
scatter3(0,0,0,'MarkerEdgeColor','k',...
        'MarkerFaceColor','k')
hold off
title('Data points (red), origin (black)')
view(70,30)


%% Remove mean

mn = mean(X);

Xz = X - ones(1000,1)*mn;

figure
scatter3( Xz(:,1), Xz(:,2), Xz(:,3), 'r.', 'LineWidth', 3 )
xlabel('x_1')
ylabel('x_2')
zlabel('x_3')

hold on
scatter3(0,0,0,'MarkerEdgeColor','k',...
        'MarkerFaceColor','k')
hold off
title('Mean removed data points (red), origin (black)')
view(70,30)

%% Take SVD to find best line

[U,S,V] = svd(Xz,'econ');

a =V(:,1);  % Complete this line
b =V(:,2);
%% Display best line on scatterplot

figure
scatter3( Xz(:,1), Xz(:,2), Xz(:,3), 'r.', 'LineWidth', 3 )
xlabel('x_1')
ylabel('x_2')
zlabel('x_3')

title('Mean removed data points (red), 2D Subspace Approx (blue)')

% Scale length of line by root-mean-square of data for display
scale1 = S(1,1)/sqrt(size(Xz,1));
scale2 = S(2,2)/sqrt(size(Xz,1));
hold on

plot3(scale1*[0;a(1)],scale1*[0;a(2)],scale1*[0;a(3)], 'b', 'LineWidth', 4)
hold on
plot3(scale2*[0;b(1)],scale2*[0;b(2)],scale2*[0;b(3)], 'b', 'LineWidth', 4)
hold on
hold off

view(70,30)

%2D approximation
X2=U(:,1)*S(1,1)*a'+U(:,2)*S(2,2)*b'+ones(1000,1)*mn;

figure
scatter3( X(:,1), X(:,2), X(:,3), 'r.', 'LineWidth', 3 )
hold on
scatter3( X2(:,1), X2(:,2), X2(:,3), 'b.', 'LineWidth', 3 )
hold on
xlabel('x_1')
ylabel('x_2')
zlabel('x_3')
title('Original data points(red), 2D Subspace Approx data points(blue)')
view(141,-30)

%%errors of two approximations
Er1=S(2,2)^2+S(3,3)^2
Er2=S(3,3)^2