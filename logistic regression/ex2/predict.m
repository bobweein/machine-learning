function p = predict(theta, X)
m=length(X(:,1));
temp=(X * theta);
for i=1:1:m
    if temp(i)>=0
        p(i)=1;
    else
        p(i)=0;
    end
end
p=p';