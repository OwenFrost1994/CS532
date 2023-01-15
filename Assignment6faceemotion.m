clear
clc
close all
warning off

load('face_emotion_data.mat');

%truncated SVD for finnding best r
Er=zeros(9,8,8);
Pr=zeros(9,8,8);
for r=1:1:9
for i=1:1:8
    for j=1:1:8
        if i~=j
            Xt=X;
            yt=y;
            Xer=X(16*(i-1)+1:16*i,:);
            yer=y(16*(i-1)+1:16*i);
            Xp=X(16*(j-1)+1:16*j,:);
            yp=y(16*(j-1)+1:16*j);
            if i<j %remove testing set and set for calculating performance
                Xt(16*(i-1)+1:16*i,:)=[];
                Xt(16*(j-2)+1:16*(j-1),:)=[];
                yt(16*(i-1)+1:16*i)=[];
                yt(16*(j-2)+1:16*(j-1))=[];
            else
                Xt(16*(i-1)+1:16*i,:)=[];
                Xt(16*(j-1)+1:16*j,:)=[];
                yt(16*(i-1)+1:16*i)=[];
                yt(16*(j-1)+1:16*j)=[];
            end
            [U,S,V]=svd(Xt,'econ');
            w=V(:,1:r)*inv(S(1:r,1:r))*U(:,1:r)'*yt;
            Er(r,i,j)=(16-sum(sign(Xer*w)==yer))/16;
            Pr(r,i,j)=(16-sum(sign(Xp*w)==yp))/16;
        else
        end
    end
end
end
for i=1:1:9
    A=Er(i,:,:);
    E(i)=sum(A(:))/56;
end

figure(1)
plot(1:1:9,E,'r-+', 'LineWidth', 3)
grid on
xlabel('r')
ylabel('Ave error rate')
title('Ave error rate for different r(56 held-out comnination for each r)')


A=Pr(5,:,:);
for j=1:1:8
    P(j)=sum(Pr(5,:,j))/7;%for each set of second held-out set 7 other choices for first held-out set are avaliable
end

figure(2)
plot(1:1:8,P,'b-+', 'LineWidth', 3)
xlabel('Remaining Data set No.')
ylabel('Ave error rate')
grid on;
title('Ave error rate in last held-out data set(r=5)')

%% R-R
K=[0,2^-1,2^0,2^1,2^2,2^3,2^4];
for i=1:1:7
    for j=1:1:8
        Xt=X;
        yt=y;
        Xt(16*(j-1)+1:16*j,:)=[];
        yt(16*(j-1)+1:16*j)=[];
        Xer=X(16*(j-1)+1:16*j,:);
        yer=y(16*(j-1)+1:16*j);
        [U,S,V]=svd(Xt,'econ');
        D=inv(S^2+K(i)*eye(size(S)))*S;
        Ww=V(:,1:5)*D(1:5,1:5)*U(:,1:5)'*yt;
        Err(i,j)=sum(abs(yer-sign(Xer*Ww)))/32;
        Nw(i,j)=K(i)*norm(Ww,2)^2;
    end
end
Errp=sum(Err,2)/8;
Nwp=sum(Nw,2)/8;
figure(3)
plot(1:1:7,Errp,'r-+', 'LineWidth', 3)
hold on;
grid on;
xlabel('\lambda No.')
ylabel('Ave error rate')
title('Ave error rate in held-out data set for different \lambda(r=5)')

figure(4)
plot(1:1:7,Nwp,'b-+', 'LineWidth', 3);
hold on;
grid on;
xlabel('\lambda No.')
ylabel('\lambda*||w||2^2')
title('The \lambda*||w||2^2 for different \lambda(r=5)')
