function [RTree, track_RTree] = insertIntoRTree(database, RTree, track_RTree, entity, M,m, dimension)

% ChooseLeaf Algorithm

N = 1;  %Setting N to be the root of Tree

leaf_index = ChooseLeaf(RTree, N, entity, M, dimension,1e+20);

% check whether there is room for new entity

record_pointers = cell2mat(RTree(leaf_index, (1+dimension*2+1):(1+dimension*2+M)));
first_unused_index = find(record_pointers == -1,1);
if first_unused_index<=M
    L = cell(1, 1+dimension*2+M+1);
    L(1,1)= RTree(leaf_index, 1);
    entity_coordinates = cell2mat(entity(2:1+dimension));
    k=2;
    for i =1:dimension
        L(1,k) = {min(cell2mat(RTree(leaf_index,k)), entity_coordinates(i))};
        L(1,k+1) = {max(cell2mat(RTree(leaf_index,k+1)), entity_coordinates(i))};
        k=k+2;
    end
    for i = 1:first_unused_index-1
        L(1,1+dimension*2+i)=RTree(leaf_index,1+dimension*2+i);
    end
    L(1, 1+dimension*2+first_unused_index)=entity(end);
    for i = first_unused_index+1:M
        L(1,1+dimension*2+i)={-1};
    end
    L(1,1+dimension*2+M+1)=RTree(leaf_index,1+dimension*2+M+1);
   
    [RTree, track_RTree] = AdjustTree(database, RTree,leaf_index, track_RTree,entity,M,m, dimension, L);
else
    [L, LL]= QuadCostSplit(database, RTree, leaf_index, cell2mat(entity(end)), dimension,M,m);
    [RTree, track_RTree] = AdjustTree(database, RTree,leaf_index, track_RTree,entity,M,m, dimension, L, LL);
    %if cell2mat(L(1,1)) == -1   % root was split
       % RTree(2:track_RTree+1,:) = RTree(1:track_RTree,:);
        %RTree(1,1) = {-1};
        %k=2;
        %for i = 1:dimension
        %    RTree(1,k)={min(cell2mat(L(1,k)), cell2mat(LL(1,k)))};
        %    RTree(1,k+1)={max(cell2mat(L(1,k+1)), cell2mat(LL(1,k+1)))};
        %    k=k+2;
        %end
        %RTree(1,1+dimension*2+1)={2};
        %RTree(1,1+dimension*2+2)={track_RTree};
        %for i = 1+dimension*2+3:M
         %   RTree(1,i)={-1};
        %end
        
    %end
end
   
