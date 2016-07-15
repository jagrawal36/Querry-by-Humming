function [L, LL]= QuadCostSplit(database, RTree, leaf_index, entity_index, dimension,M,m)

record_pointers = cell2mat(RTree(leaf_index, (1+dimension*2+1):(1+dimension*2+M)));
record_pointers(end+1) =entity_index;
[index1, index2] = PickSeeds(database, record_pointers, dimension);

Group1 = zeros(length(record_pointers),1);
Group2 = zeros(length(record_pointers),1);
bounding_box1 = zeros(dimension*2,1);
bounding_box2 = zeros(dimension*2,1);
bounding_box1(1:2:dimension*2-1)=999999;
bounding_box2(1:2:dimension*2-1)=999999;

track1 = 1;
track2 = 1;

Group1(track1) = record_pointers(index1);
Group2(track2) = record_pointers(index2);
k=1;
for i = 1:dimension
    bounding_box1(k)=min(database(record_pointers(index1),i), bounding_box1(k));
    bounding_box1(k+1)=max(database(record_pointers(index1),i), bounding_box1(k+1));
    bounding_box2(k)=min(database(record_pointers(index2),i), bounding_box2(k));
    bounding_box2(k+1)=max(database(record_pointers(index2),i), bounding_box2(k+1));
    k=k+2;
end


record_pointers(index1)=-1;
record_pointers(index2)=-1;

no_of_records_assigned = sum(record_pointers(:)==-1);
no_of_records_left = length(record_pointers)-no_of_records_assigned;
while no_of_records_assigned < length(record_pointers)
    
    
    pos = find(record_pointers~=-1);
    if no_of_records_left <= (m-track1)
        
        for i = 1:no_of_records_left
            track1 = track1+1;
            Group1(track1)=record_pointers(pos(i));
            k=1;
            for j = 1:dimension
                bounding_box1(k)=min(database(record_pointers(pos(i)),j), bounding_box1(k));
                bounding_box1(k+1)=max(database(record_pointers(pos(i)),j), bounding_box1(k+1));
                k=k+2;
            end
            record_pointers(pos(i))=-1;
        end
        break;
    elseif no_of_records_left <= (m-track2)
        
        
        for i = 1:no_of_records_left
            track2 = track2+1;
            Group2(track2)=record_pointers(pos(i));
            k=1;
            for j = 1:dimension
                bounding_box2(k)=min(database(record_pointers(pos(i)),j), bounding_box2(k));
                bounding_box2(k+1)=max(database(record_pointers(pos(i)),j), bounding_box2(k+1));
                k=k+2;
            end
            record_pointers(pos(i))=-1;
        end
        break;
    elseif no_of_records_left >1
        next_entry = PickNext(database, record_pointers, bounding_box1, bounding_box2, dimension);
        k=1;
        new_box1=zeros(dimension*2,1);
        new_box2=zeros(dimension*2,1);
        for i =1:dimension
            new_box1(k) = min(database(record_pointers(next_entry),i), bounding_box1(k));
            new_box1(k+1) = max(database(record_pointers(next_entry),i), bounding_box1(k+1));
            new_box2(k) = min(database(record_pointers(next_entry),i), bounding_box2(k));
            new_box2(k+1) = max(database(record_pointers(next_entry),i), bounding_box2(k+1));
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
            Group2(track2)=record_pointers(next_entry);
            k=1;
            for j = 1:dimension
                bounding_box2(k)=min(database(record_pointers(next_entry),j), bounding_box2(k));
                bounding_box2(k+1)=max(database(record_pointers(next_entry),j), bounding_box2(k+1));
                k=k+2;
            end
        else
            
            track1 = track1+1;
            Group1(track1)=record_pointers(next_entry);
            k=1;
            for j = 1:dimension
                bounding_box1(k)=min(database(record_pointers(next_entry),j), bounding_box1(k));
                bounding_box1(k+1)=max(database(record_pointers(next_entry),j), bounding_box1(k+1));
                k=k+2;
            end
        end
        record_pointers(next_entry)=-1;
    end
    no_of_records_assigned = sum(record_pointers(:)==-1);
    no_of_records_left = length(record_pointers)-no_of_records_assigned;
end

L = cell(1, 1+dimension*2+M);
LL = cell(1, 1+dimension*2+M);
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



