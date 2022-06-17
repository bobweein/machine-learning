%****************************************
%bestFeature.m
%****************************************
%获取最优划分属性
function [column] = bestFeature(tempdata)       %返回值double类型
    [~,n] = size(tempdata);
    featureSize = n - 1;%属性的个数
    gain_proc = cell(featureSize, 2);% 创建一个维度为（n-1）* 2的cell矩阵
    %entropy = getEntropy(data);
  
    
    % 计算各个属性的基尼指数
    for i = 1:featureSize
        gain_proc{i, 1} = i;
        gain_proc{i, 2} = getGiniIndex(tempdata, i);
        
    end
    %先设第一个属性的信息增益为最大值
    max = gain_proc{1,2};
    max_label = 1;
    % 采用冒泡的方式将所有属性的信息增益的最大值求解出来
    %并且记录属性对应的列数
    for i = 1:featureSize
        if gain_proc{i, 2} >= max
            max = gain_proc{i, 2};%这一步其实是多余的
            max_label = i;
        end
    end
    column = max_label;
end