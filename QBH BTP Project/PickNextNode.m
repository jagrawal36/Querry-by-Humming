function next_entry  = PickNextNode(RTree, child_pointers, bounding_box1, bounding_box2, dimension)

max_diff = 0;
area_group1 = 1;
area_group2 = 1;
k=1;
for i = 1:dimension
    area_group1 = area_group1 * (bounding_box1(k+1)-bounding_box1(k));
    area_group2 = area_group2 * (bounding_box2(k+1)-bounding_box2(k));
    k=k+2;
end
    
for i = 1:length(child_pointers)    
    if child_pointers(i) ~= -1        
        new_bounding_box1 = zeros(dimension*2); 
        new_bounding_box2 = zeros(dimension*2); 
        k=1;
        for j = 1:dimension            
            new_bounding_box1(k) = min(cell2mat(RTree(child_pointers(i),1+k)), bounding_box1(k));
            new_bounding_box2(k) = min(cell2mat(RTree(child_pointers(i),1+k)), bounding_box2(k));
            new_bounding_box1(k+1) = max(cell2mat(RTree(child_pointers(i),1+k+1)), bounding_box1(k+1));
            new_bounding_box2(k+1) = max(cell2mat(RTree(child_pointers(i),1+k+1)), bounding_box2(k+1));
            k = k+2;
        end
        area_box1=1;
        area_box2=1;
        k=1;
        for j =1:dimension
            area_box1 = area_box1 * (new_bounding_box1(k+1)-new_bounding_box1(k));
            area_box2 = area_box2 * (new_bounding_box2(k+1)-new_bounding_box2(k));
            k=k+2;
        end
        enlargement1 = abs(area_box1-area_group1);
        enlargement2 = abs(area_box2-area_group2);
        diff = abs(enlargement1 - enlargement2);
        if diff>max_diff
            next_entry = i;
            max_diff = diff;
        end
    end
end
        
        
        
            
           
