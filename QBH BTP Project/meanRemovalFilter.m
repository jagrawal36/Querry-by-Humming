function[filtered_segments] = meanRemovalFilter(segments)

[no_of_windows, window_size]= size(segments);
filtered_segments = zeros(no_of_windows, window_size);

for i =1:no_of_windows
    
    mean_segment = round(mean(segments(i,:)));
    filtered_segments(i,:) = segments(i,:)-mean_segment;
end
end
