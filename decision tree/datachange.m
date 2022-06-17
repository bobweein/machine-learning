%该函数用于处理连续值
%思路为找到划分Ta使得Gini_index 最小，也就是说数据集纯度更高
function  [tempdata,data]=datachange(data)  %返回的是cell类型  其中的值为“大于a(数值)”，“小于a(数值)”
tempdata=data;
[m,n]=size(data);
%需要判断data中还有没有数值组，如果没有则不要执行操作
flag=true;%true 表示没有数值项 false表示有数值项
ind=[];%设置一个数组来记录数值项的列数
for ii=1:n-1
   if  isa(data{1,ii}(1),'double')==1
       flag=false;
       ind=[ind ,ii];
   end
end
num=length(ind);
if flag==true
    return 
end
for kk=1:num%连续值出现在属性列最后两列中
    %按照当前属性列排序
    i=ind(kk);
   temp = cell2mat(tempdata(:,i));
   [~,index]=sort(temp);
   tempdata=tempdata(index,:);
   data=data(index,:);%保持data和tempdata同时变换
   %计算Ta
   Ta=zeros(m-1,1);
   GiniindexD=zeros(m-1,1);%每一Ta对应的基尼指数
   for j=1:m-1
       Ta(j)=(cell2mat(data(j,i))+cell2mat(data(j+1,i)))/2;%计算Ta
       Dv1_index=0;Dv2_index=0;%找出大于Ta的Dv1， 找出小于Ta的Dv2    即划分出两个集合D+ D-
       for k=1:m  
           if  cell2mat(data(k,i))>Ta(j)
               Dv1_index=Dv1_index+1;
           else
               Dv2_index=Dv2_index+1;
           end
       end
       Dv1=cell(Dv1_index,n);   Dv2=cell(Dv2_index,n);
       Dv1_index=1;Dv2_index=1;
       for k=1:m
          if cell2mat(data(k,i))>Ta(j)
              Dv1(Dv1_index,:)=data(k,:);
              Dv1_index=Dv1_index+1;
          else
              Dv2(Dv2_index,:)=data(k,:);
              Dv2_index=Dv2_index+1;
          end
       end
       %计算GiniIndex
       GiniD1=getGini(Dv1); GiniD2=getGini(Dv2);
       GiniindexD(j)=Dv1_index/m*GiniD1+Dv2_index/m*GiniD2;
   end
     %先令最优的Ta为Tabest
   % min为所有基尼指数中最小的一个
   min=GiniindexD(1);
   for j=1:m-1
       if GiniindexD(j)>min
           %min=GiniindexD(j);
           continue;
       end
       Tabest=Ta(j);
   end
%    %将连续值转化为离散值 设置两个标签
   digits(3);
   Tabest=double(vpa(Tabest));
    label1=['大于',num2str(Tabest)];label2=['小于',num2str(Tabest)];
  
   %将大于Tabeast 的属性值改为label1  将不大于Tatest的属性值改为label2
   for j=1:m
       b=cell2mat(data(j,i));
      if  b>Tabest
           tempdata{j,i}=label1;
              % tempdata{j,i}='大于';
      else
           tempdata{j,i}=label2;
               %tempdata{j,i}='小于';
           
      end
   end
end

% 为了达到连续属性进行排序，
% 按照column 中大小对featuretemp 进行排序  （行与行进行交换）
%因为要计算Gini_index时需要标签列 ，所以需要上述操作


