%binary classifier
a1=1;
a2=2;
b=1;
N=5000;
%%generate data points
P=random('Normal',2,2,N,2);
Label=sign(a1*P(:,1)+a2*P(:,2)-b);
