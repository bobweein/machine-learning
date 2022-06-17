function [cost, grad] = costFunction(theta, X, y)
m=length(y);
h=sigmoid(theta'*X');
cost=-1/m*( (y'*(log(h))') + ((1-y)'*(log(1-h))') );
grad=1/m*X'*(h'-y);