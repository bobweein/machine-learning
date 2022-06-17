function price=predictnormalEqn (X,y,x)
price=x*pinv(X'*X)*X'*y;