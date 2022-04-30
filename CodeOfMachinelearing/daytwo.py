#导入库
import pandas as pd 
import numpy as np 
import matplotlib.pyplot as plt
#读取数据
dataset=pd.read_csv("C:\\Users\\c2752\\Desktop\\MachineLearning\\CodeOfMachinelearing\\studentscores.csv")
X=dataset.iloc[:,:-1].values
Y=dataset.iloc[:,1].values
#划分数据集
from sklearn.model_selection import train_test_split 
X_train,X_test,Y_train,Y_test=train_test_split(X,Y,test_size=1/4,random_state=0)
#导入线性模型
from sklearn.linear_model import LinearRegression
regressor=LinearRegression()
regressor=regressor.fit(X_train,Y_train)
#预测值
Y_pred=regressor.predict(X_test)
#画图（训练集）
plt.scatter(X_train,Y_train,color='red')
plt.plot(X_train,regressor.predict(X_train),color='blue')
plt.show()
#画图（测试集）
plt.scatter(X_test,Y_test,color='red')
plt.plot(X_test,regressor.predict(X_test),color='blue')

plt.show()