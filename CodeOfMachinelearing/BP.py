import numpy as np

#定义网络结构
def layer_sizes(X,Y):
    '''
    input:
    X:训练输入
    Y:训练输出
    output:
    n_x:输入层大小
    n_h:隐藏层大小
    n_y:输出层大小
    '''
    n_x=X.shape[0]
    n_h=4
    n_y=Y.shape[0]
    return n_x,n_h,n_y

# 定义模型参数初始化函数
def initialize_parameters(n_x,n_h,n_y):
    '''
    输入：
    n_x:输入层神经元的个数
    n_h:隐藏层神经元的个数
    n_y:输出层神经元的个数
    输出
    parameters:初始化后的模型参数
    '''
    #权重系数随机初始化
    w1=np.random.randn(n_h,n_x)*0.1
    #偏置参数初始化
    b1=np.zeros((n_h,1))
    
    w2=np.random.randn(n_y,n_h)*0.01
    b2=np.zeros((n_y,1))
    #封装为字典
    parameters={"w1":w1,"b1":b1,"w2":w2,"b2":b2}
    return parameters

def sigmoid(z):
    return 1/(1+np.exp(-z))
#定义前向传播过程
def forward_propagation(X,parameters):
    '''
    input:
    X:训练输入
    paramerters:初始化的模型参数
    output:
    A2:模型的输出
    caches:前向传播过程计算的中间值缓存
    '''

    #获取个参数初始值
    w1=parameters["w1"]
    b1=parameters["b1"]
    w2=parameters["w2"]
    b2=parameters["b2"]

    #执行前向计算
    Z1=np.dot(w1,X)+b1
    A1=np.tanh(Z1)
    Z2=np.dot(w2,A1)+b2
    A2=sigmoid(Z2)
    #将中间结果封装为字典
    cache={"Z1":Z1,
            "A1":A1,
            "Z2":Z2,
            "A2":A2
    }
    return A2,cache


#定义损失函数
def compute_cost(A2,Y):
    '''
    input:
    A2:前向计算输出
    Y:训练标签
    output:
    cost:当前损失
    '''
    #训练样本量
    m=Y.shape[1]
    #计算交叉熵损失
    logprobs=np.multiply(np.log(A2),Y)+np.multiply(np.log(1-A2),1-Y)
    cost=-1/m*np.sum(logprobs)
    #维度压缩
    cost=np.squeeze(cost)
    return cost

#定义反向传播
def backward_propagation(parameters,cache,X,Y):
    '''
    input:
    parameters:神经网络参数字典
    cache:神经网络前向计算中缓存字典
    X:训练输入
    Y:训练输出
    output:
    grads:权重梯度字典
    '''
    #样本量
    m=X.shape[0]
    w1=parameters["w1"]
    w2=parameters["w2"]
    A1=cache["A1"]
    A2=cache["A2"]
    #执行反向传播
    dZ2=A2-Y
    dw2=1/m*np.dot(dZ2,A1.T)
    db2=1/m*np.sum(dZ2,axis=1,keepdims=True)
    dZ1=np.dot(w2.T,dZ2)*(1-np.power(A1,2))
    dw1=1/m*np.dot(dZ1,X.T)
    db1=1/m*np.sum(dZ1,axis=1,keepdims=True)
    #将权重封装成字典
    grads={"dw1":dw1,
            "db1":db1,
            "dw2":dw2,
            "db2":db2
    }
    return grads


def update_parameters(parameters,grads,learning_rate=1.2):
    '''
    input:
    parameters:神经网络参数字典
    grads:权重梯度字典
    learning_rate:学习率
    输出：
    parameters:更新后的权重字典
    '''

    #获取参数
    w1=parameters["w1"]
    b1=parameters["b1"]
    w2=parameters["w2"]
    b2=parameters["b2"]

    #获取梯度
    dw1=grads["dw1"]
    db1=grads["db1"]
    dw2=grads["dw2"]
    db2=grads["db2"]
    #参数更新
    w1-=dw1*learning_rate
    b1-=db1*learning_rate
    w2-=dw2*learning_rate
    b2-=db2*learning_rate
    #将更新后的权重封装为字典
    parameters={
        "w1":w1,
        "b1":b1,
        "w2":w2,
        "b2":b2
    }
    return parameters    

# 神经网络模型封装
def nn_model(X,Y,n_h,num_iterations=1000,print_cost=False):
    '''
    input:
    X:训练输入
    Y:训练输出
    n_h:隐藏层节点数
    num_iterrations:迭代次数
    print_cost:训练过程中是否打印损失函数
    output:
    parameters:神经网络训练优化后的权重参数
    '''
    #设置随机数种子
    np.random.seed(3)
    #输入和输出的节点数
    n_x=layer_sizes(X,Y)[0]
    n_y=layer_sizes(X,Y)[2]
    #初始化模型参数
    parameters=initialize_parameters(n_x,n_h,n_y)
    w1=parameters['w1']
    b1=parameters['b1']
    w2=parameters['w2']
    b2=parameters['b2']
    #梯度下降和参数的更新循环
    for i in range (0,num_iterations):
        #前向传播
        A2,cache=forward_propagation(X,parameters)
        #计算当前损失
        cost=compute_cost(A2,Y)
        #反向传播
        grads=backward_propagation(parameters,cache,X,Y)
        #参数更新
        parameters=update_parameters(parameters,grads,learning_rate=1.2)
        #打印损失
        if print_cost and i%1000==0:
            print("cost after iteration %i:%f"%(i,cost))

    return parameters

def create_dataset():
    '''
    input:

    output:
    X: 模拟数据集输入
    Y:模拟数据集输出

    '''
    #设置随机数种子
    np.random.seed(1)
    #数据量
    m=400
    #每个标签的实力数
    N=m//2
    #数据的维度
    D=2
    #数据矩阵
    X=np.zeros((m,D))
    #标签维度
    Y=np.zeros((m,1),dtype='uint8')
    a=4
    #遍历生成数据
    for j in range(2):
        ix=range(N*j,N*(j+1))
        #theta
        t=np.linspace(j*3.12,(j+1)*3.12,N)+np.random.randn(N)*0.2
        #radius
        r=a*np.sin(4*t)+np.random.randn(N)*0.2
        X[ix]=np.c_[r*np.sin(t),r*np.cos(t)]
        Y[ix]=j
    X=X.T
    Y=Y.T
    return X,Y

def main():
    X,Y=create_dataset()
    parameters=nn_model(X,Y,n_h=4,num_iterations=10000,print_cost=True)

main()