#导入库
import pandas as pd
import numpy as np
# 导入数据
dataset =pd.read_csv("C:\\Users\\c2752\\Desktop\\MachineLearning\\CodeOfMachinelearing\\50_Startups.csv")
X=dataset.iloc[:,:-1].values
Y=dataset.iloc[:,4].values

# 将分类数据转变计算可以进行数学计算的数据
from sklearn.preprocessing import LabelEncoder,OneHotEncoder
labelencoder=LabelEncoder()
X[:,3]=labelencoder.fit_transform(X[:,3])
#np.savetxt("./XbeforeEncoding.txt",X,fmt='%d')
onehotencoder=OneHotEncoder(categories="auto")
X=onehotencoder.fit_transform(X).toarray()
print(X.shape)
#np.savetxt("./XafterEncoding.txt",X,fmt='%d')

#躲避虚拟陷阱
X=X[:,1:]#为什么消去第0列就能够躲避虚拟陷阱。
print(X.shape)

#拆分数据及为训练集和测试集
from sklearn.model_selection import train_test_split
X_train,X_test,Y_train,Y_test=train_test_split(X,Y,test_size=0.2,random_state=0)

#在训练集上训练多元线性回归模型
from sklearn.linear_model import LinearRegression
regressor=LinearRegression()
regressor.fit(X_train,Y_train)


#在测试集上预测结果
y_pred=regressor.predict(X_test)
# print("y_pred:",y_pred)
# print("Y_test:",Y_test)
# lost=Y_test-y_pred
# print(lost)