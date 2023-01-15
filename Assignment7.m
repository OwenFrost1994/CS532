clc
clear
close all

%% a) generate A with n and k
x=csvread('xsignal.csv');
k=30;

[n,m]=size(x);
A=eye(n);
for i=1:1:k-1
    A=A+diag(ones(n-i,1),-i);
end

%% b) generate w and b
sig1=0.01;
sig2=0.1;
w1=sig1*randn(n,1);
w2=sig2*randn(n,1);
b1=A*x+w1;
b2=A*x+w2;

figure(1)
plot(1:n,x,'Markersize',7,'Markerface','white','linewidth',2.0)
hold on;
plot(1:n,b1,'-.r','Markersize',7,'Markerface','white','linewidth',1.0)
hold on;
plot(1:n,b2,'--y','Markersize',7,'Markerface','white','linewidth',1.0)
hold on;
grid on;
xlabel('t');
ylabel('Signal');
legend('x',strcat('b \sigma=',num2str(sig1)),strcat('b \sigma=',num2str(sig2)));
title('Original signals and noisy signals');
set(gca,'FontName','Times New Roman', 'FontSize', 24)
set(get(gca,'XLabel'),'FontName','Times New Roman','Fontsize',24)
set(get(gca,'YLabel'),'FontName','Times New Roman','Fontsize',24)
set(gcf, 'position', [800 100 1000 1000]);

%% c) reconstruct x and compare with original x
%i) Ordinary L-S
xLS1=inv(A'*A)*A'*b1;
xLS2=inv(A'*A)*A'*b2;
figure(2)
plot(1:n,x,'Markersize',7,'Markerface','white','linewidth',2.0)
hold on;
plot(1:n,xLS1,'--r','Markersize',7,'Markerface','white','linewidth',1.0)
hold on;
plot(1:n,xLS2,'-.b','Markersize',7,'Markerface','white','linewidth',1.0)
hold on;
xlabel('t');
ylabel('Signal');
legend('x',strcat('b \sigma=',num2str(sig1)),strcat('b \sigma=',num2str(sig2)));
title('Ordinary L-S solutions');
set(gca,'FontName','Times New Roman', 'FontSize', 24)
set(get(gca,'XLabel'),'FontName','Times New Roman','Fontsize',24)
set(get(gca,'YLabel'),'FontName','Times New Roman','Fontsize',24)
set(gcf, 'position', [800 100 1000 1000]);

%ii) Truncated SVD
[U,S,V]=svd(A);
m=[10,20,40,60,80,100,150,200,250,300,350,400];%because A is a triangular matrix that is full tank, m must be chosen in a large area 
for i=1:1:size(m,2)
    xTSVD1(:,i)=V(:,1:m(i))*inv(S(1:m(i),1:m(i)))*U(:,1:m(i))'*b1;
    xTSVD2(:,i)=V(:,1:m(i))*inv(S(1:m(i),1:m(i)))*U(:,1:m(i))'*b2;
end

for i=1:1:size(m,2)
    figure(3)
    subplot(2,ceil(size(m,2)/2),i)
    plot(1:n,x,'Markersize',7,'Markerface','white','linewidth',2.0)
    hold on;
    plot(1:n,xTSVD1(:,i),'--r','Markersize',7,'Markerface','white','linewidth',1.0)
    hold on;
    legend('x',strcat('x_S_V_D m=',num2str(m(i))))
    xlabel('t');
    ylabel('Signal');
    set(gca,'FontName','Times New Roman', 'FontSize', 24)
    set(get(gca,'XLabel'),'FontName','Times New Roman','Fontsize',24)
    set(get(gca,'YLabel'),'FontName','Times New Roman','Fontsize',24)
end
figure(3)
subplot(2,ceil(size(m,2)/2),3)
title(strcat('Truncated SVD solutions (\sigma=',num2str(sig1),' for w)'))
set(gcf, 'position', [0 0 4000 4000]);

for i=1:1:size(m,2)
    figure(4)
    subplot(2,ceil(size(m,2)/2),i)
    plot(1:n,x,'Markersize',7,'Markerface','white','linewidth',2.0)
    hold on;
    plot(1:n,xTSVD2(:,i),'--r','Markersize',7,'Markerface','white','linewidth',1.0)
    hold on;
    legend('x',strcat('x_S_V_D m=',num2str(m(i))))
    xlabel('t');
    ylabel('Signal');
    set(gca,'FontName','Times New Roman', 'FontSize', 24)
    set(get(gca,'XLabel'),'FontName','Times New Roman','Fontsize',24)
    set(get(gca,'YLabel'),'FontName','Times New Roman','Fontsize',24)
end
figure(4)
subplot(2,ceil(size(m,2)/2),3)
title(strcat('Truncated SVD solutions (\sigma=',num2str(sig2),' for w)'))
set(gcf, 'position', [0 0 4000 4000]);


%iii)Regularizd
v=[0,0.1,2,2^2,2^4,2^8];
for i=1:1:size(v,2)
    xR1(:,i)=inv(A'*A+v(i)*eye(n))*A'*b1;
    xR2(:,i)=inv(A'*A+v(i)*eye(n))*A'*b2;
end

for i=1:1:size(v,2)
    figure(5)
    subplot(2,ceil(size(v,2)/2),i)
    plot(1:n,x,'Markersize',7,'Markerface','white','linewidth',2.0)
    hold on;
    plot(1:n,xR1(:,i),'--r','Markersize',7,'Markerface','white','linewidth',1.0)
    hold on;
    legend('x',strcat('x_R \lambda=',num2str(v(i))))
    xlabel('t');
    ylabel('Signal');
    set(gca,'FontName','Times New Roman', 'FontSize', 24)
    set(get(gca,'XLabel'),'FontName','Times New Roman','Fontsize',24)
    set(get(gca,'YLabel'),'FontName','Times New Roman','Fontsize',24)
end
figure(5)
subplot(2,ceil(size(v,2)/2),ceil(size(v,2)/4))
title(strcat('Regularized L-S solutions (\sigma=',num2str(sig1),' for w)'))
set(gcf, 'position', [0 0 4000 4000]);

for i=1:1:size(v,2)
    figure(6)
    subplot(2,ceil(size(v,2)/2),i)
    plot(1:n,x,'Markersize',7,'Markerface','white','linewidth',2.0)
    hold on;
    plot(1:n,xR2(:,i),'--r','Markersize',7,'Markerface','white','linewidth',1.0)
    hold on;
    legend('x',strcat('x_R \lambda=',num2str(v(i))))
    xlabel('t');
    ylabel('Signal');
    set(gca,'FontName','Times New Roman', 'FontSize', 24)
    set(get(gca,'XLabel'),'FontName','Times New Roman','Fontsize',24)
    set(get(gca,'YLabel'),'FontName','Times New Roman','Fontsize',24)
end
figure(6)
subplot(2,ceil(size(v,2)/2),ceil(size(v,2)/4))
title(strcat('Regularized L-S solutions (\sigma=',num2str(sig2),' for w)'))
set(gcf, 'position', [0 0 4000 4000]);


%% d) Experiments
%i)Experiment with different degrees of averaging k
% here k varying from 1 to 121 with step 30 will be test, at the same time,
% truncated rank m will vary from 50 to 500 with step 50
% the ? of w is fixed at 0.1
kini=1;
kend=41;
kstep=10;
kcir=(kend-kini)/kstep+1;
mini=50;
mend=500;
mstep=50;
mcir=(mend-mini)/mstep+1;

for i=1:1:kcir
    k=kstep*(i-1)+kini;
    A=eye(n);
    for a=1:1:k-1
        A=A+diag(ones(n-a,1),-a);
    end
    [U,S,V]=svd(A);
    for j=1:1:mcir
        m=mstep*(j-1)+mini;
        xTSVDE(:,10*(i-1)+j)=V(:,1:m)*inv(S(1:m,1:m))*U(:,1:m)'*b2;
        figure(6+i)
        subplot(2,ceil(mcir/2),j)
        plot(1:n,x,'Markersize',7,'Markerface','white','linewidth',2.0)
        hold on;
%         plot(1:n,b2,'Color', [1 0.5 0],'Markersize',7,'Markerface','white','linewidth',2.0)
%         hold on;
        plot(1:n,xTSVDE(:,10*(i-1)+j),'--r','Markersize',7,'Markerface','white','linewidth',1.0)
        hold on;
        legend('x','x_E')
%         legend('x','b','x_E')
        xlabel(strcat('m=',num2str(m)));
        ylabel('Signal');
%         ylim([min(b2) max(b2)]);
        set(gca,'FontName','Times New Roman', 'FontSize', 24)
        set(get(gca,'XLabel'),'FontName','Times New Roman','Fontsize',24)
        set(get(gca,'YLabel'),'FontName','Times New Roman','Fontsize',24)
    end
    figure(6+i)
    subplot(2,ceil(mcir/2),ceil(mcir/4))
    title(strcat('Truncated SVD solutions under differen k (k=',num2str(k),', \sigma=0.1 for w)'))
    set(gcf, 'position', [0 0 4000 4000]);
end

% regularization parameters will vary from below range
v=[0,0.1,2,2^2,2^3,2^4,2^5,2^6,2^7,2^8];
vcir=size(v,2);
for i=1:1:kcir
    k=kstep*(i-1)+kini;
    for j=1:1:vcir
        xRE(:,10*(i-1)+j)=inv(A'*A+v(j)*eye(n))*A'*b2;
        figure(6+kcir+i)
        subplot(2,ceil(vcir/2),j)
        plot(1:n,x,'Markersize',7,'Markerface','white','linewidth',2.0)
        hold on;
%         plot(1:n,b2,'Color', [1 0.5 0],'Markersize',7,'Markerface','white','linewidth',2.0)
%         hold on;
        plot(1:n,xRE(:,10*(i-1)+j),'--r','Markersize',7,'Markerface','white','linewidth',1.0)
        hold on;
        legend('x','x_E')
%         legend('x','b','x_E')
        xlabel(strcat('\lambda=',num2str(v(j))));
        ylabel('Signal');
%         ylim([min(b2) max(b2)]);
        set(gca,'FontName','Times New Roman', 'FontSize', 24)
        set(get(gca,'XLabel'),'FontName','Times New Roman','Fontsize',24)
        set(get(gca,'YLabel'),'FontName','Times New Roman','Fontsize',24)
    end
    figure(6+kcir+i)
    subplot(2,ceil(mcir/2),ceil(mcir/4))
    title(strcat('Regularized L-S solutions under differen k (k=',num2str(k),', \sigma=0.1 for w)'))
    set(gcf, 'position', [0 0 4000 4000]);
end

%ii)Experiment with different degrees of noise levels ?
% here ? varying as an exponential function of 10 from 10^-4 to 10^0
% truncated rank m will vary from 50 to 500 with step 50
%k is fixed at 30
k=30;
for a=1:1:k-1
    A=A+diag(ones(n-a,1),-a);
end
[U,S,V]=svd(A);

sini=10^-4;%? initial
send=10^0;
sstep=1;
scir=(log10(send)-log10(sini))/sstep+1;
for i=1:1:scir
    sig=sini*10^(i-1);
    be=A*x+sig*randn(n,1);
    for j=1:1:mcir
        m=mstep*(j-1)+mini;
        xTSVDES(:,10*(i-1)+j)=V(:,1:m)*inv(S(1:m,1:m))*U(:,1:m)'*be;
        figure(6+2*kcir+i)
        subplot(2,ceil(mcir/2),j)
        plot(1:n,x,'Markersize',7,'Markerface','white','linewidth',2.0)
        hold on;
        plot(1:n,xTSVDES(:,10*(i-1)+j),'--r','Markersize',7,'Markerface','white','linewidth',1.0)
        hold on;
        legend('x','x_E')
        xlabel(strcat('m=',num2str(m)));
        ylabel('Signal');
        set(gca,'FontName','Times New Roman', 'FontSize', 24)
        set(get(gca,'XLabel'),'FontName','Times New Roman','Fontsize',24)
        set(get(gca,'YLabel'),'FontName','Times New Roman','Fontsize',24)
    end
    figure(6+2*kcir+i)
    subplot(2,ceil(mcir/2),ceil(mcir/4))
    title(strcat('Truncated SVD solutions under different \sigma (sigma=',num2str(sig),', k=30)'))
    set(gcf, 'position', [0 0 4000 4000]);
end

% regularization parameters are same as d) i)
for i=1:1:scir
    sig=sini*10^(i-1);
    be=A*x+sig*randn(n,1);
    for j=1:1:vcir
        xRES(:,10*(i-1)+j)=inv(A'*A+v(j)*eye(n))*A'*be;
        figure(6+2*kcir+scir+i)
        subplot(2,ceil(vcir/2),j)
        plot(1:n,x,'Markersize',7,'Markerface','white','linewidth',2.0)
        hold on;
        plot(1:n,xRES(:,10*(i-1)+j),'--r','Markersize',7,'Markerface','white','linewidth',1.0)
        hold on;
        legend('x','x_E')
        xlabel(strcat('\lambda=',num2str(v(j))));
        ylabel('Signal');
        set(gca,'FontName','Times New Roman', 'FontSize', 24)
        set(get(gca,'XLabel'),'FontName','Times New Roman','Fontsize',24)
        set(get(gca,'YLabel'),'FontName','Times New Roman','Fontsize',24)
    end
    figure(6+2*kcir+scir+i)
    subplot(2,ceil(vcir/2),ceil(vcir/4))
    title(strcat('Regularized L-S solutions under differen \sigma (\sigma=',num2str(sig),', k=30)'))
    set(gcf, 'position', [0 0 4000 4000]);
end