function [segments] = generateSegments(time_series, window_size, offset)

len_series = length(time_series);
padding = rem((length(time_series)-window_size),offset);

if( padding == 0)
    
    no_of_windows = (len_series-window_size)/offset;
    
else 
    len_series = len_series + padding;
    no_of_windows = (len_series-window_size)/offset;
    
    for i=1:padding
        time_series(end+1) = 0;
    end
    
end

segments=zeros(no_of_windows, window_size);
start_index = 1;
for i = 1:no_of_windows
    
    segments(i,:) = time_series(start_index:start_index+window_size-1);
    start_index = start_index + offset;
    
end
end
    
    