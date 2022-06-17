function [theta,J]=gradientDescent(X,y,theta,m,alpha,iterations,lambda)
J=zeros(1,iterations);
n=length(theta);
h=zeros(1,m);
for i=1:1:iterations
     for j=1:1:n
         temp=0;
         for k=1:1:m
            h(k)=hypothesisFunction(X(k,:)*theta');
            temp=temp+alpha/m*(h(k)-y(k))*X(k,j); 
         end
         if j==1
             theta(j)=theta(j)-temp;
         else 
             theta(j)=theta(j)*(1-alpha*lambda/m)-temp;
         end
     end
    J(i)=costfunction(X,theta,y,m,lambda);
end