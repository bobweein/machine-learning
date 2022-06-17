


clear,close all
data = readcell('data.xlsx')  ; %读入数据集
feature =readcell('feature.xlsx') ;  %读入属性集
Node = createTree(data, feature);       %生成决策树
drawTree(Node)                          %绘制决策树

 

