function leaf_index = ChooseLeaf(RTree, N, entity, M, dimension, rect_enlargement)

if cell2mat(RTree(N,1+dimension*2+M+1))~= -1    
    list_of_child = cell2mat(RTree(N, (1+dimension*2+1):(1+dimension*2+M)));       
    
    for i = 1:M
        if list_of_child(i) ~= -1
            rect_coordinates = cell2mat(RTree(list_of_child(i), 2:(1+dimension*2)));
            entity_coordinates = cell2mat(entity(2:1+dimension));
            k = 1;
            new_bounding_box = zeros(dimension*2);
            for j = 1:dimension
                new_bounding_box(k) = min(entity_coordinates(j), rect_coordinates(k));
                new_bounding_box(k+1) = max(entity_coordinates(j), rect_coordinates(k+1));
                k=k+2;
            end
            k=1;
            area_box=1;
            area_rect=1;
            for j =1:dimension
                area_box = area_box * (new_bounding_box(k+1)-new_bounding_box(k));
                area_rect = area_rect * (rect_coordinates(k+1)-rect_coordinates(k));
                k=k+2;
            end
            temp_enlargement = abs(area_box-area_rect);
            if temp_enlargement<rect_enlargement 
                rect_enlargement = temp_enlargement;
                N = list_of_child(i);
            end
        end
    end
    leaf_index = ChooseLeaf(RTree, N, entity, M, dimension, 1e+20);
else
    leaf_index = N;
end
end
                
                    
            
            
        
        
        
        
        
        
   
    
    