clc 
clear all
close all
clc
clear all
close all
L=1;
Uo=1;
v=1;
A=1;
p=10;
N=10;
x =linspace(0,L,N);
a = -2+(p^(2)/N^(2))*ones(1,N);
b = ones(1,N);
c = ones(1,N);
f = ones(N,1)+2*(1/N)*v;
f(1)= v;
f(L)=0;

alpha(1)=a(1);
g(1)=f(1);
for j =2:N
    alpha(j)=a(j)-(b(j)/alpha(j-1))*c(j-1);
    g(j)=f(j) - (b(j)/alpha(j-1))*g(j-1);
end
u(N)=g(N)/alpha(N);

for k=1:N-1
    u(N-k)=(g(N-k)-c(N-k)*u(N-k))/(alpha(N-k))
end
for i=1:N
    m(i)=(1-(cosh(p*(x(i))))/cosh(p*L))*A/(p^(2))+v/p*sinh(p*(L-x(i)))/(cosh(p*L))
end
plot(u)
hold on
plot(m)