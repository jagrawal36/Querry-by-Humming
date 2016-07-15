function [entry1, entry2] = PickSeeds(database, record_pointers, dimension)

len = length(record_pointers);
max_dist = 0;

for i = 1:len
    
    for j = 1:len
        
        dist = 0;
        
        for k = 1:dimension
            dist = dist + (database(record_pointers(1,i),k)-database(record_pointers(1,j),k))^2;
        end
        
        dist = sqrt(dist);
        
        if dist > max_dist
            
            entry1 = i;
            entry2 = j;
            max_dist = dist;
        end
    end
end
end
            
        
       
        