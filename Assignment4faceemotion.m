%%learning and classifying faces
clear
clc
close all
warning off

load('face_emotion_data.mat');

%% a) calculate weight
[m,n]=size(X);

w=inv(X'*X)*X'*y;

R=rank(X);

%% c)verify the most significant features with light-weighted features removed
X1=[X(:,1:4) X(:,7) X(:,9)];
w1=[w(1:4);w(7);w(9)];
y1=sign(X1*w1);
Error=m-sum(y1==y);

%% e) calculate wrongly classfied label and percentage
%9 features
y2=sign(X*w);
Error1=m-sum(y2==y);
Errorp1=100*Error1/m;

%3 features directly selected
X3=[X(:,1) X(:,3) X(:,4)];
w3=inv(X3'*X3)*X3'*y;
y3=sign(X3*w3);
Error3=m-sum(y3==y);
Errorp3=100*Error3/m;

%3 features selected step by step
X4=X;
w4=w;
for i=1:1:6
    mn=find(w4==min(w4));
    X4(:,mn)=[];
    w4=inv(X4'*X4)*X4'*y;
end
y4=sign(X4*w4);
Error4=m-sum(y4==y);
Errorp4=100*Error4/m;

%3 features selected with preprocess
X5=[X(:,1) w(2)*X(:,2)+w(3)*X(:,3) X(:,4:6) w(7)*X(:,7)+w(9)*X(:,9) X(:,8)];
w5=inv(X5'*X5)*X5'*y;
for i=1:1:4
    mn=find(w5==min(w5));
    X5(:,mn)=[];
    w5=inv(X5'*X5)*X5'*y;
end
y5=sign(X5*w5);
Error5=m-sum(y5==y);
Errorp5=100*Error5/m;

%% f) cross validation
Errorts=0;
Xt=X5;
ytt=y;
for i=1:1:8
    Xt(16*(i-1)+1:16*i,:)=[];
    ytt(16*(i-1)+1:16*i)=[];
    wt=inv(Xt'*Xt)*Xt'*ytt;
    yt(:,i)=sign(X5(16*(i-1)+1:16*i,:)*wt);
    Errort(i)=16-sum(yt(:,i)==y(16*(i-1)+1:16*i));
    Errorp(i)=100*Errort(i)/16;
    Xt=X5;
    ytt=y;
end
Errorpa=sum(Errorp)/8;