function J=costfunction(X,theta,y,m,lambda)
h=hypothesisFunction(X*theta');
J=-1/m*( (y'*(log(h))) + ((1-y)'*(log(1-h))) )+lambda/(2*m)*(sum(theta.^2)-theta(1)^2);

   