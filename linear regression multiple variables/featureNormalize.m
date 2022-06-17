function [X ,mu ,sigma] = featureNormalize(X)
mu=mean(X);
sigma=std(X);
X=(X-mu)./sigma;

