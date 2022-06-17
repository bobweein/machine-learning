%% Initialization
clear ; close all; clc
load ('dataset1.txt');
load('dataset2.txt');
%y为真实值
y=[dataset1(:,3);dataset2(:,3)];
%X 为特征
X=[dataset1(:,[1,2]); dataset2(:,[1,2])];
% 先画图观察以下分布
plotData(X,y);
hold on
fprintf('press any key to continue。\n')
pause;
% 初始化X theta
m=length(y);
X=mapFeature(X(:,1),X(:,2));
theta=zeros(1,size(X,2));

%learning rate --alpaha
alpha=1.6;
% iterations 迭代次数
iterations=5000;
% lambda 设置正则化参数
lambda =0.0090;
%开始使用gradient descent
[theta,J]=gradientDescent(X,y,theta,m,alpha,iterations,lambda);
fprintf('\ntheta:\n');
fprintf('%f\n',theta(1,1:5));
pause;
%将决策边界画出来
plotDecisionBoundary(theta, X, y);
% 将梯度下降法过程中的J关于迭代次数的函数图像画出来
figure;
Jx=1:1:length(J);
plot(Jx,J,'r--o','lineWidth',0.01,'MarkerSize',0.5);
xlabel('iteration');
ylabel('J');
pause;

