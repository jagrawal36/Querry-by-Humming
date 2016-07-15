function [RTree, track_RTree] = AdjustTree(database,RTree,leaf_index, track_RTree,entity,M,m, dimension, N, NN)

if cell2mat(N(1,1))~=-1
    RTree(leaf_index,:)=N(1,:);
    parent_index = cell2mat(N(1));
    
    k=1;
    for i=1:dimension
        RTree(parent_index,1+k)={min(cell2mat(RTree(parent_index,1+k)), cell2mat(N(1,1+k)))};
        RTree(parent_index,1+k+1)={max(cell2mat(RTree(parent_index,1+k+1)), cell2mat(N(1,1+k+1)))};
        k=k+2;
    end
    record_pointers_parent = cell2mat(RTree(parent_index, (1+dimension*2+1):(1+dimension*2+M)));
    first_unused_index = find(record_pointers_parent == -1,1);
    if nargin==10
    
        track_RTree=track_RTree+1;
        RTree(track_RTree,:)=NN(1,:);
        
        if first_unused_index <= M
            RTree(parent_index, 1+dimension*2+first_unused_index)={track_RTree};
            k=1;
            for i=1:dimension
                RTree(parent_index,1+k)={min(cell2mat(RTree(parent_index,1+k)), cell2mat(NN(1,1+k)))};
                RTree(parent_index,1+k+1)={max(cell2mat(RTree(parent_index,1+k+1)), cell2mat(NN(1,1+k+1)))};
                k=k+2;
            end
            [RTree, track_RTree] = AdjustTree(database,RTree,parent_index, track_RTree,entity, M,m,dimension,RTree(parent_index,:));
        else
            child_pointers = cell2mat(RTree(parent_index, (1+dimension*2+1):(1+dimension*2+M)));
            child_pointers(end+1) =track_RTree;
            
            [P,PP] = QuadCostSplitNode(child_pointers, RTree, parent_index, dimension,M,m);
            
            [RTree, track_RTree] = AdjustTree(database,RTree,parent_index, track_RTree,entity, M,m,dimension,P,PP);
        end
    else
        [RTree, track_RTree] = AdjustTree(database, RTree,parent_index, track_RTree,entity, M,m,dimension,RTree(parent_index,:));
    end
elseif cell2mat(N(1,1))==-1 && nargin==10
    track_RTree = track_RTree+1;
    RTree(track_RTree, :)= N(1,:);
    RTree(track_RTree, 1+dimension*2+M+1)={1};
    track_RTree = track_RTree+1;
    RTree(track_RTree, :)= NN(1,:);
    RTree(track_RTree, 1+dimension*2+M+1)={1};
    RTree(1,1) = {-1};
    k=2;
    for i = 1:dimension
        RTree(1,k)={min(cell2mat(N(1,k)), cell2mat(NN(1,k)))};
        RTree(1,k+1)={max(cell2mat(N(1,k+1)), cell2mat(NN(1,k+1)))};
        k=k+2;
    end
    RTree(1,1+dimension*2+1)={track_RTree-1};
    RTree(track_RTree-1,1)={1};
    RTree(1,1+dimension*2+2)={track_RTree};
    RTree(track_RTree,1)={1};
    for i = (1+dimension*2+3):(1+dimension*2+M)
       RTree(1,i)={-1};
    end
    
end

for i = 1:track_RTree
    if cell2mat(RTree(i,1+dimension*2+M+1))~=-1
        k=1+dimension*2+1;
        while cell2mat(RTree(i,k))~=-1 && k<=(1+dimension*2+M)
            index_child = cell2mat(RTree(i,k));
            RTree(index_child,1)={i};
            k=k+1;
        end
    end
    
        
end
end

        
