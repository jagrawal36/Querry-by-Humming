function [L, LL]= QuadCostSplitNode(child_pointers, RTree, leaf_index, dimension,M,m)


[index1, index2] = PickSeedsNode(RTree, child_pointers, dimension);

Group1 = zeros(length(child_pointers),1);
Group2 = zeros(length(child_pointers),1);
bounding_box1 = zeros(dimension*2,1);
bounding_box2 = zeros(dimension*2,1);
bounding_box1(1:2:dimension*2-1)=999999;
bounding_box2(1:2:dimension*2-1)=999999;

track1 = 1;
track2 = 1;

Group1(track1) = child_pointers(index1);
Group2(track2) = child_pointers(index2);
k=1;
for i = 1:dimension
    bounding_box1(k)=min(cell2mat(RTree(child_pointers(index1),1+k)), bounding_box1(k));
    bounding_box1(k+1)=max(cell2mat(RTree(child_pointers(index1),1+k+1)), bounding_box1(k+1));
    bounding_box2(k)=min(cell2mat(RTree(child_pointers(index2),1+k)), bounding_box2(k));
    bounding_box2(k+1)=max(cell2mat(RTree(child_pointers(index2),1+k+1)), bounding_box2(k+1));
    k=k+2;
end


child_pointers(index1)=-1;
child_pointers(index2)=-1;

no_of_records_assigned = sum(child_pointers(:)==-1);
no_of_records_left = length(child_pointers)-no_of_records_assigned;
while no_of_records_assigned < length(child_pointers)
    
    
    pos = find(child_pointers~=-1);
    if no_of_records_left <= (m-track1)
        
        for i = 1:no_of_records_left
            track1 = track1+1;
            Group1(track1)=child_pointers(pos(i));
            k=1;
            for j = 1:dimension
                bounding_box1(k)=min(cell2mat(RTree(child_pointers(pos(i)),1+k)), bounding_box1(k));
                bounding_box1(k+1)=max(cell2mat(RTree(child_pointers(pos(i)),1+k+1)), bounding_box1(k+1));
                k=k+2;
            end
            child_pointers(pos(i))=-1;
        end
        break;
    elseif no_of_records_left <= (m-track2)
        
        
        for i = 1:no_of_records_left
            track2 = track2+1;
            Group2(track2)=child_pointers(pos(i));
            k=1;
            for j = 1:dimension
                bounding_box2(k)=min(cell2mat(RTree(child_pointers(pos(i)),1+k)), bounding_box2(k));
                bounding_box2(k+1)=max(cell2mat(RTree(child_pointers(pos(i)),1+k+1)), bounding_box2(k+1));
                k=k+2;
            end
            child_pointers(pos(i))=-1;
        end
        break;
    elseif no_of_records_left >=1
        next_entry = PickNextNode(RTree, child_pointers, bounding_box1, bounding_box2, dimension);
        k=1;
        new_box1=zeros(dimension*2,1);
        new_box2=zeros(dimension*2,1);
        for i =1:dimension
            new_box1(k) = min(cell2mat(RTree(child_pointers(next_entry),1+k)), bounding_box1(k));
            new_box1(k+1) = max(cell2mat(RTree(child_pointers(next_entry),1+k+1)), bounding_box1(k+1));
            new_box2(k) = min(cell2mat(RTree(child_pointers(next_entry),1+k)), bounding_box2(k));
            new_box2(k+1) = max(cell2mat(RTree(child_pointers(next_entry),1+k+1)), bounding_box2(k+1));
            k=k+2;
        end
        
        area_bb1=1;
        area_bb2=1;
        area_nb1=1;
        area_nb2=1;
        k=1;
        for i=1:dimension
            area_bb1 = area_bb1 * (bounding_box1(k+1)-bounding_box1(k));
            area_bb2 = area_bb2 * (bounding_box2(k+1)-bounding_box2(k));
            area_nb1 = area_nb1 * (new_box1(k+1)-new_box1(k));
            area_nb2 = area_nb2 * (new_box2(k+1)-new_box2(k));
            k=k+2;
        end
        if abs(area_nb1-area_bb1) > abs(area_nb2-area_bb2)
            track2 = track2+1;
            Group2(track2)=child_pointers(next_entry);
            k=1;
            for j = 1:dimension
                bounding_box2(k)=min(cell2mat(RTree(child_pointers(next_entry),1+k)), bounding_box2(k));
                bounding_box2(k+1)=max(cell2mat(RTree(child_pointers(next_entry),1+k+1)), bounding_box2(k+1));
                k=k+2;
            end
        else
            
            track1 = track1+1;
            Group1(track1)=child_pointers(next_entry);
            k=1;
            for j = 1:dimension
                bounding_box1(k)=min(cell2mat(RTree(child_pointers(next_entry),1+k)), bounding_box1(k));
                bounding_box1(k+1)=max(cell2mat(RTree(child_pointers(next_entry),1+k+1)), bounding_box1(k+1));
                k=k+2;
            end
        end
        child_pointers(next_entry)=-1;
    end
    no_of_records_assigned = sum(child_pointers(:)==-1);
    no_of_records_left = length(child_pointers)-no_of_records_assigned;
end

L = cell(1, 1+dimension*2+M+1);
LL = cell(1, 1+dimension*2+M+1);
L(1,1)= RTree(leaf_index, 1);
LL(1,1)= RTree(leaf_index, 1);
for i =1:dimension*2
    L(1,i+1) = {bounding_box1(i)};
    LL(1,i+1) = {bounding_box2(i)};
end
for i =1:track1
    L(1,1+dimension*2+i) = {Group1(i)};
end
for i =track1+1:M
    L(1,1+dimension*2+i) = {-1};
end
L(1,1+dimension*2+M+1)=RTree(leaf_index,1+dimension*2+M+1);
for i =1:track2
    LL(1,1+dimension*2+i) = {Group2(i)};
end
for i =track2+1:M
    LL(1,1+dimension*2+i) = {-1};
end
LL(1,1+dimension*2+M+1)=RTree(leaf_index,1+dimension*2+M+1);


end



