%% Linear Classifier Evaluation
%% Set Up Workspace

close all
clear

load non_separable_classifier_data.mat

[n_train,p] = size(x_train);
[n_eval,p] = size(x_eval);

% Plot features and classes of training data
figure(1);clf;
scatter(x_train(:,1),x_train(:,2),50,y_train,'filled');colormap jet;colorbar
set(gca,'fontsize',20)
xlabel('feature 1');ylabel('feature 2')
title('Training data','interpreter','latex')

% Plot features and classes of evaluation data
figure(2);clf;
scatter(x_eval(:,1),x_eval(:,2),50,y_eval,'filled');colormap jet;colorbar
set(gca,'fontsize',20)
xlabel('feature 1');ylabel('feature 2')
title('evaluation data','interpreter','latex')
%% Part a) Classifier 1: sign(w1*x1 + w2*x2)

% Train classifier
w = (inv(x_train'*x_train))*x_train'*y_train;

% Predict labels using trained classifier
yhat = sign(x_eval*w);

% Plot yhat for evaluation data

figure(3);clf;
scatter(x_eval(:,1),x_eval(:,2),50,yhat,'filled');colormap jet;colorbar
set(gca,'fontsize',20)
xlabel('feature 1');ylabel('feature 2')
title('$\hat{y}$ on evaluation data','interpreter','latex')

% Plot misclassified evaluation data

figure(4);clf;
scatter(x_eval(:,1),x_eval(:,2),50,1*(yhat~=y_eval),'filled');colormap cool
set(gca,'fontsize',20)
xlabel('feature 1');ylabel('feature 2')
title([num2str(sum(abs(yhat~=y_eval))),' errors $y\neq \hat{y}$  on evaluation data'...
   ],'interpreter','latex')

%% Part b) Classifier 2: sign(w1*x1^2 + w2*x2^2 + w3*x1 + w4*x2 + w5)

% Train classifier
Xaug = [ x_train.^2, x_train, ones(n_train,1)];
w = (inv(Xaug'*Xaug))*Xaug'*y_train;

% Predict labels using trained classifier
Xaug_eval = [ x_eval.^2, x_eval, ones(n_eval,1)];
yhat = sign(Xaug_eval*w);

% Plot yhat for evaluation data

figure(5);clf;
scatter(x_eval(:,1),x_eval(:,2),50,yhat,'filled');colormap jet;colorbar
set(gca,'fontsize',20)
xlabel('feature 1');ylabel('feature 2')
title('$\hat{y}$ on evaluation data','interpreter','latex')

% Plot misclassified evaluation data

figure(6);clf;
scatter(x_eval(:,1),x_eval(:,2),50,1*(yhat~=y_eval),'filled');colormap cool
set(gca,'fontsize',20)
xlabel('feature 1');ylabel('feature 2')
title([num2str(sum(abs(yhat~=y_eval))),' errors $y\neq \hat{y}$  on evaluation data'...
   ],'interpreter','latex')

%% Part c) 

% Create 1000 new training data points at (0,3) and give them label y=1
n_new = 1000;
x_train_outlier = [x_train; [zeros(n_new,1), 3*ones(n_new,1)]];
y_train_outlier = [y_train; ones(n_new,1)];

% Plot features and classes of training data
figure(7);clf;
scatter(x_train_outlier(:,1),x_train_outlier(:,2),50,y_train_outlier,'filled');colormap jet;colorbar
set(gca,'fontsize',20)
xlabel('feature 1');ylabel('feature 2')
title('Training data','interpreter','latex')

% Train classifier
w = (inv(x_train_outlier'*x_train_outlier))*x_train_outlier'*y_train_outlier;

% Predict labels using trained classifier
yhat = sign(x_eval*w);

% Plot yhat for evaluation data

figure(8);clf;
scatter(x_eval(:,1),x_eval(:,2),50,yhat,'filled');colormap jet;colorbar
set(gca,'fontsize',20)
xlabel('feature 1');ylabel('feature 2')
title('$\hat{y}$ on evaluation data','interpreter','latex')

% Plot misclassified evaluation data

figure(9);clf;
scatter(x_eval(:,1),x_eval(:,2),50,1*(yhat~=y_eval),'filled');colormap cool
set(gca,'fontsize',20)
xlabel('feature 1');ylabel('feature 2')
title([num2str(sum(abs(yhat~=y_eval))),' errors $y\neq \hat{y}$  on evaluation data'...
   ],'interpreter','latex')

