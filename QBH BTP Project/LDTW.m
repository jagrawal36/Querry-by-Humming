function distance = LDTW(query, query_index, database_segment, segment_index, k)

if( abs(query_index-segment_index) <= k)
    
    d_constraint = (query(1)-database_segment(1))^2;
    
else
    d_constraint = 999999;
    
end
if d_constraint == 999999
    distance = 999999;
    
elseif(length(query)==1 && length(database_segment)>1)
    
    distance = d_constraint + min([ LDTW(query, query_index, database_segment(2:end), segment_index+1, k), 
        LDTW([0], query_index+1, database_segment, segment_index, k),
        LDTW([0], query_index+1, database_segment(2:end), segment_index+1, k) ]);
    
elseif(length(database_segment)==1 && length(query)>1)
    
    distance = d_constraint + min([ LDTW(query, query_index, [0], segment_index+1, k), 
        LDTW(query(2:end), query_index+1, database_segment, segment_index, k),
        LDTW(query(2:end), query_index+1, [0], segment_index+1, k) ]);
    
elseif(length(database_segment)==1 && length(query)==1)
    
    distance = d_constraint;
    
else
    distance = d_constraint + min([ LDTW(query, query_index, database_segment(2:end), segment_index+1, k), 
        LDTW(query(2:end), query_index+1, database_segment, segment_index, k),
        LDTW(query(2:end), query_index+1, database_segment(2:end), segment_index+1, k) ]);
end
end

