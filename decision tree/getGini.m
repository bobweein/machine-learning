%****************************************
%getEntropy.m
%****************************************
%计算基尼值
function [entropy] = getGini(tempdata)       %返回值double类型
    entropy = 1;
    [m,n] = size(tempdata);
    label = tempdata(:, n);%标签
    label_distinct = unique(label);%标签去重
    label_num = length(label_distinct);%去重后的标签个数
    proc = cell(label_num,2);%创建一个cell 
    proc(:, 1) = label_distinct(:, 1);
    proc(:, 2) = num2cell(zeros(label_num, 1));
    % 计算在当前样本中第k类样本所占的比例为pk  （样本中各个标签所占的比例）
   
    for i = 1:label_num
        for j = 1:m
            if proc{i, 1} == tempdata{j, n}
                proc{i, 2} = proc{i, 2} + 1;
            end
        end
        proc{i, 2} = proc{i, 2} / m;
    end
    %计算基尼值
     for i = 1:label_num
        entropy = entropy - proc{i, 2}*proc{i,2};
     end
end