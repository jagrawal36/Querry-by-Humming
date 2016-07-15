function [database,query_data] = QBH(source_file, query)

midi = readmidi(source_file);
ticks = midi.ticks_per_quarter_note;
Notes = midiInfo(midi);
[notes_new, len] = generateNotes(Notes, 0);
midi_extracted = matrix2midi(notes_new, ticks);
writemidi(midi_extracted, strcat(source_file(1:length(source_file)-4), '_next.mid'));
time_series = generateTimeSeries(notes_new, 10000, len);
segments = generateSegments(time_series,60,1);
filtered_segments = meanRemovalFilter(segments);
database = PAATransform(filtered_segments, 3);

midi2 = readmidi(query);
ticks2 = midi2.ticks_per_quarter_note;
Notes2 = midiInfo(midi2);
[notes_new2, len2] = generateNotes(Notes2, 0);
time_series2 = generateTimeSeries(notes_new2, 10000, len2);
segments2 = generateSegments(time_series2,60,1);
filtered_segments2 = meanRemovalFilter(segments2);
query_data = PAATransform(filtered_segments2, 3);

end