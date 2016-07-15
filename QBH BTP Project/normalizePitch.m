function pitch_series = normalizePitch(f)

max_unwanted_pitch = max(f);
pitch_series=zeros(length(f),1);
for i=1:length(f)
    
    if( f(i) >= max_unwanted_pitch/2)
        
        pitch_series(i)=0;
    else
        pitch_series(i)=f(i);
    end
end
end