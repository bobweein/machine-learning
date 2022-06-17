%****************************************
%createTree.m
%****************************************
%生成决策树ID3算法
%data：训练集
%feature：属性集
function [node] = createTree(data, feature)
    type = mostType(data);  %cell类型
    [m, n] = size(data);
    %生成节点node
    %value：分类结果，若为null则表示该节点是分支节点
    %name：节点划分属性
    %branch：节点属性值
    %children：子节点
    node = struct('value','null','name','null','branch','null','children',{});
    temp_type = data{1, n};
    temp_b = true;
    %检测data中是否全为同一分类结果
    for i = 1 : m
        if temp_type ~= data{i, n}
            temp_b = false;
        end
    end
    %样本中全为同一分类结果，则node节点为叶节点
    if temp_b == true
        node(1).value = data(1, n); %cell类型  为”是“和”否“中的一个
        return;
    end
    %属性集合为空，将结果标记为样本中最多的分类
    if isempty(feature) == 1
        node.value = type;  %cell类型
        return;
    end
    %使用备用cell数组tempdata复制data，然后将tempdata中连续值列转换为离散值  
    %要注意保持tempdata和data的顺序是一样的
    [tempdata,data]=datachange(data);
    
    %获取最优划分属性
    feature_bestColumn = bestFeature(tempdata); %最优属性列数，double类型   %写到此处
    %下面的代码还没有修改
    best_feature = tempdata(:,feature_bestColumn); %最优属性列，cell类型   
    % 上面两行需要改变  计算出划分点后 改变一下cell中的数据  先复制数组再改变值  
    best_distinct = unique(best_feature); %最优属性取值（去重）
    best_num = length(best_distinct); %最优属性取值个数
    best_proc = cell(best_num, 2);%cell数组
    best_proc(:, 1) = best_distinct(:, 1);%最优属性可能的取值组成的列
    best_proc(:, 2) = num2cell(zeros(best_num, 1));% 维度为 最优属性可能的取值的个数*1 的零矩阵  转化cell矩阵
    %best_proc（：2）中放的东西是
    %循环该属性的每一个值
    for i = 1:best_num
        %为node创建一个bach_node分支，设样本data中该属性值为best_proc(i, 1)的集合为Dv
        bach_node = struct('value', 'null', 'name', 'null', 'branch', 'null', 'children',{});
        Dv_index = 0;
        %计算data中等于最优属性的当前取值的样本的个数
        for j = 1:m
            if tempdata{j, feature_bestColumn} == best_proc{i, 1}
                Dv_index = Dv_index + 1;
            end
        end
        
        %为Dv创建cell数组  Dv 等于该属性当前的取值的样例组成的集合
        Dv = cell(Dv_index, n);
        %记录Dv集合中元素的个数
        Dv_index2 = 1;
        %将data中属性值等于最有属性当前取值的数据放入Dv中，组成集合
        for j = 1:m
            if best_proc{i, 1} == tempdata{j, feature_bestColumn}
                Dv(Dv_index2, :) = data(j, :);%此处要将data数据导入Dv中，这里tempdata 和data的顺序好像时不一样的
                Dv_index2 = Dv_index2 + 1;
            end
        end
        %先将集合Dv的属性等于data的属性（后面要去除data中当前最优化分属性）
        Dfeature = feature;
        %Dv为空则将结果标记为样本中最多的分类  
        if isempty(Dv) == 1
            bach_node.value = type;
            bach_node.name = feature(feature_bestColumn);
            bach_node.branch = best_proc(i, 1);
            node.children(i) = bach_node;
            return;
        else
            Dfeature(feature_bestColumn) = [];%去除data中当前最优划分属性
            Dv(:,feature_bestColumn) = [];%集合Dv中属性等于data最优化分属性的列去掉
            %递归调用createTree方法
            bach_node = createTree(Dv, Dfeature);
            bach_node(1).branch = best_proc(i, 1);
            bach_node(1).name = feature(feature_bestColumn);
            node(1).children(i) = bach_node;%与父节点连接
        end
    end
end

        