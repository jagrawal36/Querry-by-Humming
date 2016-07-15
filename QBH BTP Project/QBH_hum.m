function [query_data] = QBH_hum(filtered_query)


[f,t]=spPitchTrackCorr(filtered_query,44100,1);
pitch_series = normalizePitch(f);
plot(t,pitch_series);
hum_segments=generateSegments(pitch_series,60,1);
hum_filtered_segments = meanRemovalFilter(hum_segments);
query_data = PAATransform(hum_filtered_segments, 3);

end

