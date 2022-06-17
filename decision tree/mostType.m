%****************************************
%mostType.m
%****************************************
%计算样本最多的结果
function [res] = mostType(data)         %返回值cell类型
    [m,n] = size(data);
    res = data(:, n);%最后一列，所有的行
    res_distinct = unique(res);% 标签y  ”是“  ”否“
    res_num = length(res_distinct);%标签的长度
    res_proc = cell(res_num,2);
    res_proc(:, 1) = res_distinct(:, 1);%所有的行，第一列  其实就是其中的所有标签 
    res_proc(:, 2) = num2cell(zeros(res_num,1));%将res_num*1的零矩阵转换成cell数组
    %res_proc可以能的取值为  {["是"]}，{[0]}  或者{["是"]}，{[0]};{["否"]},{[0]}  
    %res_proc的维度1*2或者2*2
    %这里循环的作用是记录样本中有多少个的标签为{"是"}
    %样本中有多少个标签为{”否“}
    for i = 1:res_num
        for j = 1:m
            if res_proc{i, 1} == data{j, n}
                res_proc{i, 2} = res_proc{i, 2} + 1;
            end
        end
    end
    %在标签为"是","否"中数量最多的一个
    for i = 1:res_num
        if res_proc{i, 2} == max(res_proc{:, 2})
            res = res_proc(i, 1);
            break;
        end
    end
end