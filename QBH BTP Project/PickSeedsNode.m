function [entry1, entry2] = PickSeedsNode(RTree, child_pointers, dimension)

len = length(child_pointers);
max_diff=0;

for i = 1:len
    
    for j = 1:len
        
        area_box1 = 1;
        k=2;
        for d=1:dimension
            area_box1 = area_box1 * (cell2mat(RTree(child_pointers(i), k+1)) - cell2mat(RTree(child_pointers(i),k)));
        end
        
        area_box2 = 1;
        k=2;
        for d=1:dimension
            area_box2 = area_box2 * (cell2mat(RTree(child_pointers(j), k+1)) - cell2mat(RTree(child_pointers(j),k)));
        end
        
        common_box = zeros(1,dimension*2);
        
        area_box = 1;
        k=2;
        for d=1:dimension
            common_box(1,k-1)= min(cell2mat(RTree(child_pointers(i),k)),cell2mat(RTree(child_pointers(j),k)));
            common_box(1,k)= max(cell2mat(RTree(child_pointers(i),k+1)),cell2mat(RTree(child_pointers(j),k+1)));
            area_box = area_box * (common_box(1,k) - common_box(1,k-1));
        end
        
        
        diff = area_box-area_box1-area_box2;
        
        
        
        if diff > max_diff
            
            entry1 = i;
            entry2 = j;
            max_diff = diff;
        end
    end
end
end
            
        
       
        