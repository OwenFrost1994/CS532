%%Assignment 8 Q2
clear
clc

load BreastCancer

%% a)
lam=[0,0.01,0.1,0.5,1.0,2.0,4.0,8.0,16.0,32.0,64.0];

Xtr=X(1:100,:);
ytr=y(1:100);

[m,n]=size(lam);

for i=1:1:n
    w(:,i)=ista_solve_hot(Xtr,ytr,lam(i));
    resi(i)=sum(abs(sign(Xtr*w(:,i))-ytr));
    normw(i)=norm(w(:,i),1);
end

figure(1)
plot(normw,resi,'-+','Markersize',7,'Markerface','white','linewidth',2.0)
hold on;
xlabel('||w||_1');
ylabel('||Aw-d||_2')
title('Residual and l1-norm of w under first 100 patients');
set(gca,'FontName','Times New Roman', 'FontSize', 24)
set(get(gca,'XLabel'),'FontName','Times New Roman','Fontsize',24)
set(get(gca,'YLabel'),'FontName','Times New Roman','Fontsize',24)

errrate=resi;
for i=1:1:n
    spar(i)=sum(w(:,i)~=0);
end
figure(2)
plot(spar,errrate,'-+','Markersize',7,'Markerface','white','linewidth',2.0)
hold on;
xlabel('Sparsity');
ylabel('Error rate(%)')
title('Error rate and sparsity of w under first 100 patients');
set(gca,'FontName','Times New Roman', 'FontSize', 24)
set(get(gca,'XLabel'),'FontName','Times New Roman','Fontsize',24)
set(get(gca,'YLabel'),'FontName','Times New Roman','Fontsize',24)

%% c)
Xte=X(101:295,:);
yte=y(101:295,:);
for i=1:1:n
    w(:,i)=ista_solve_hot(Xtr,ytr,lam(i));
    resic(i)=sum(abs(sign(Xte*w(:,i))-yte));
    normwc(i)=norm(w(:,i),1);
    sparc(i)=sum(w(:,i)~=0);
end
errratec=resic;
figure(3)
plot(normwc,resic,'-+','Markersize',7,'Markerface','white','linewidth',2.0)
hold on;
xlabel('||w||_1');
ylabel('||Aw-d||_2')
title('Residual and l1-norm of w under 101-295 patients');
set(gca,'FontName','Times New Roman', 'FontSize', 24)
set(get(gca,'XLabel'),'FontName','Times New Roman','Fontsize',24)
set(get(gca,'YLabel'),'FontName','Times New Roman','Fontsize',24)
figure(4)
plot(sparc,errratec,'-+','Markersize',7,'Markerface','white','linewidth',2.0)
hold on;
xlabel('Sparsity');
ylabel('Error rate(%)')
title('Error rate and sparsity of w under ');
set(gca,'FontName','Times New Roman', 'FontSize', 24)
set(get(gca,'XLabel'),'FontName','Times New Roman','Fontsize',24)
set(get(gca,'YLabel'),'FontName','Times New Roman','Fontsize',24)