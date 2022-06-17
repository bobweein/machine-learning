function [theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);
i=1;
m=length(X);
J_history=zeros(num_iters,1);
while i<=num_iters
    theta=theta-alpha/m.*X'*(X*theta-y);
    J_history(i)=computeCostMulti(X,y,theta);
    i=i+1;
end