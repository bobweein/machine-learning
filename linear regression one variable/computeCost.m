function cost=computeCost(X,y,theta)
m=length(y);
cost=1/(2*m)*((y-X*theta)'*(y-X*theta));
