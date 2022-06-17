function theta = gradientDescent(X, y, theta, alpha, iterations)
i=0;
m=length(X);
while i<iterations
    theta=theta-alpha/m.*X'*(X*theta-y);
    i=i+1;
end