%% Breast Cancer LASSO Exploration
%% Prepare workspace

close all
clear

load BreastCancer

%%  10-fold CV 

% each row of setindices denotes the starting an ending index for one
% partition of the data: 5 sets of 30 samples and 5 sets of 29 samples
setindices = [1,30;31,60;61,90;91,120;121,150;151,179;180,208;209,237;238,266;267,295];

% each row of holdoutindices denotes the partitions that are held out from
% the training set
holdoutindices = [1,2;2,3;3,4;4,5;5,6;7,8;9,10;10,1];

cases = size(holdoutindices,1);

% be sure to initiate the quantities you want to measure before looping
% through the various training, validation, and test partitions
%
% 
%
lam=[0,0.01,0.1,0.5,1.0,2.0,4.0,8.0,16.0,32.0,64.0];
[m,n]=size(lam);


% Loop over various cases
for j = 1:cases
    % row indices of first validation set
    v1_ind = setindices(holdoutindices(j,1),1):setindices(holdoutindices(j,1),2);
    
    % row indices of second validation set
    v2_ind = setindices(holdoutindices(j,2),1):setindices(holdoutindices(j,2),2);
    
    % row indices of training set
    trn_ind = setdiff(1:295,[v1_ind, v2_ind]);
    
    % define matrix of features and labels corresponding to first
    % validation set
    Av1 = X(v1_ind,:);
    bv1 = y(v1_ind);
    hn1=size(Av1,1);
    % define matrix of features and labels corresponding to second
    % validation set
    Av2 = X(v2_ind,:);
    bv2 = y(v2_ind);
    hn2=size(Av2,1);
    % define matrix of features and labels corresponding to the 
    % training set
    At = X(trn_ind,:);
    bt = y(trn_ind);
    % Loop over various lambda
    for i=1:1:n
        lam_vals=lam(i);
        [m]=size(At,2);
        % Use training data to learn classifier
        WL(:,i) = ista_solve_hot(At,bt,lam_vals);%w obtained in LASSO
        WR(:,i) = inv(At'*At+lam_vals*eye(m))*At'*bt;%w obtained in R-R
        errL(j,i)=norm(sign(Av1*WL(:,i))-bv1);
        errLr(j,i)=sum(abs(sign(Av1*WL(:,i))-bv1))/hn1;
        errR(j,i)=norm(sign(Av1*WR(:,i))-bv1);
        errRr(j,i)=sum(abs(sign(Av1*WR(:,i))-bv1))/hn1;
    end
    [seL,pL]=min(errL(j,:));
    blamL(j)=lam(pL);
    [seR,pR]=min(errR(j,:));
    blamR(j)=lam(pR);
    errbL(j)=norm(sign(Av2*WL(:,pL))-bv2);
    errbLr(j)=sum(abs(sign(Av2*WL(:,pL))-bv2))/hn2;
    errbR(j)=norm(sign(Av2*WR(:,pL))-bv2);
    errbRr(j)=sum(abs(sign(Av2*WL(:,pL))-bv2))/hn2;
%     j
%
% Find best lambda value using first validation set, then evaluate
% performance on second validation set, and accumulate performance metrics
% over all cases partitions
    
end

% Squard error of R-R solutions calculated with one hold-out set under different \lambda in eight training sets (columns are different \lambda)
errR

% Error rate of R-R solutions calculated with one hold-out set under different \lambda in eight training sets (columns are different \lambda)
errRr

% Squard error of LASSO solutions calculated with one hold-out set under different \lambda in eight training sets (columns are different \lambda)
errL

% Error rate of LASSO solutions calculated with one hold-out set under different \lambda in eight training sets (columns are different \lambda)
errLr

% Squard error of best R-R \lambda calculated with last hold-out set from eight training sets (columns are different training sets)
errbR

% Error rate of best R-R \lambda calculated with last hold-out set from eight training sets (columns are different training sets)
errbRr

% Squard error of best LASSO \lambda calculated with last hold-out set from eight training sets (columns are different training sets)
errbL

% Error rate of best LASSO \lambda calculated with last hold-out set from eight training sets (columns are different training sets)
errbLr