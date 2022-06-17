function th = normalEqn(X, y)
th=pinv(X'*X)*X'*y;
