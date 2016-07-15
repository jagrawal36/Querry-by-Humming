function filter_sig = processQuery(recorded_query, name)

wavwrite(recorded_query, 44100, strcat(name,'_query.wav'));
d=fdesign.lowpass(0.0272, 0.0363, 1, 60);
Hd=design(d);
gated_sig = noisegate(recorded_query,44100);
wavwrite(gated_sig, 44100, strcat(name,'_gated.wav'));
filter_sig=filter(Hd,gated_sig);
wavwrite(filter_sig, 44100, strcat(name,'_filter.wav'));

end