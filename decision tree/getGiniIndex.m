%****************************************
%getGiniIndex.m
%****************************************
%计算信息增益
function [gini] = getGiniIndex(tempdata, column)        %返回值double类型
    [m,n] = size(tempdata);
    feature = tempdata(:, column);%某一列属性值
    feature_distinct = unique(feature);%当前属性可能的取值（去重）
    feature_num = length(feature_distinct);%当前属性可能的值的个数
    feature_proc = cell(feature_num, 2);
    feature_proc(:, 1) = feature_distinct(:, 1);
    feature_proc(:, 2) = num2cell(zeros(feature_num, 1));%这一列来存储属性当前取值所包含的的样例个数
    %f_entropy = 0;  这行是不需要的
    gini=0;
    % 计算
    for i = 1:feature_num
        % 属性的某一个取值所包含的样例数
       feature_row = 0;
       %计算属性中某个可能的取值所包含的样例的个数
       for j = 1:m
           if feature_proc{i, 1} == tempdata{j, column}
               feature_proc{i, 2} = feature_proc{i, 2} + 1;
               feature_row = feature_row + 1;
           end
       end
       feature_data = cell(feature_row,n);% 维度为  属性的某一个取值所包含的样例数* n
       feature_row = 1;
       %这个循环将data中属性的取值于当前属性的去相同的行赋给feature_data
       for j = 1:m
           if feature_distinct{i, 1} == tempdata{j, column}
               feature_data(feature_row, :) = tempdata(j, :);
               feature_row = feature_row + 1;
           end
       end
       %计算某一属性的基尼指数
        gini=  gini+ feature_proc{i, 2} / m * getGini(feature_data);
    end
%     %计算信息增益
%     gain = entropy - f_entropy;
end