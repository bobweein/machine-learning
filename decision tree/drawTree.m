%****************************************
%drawTree.m
%****************************************
% 画出决策树
function [] = drawTree(node)
    % 遍历树
    nodeVec = [];
    nodeSpec = {};
    edgeSpec = [];
    [nodeVec,nodeSpec,edgeSpec,~] = travesing(node,0,0,nodeVec,nodeSpec,edgeSpec);
    treeplot(nodeVec);
    [x,y] = treelayout(nodeVec);
    [~,n] = size(nodeVec);
    x = x';
    y = y';
    text(x(:,1),y(:,1),nodeSpec,'FontSize',15,'FontWeight','bold','VerticalAlignment','bottom','HorizontalAlignment','center');
    %x_branch = [];
    %y_branch = [];
    x_branch=zeros(n-1,1);
    y_branch=zeros(n-1,1);
    
    for i = 2:n
        %x_branch = [x_branch; (x(i,1)+x(nodeVec(i),1))/2];
          %y_branch = [y_branch; (y(i,1)+y(nodeVec(i),1))/2];
        x_branch(i-1)=(x(i,1)+x(nodeVec(i),1))/2;
        y_branch(i-1)=(y(i,1)+y(nodeVec(i),1))/2;
    end
    text(x_branch(:,1),y_branch(:,1),edgeSpec(1,:),'FontSize',12,'Color','blue','FontWeight','bold','VerticalAlignment','bottom','HorizontalAlignment','center');
end

% 遍历树
function [nodeVec,nodeSpec,edgeSpec,current_count] = travesing(node,current_count,last_node,nodeVec,nodeSpec,edgeSpec)
    nodeVec = [nodeVec last_node];
    if isempty(node.value)
        nodeSpec = [nodeSpec node.children(1).name];
    else 
        if strcmp(node.value, '是')
            nodeSpec = [nodeSpec '好瓜'];
        else
            nodeSpec = [nodeSpec '坏瓜'];
        end
    end
    edgeSpec = [edgeSpec node.branch];
    current_count = current_count + 1;
    current_node = current_count;
    if ~isempty(node.value)
        return;
    end
    for next_ndoe = node.children
        [nodeVec,nodeSpec,edgeSpec,current_count] = travesing(next_ndoe,current_count,current_node,nodeVec,nodeSpec,edgeSpec);
    end
end
