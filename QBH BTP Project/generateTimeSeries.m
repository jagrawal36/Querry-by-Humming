function[time_series] = generateTimeSeries(notesMajorChannel, microsec_per_quarter_note, len)

time_series = [];
time_sample = 0;
i=1;
while(i<=len)
    
    
    
    if( notesMajorChannel(i,5) <= time_sample && notesMajorChannel(i,6) >= time_sample )
       
        time_series(end+1) = notesMajorChannel(i,3);
        time_sample = time_sample + (microsec_per_quarter_note * 10^-6);
       
    elseif( notesMajorChannel(i,5) > time_sample && (i == 1 || notesMajorChannel(i-1, 6) < time_sample))
        
        time_series(end+1) = 0;
        time_sample = time_sample + (microsec_per_quarter_note * 10^-6);
        
    else
        
        i = i+1;
    end
    
end



end
       