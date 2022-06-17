function plotData(X, y)
pos=find(y==1);
neg=find(y==0);
plot(X(pos,1),X(pos,2),'b+','LineWidth',2,'MarkerSize',7);
hold on
plot(X(neg,1),X(neg,2),'ro','MarkerFaceColor','y','MarkerSize',7);