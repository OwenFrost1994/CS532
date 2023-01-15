clear
clc
close all
% load polydata;
% 
% [m,n]=size(a);
% A1=[ones(m,n) a];
% x1=inv(A1'*A1)*A1'*b;
% 
% A2=[ones(m,n) a a.^2];
% x2=inv(A2'*A2)*A2'*b;
% 
% A3=[ones(m,n) a a.^2 a.^3];
% x3=inv(A3'*A3)*A3'*b;
% 
% x=min(a):0.001:max(a);
% y1=x1(1)+x1(2)*x;
% y2=x2(1)+x2(2)*x+x2(3)*x.^2;
% y3=x3(1)+x3(2)*x+x3(3)*x.^2+x3(4)*x.^3;
% 
% figure(1)
% plot(a,b,'ob','Markersize',7,'Markerface','white','linewidth',1.0);
% hold on;
% plot(x,y1,'--r','Markersize',7,'Markerface','white','linewidth',1.0);
% hold on;
% plot(x,y2,'-.r','Markersize',7,'Markerface','white','linewidth',1.0);
% hold on;
% plot(x,y3,'-r','Markersize',7,'Markerface','white','linewidth',1.0);
% hold on;
% xlabel('a')
% ylabel('b')
% set(gca,'FontName','Times New Roman', 'FontSize', 24)
% set(get(gca,'XLabel'),'FontName','Times New Roman','Fontsize',24)
% set(get(gca,'YLabel'),'FontName','Times New Roman','Fontsize',24)
% legend('test data','p=1 fitting','p=2 fitting','p=3 fitting')

load movie
format rat;
X1=gram_schmidt([ones(5,1) X]);
A=mean(X);
A1=max(X);
