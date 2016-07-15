function[final_segments] = PAATransform(filtered_segments, final_dimension)

[no_of_windows, window_size] = size(filtered_segments);
final_segments = zeros(no_of_windows, final_dimension);
original_dimension = window_size;

for seg = 1:no_of_windows
    
    for i = 1: final_dimension
        
        sum = 0;
        
        for j= ((original_dimension/final_dimension)*(i-1) +1) : ((original_dimension/final_dimension)*i)
            
            sum = sum + filtered_segments(seg,j);
        end
        
        aggregate_approx = round(sum * (final_dimension/original_dimension));
        
        final_segments(seg, i) = aggregate_approx;
        
    end
end
end
            
          
            
