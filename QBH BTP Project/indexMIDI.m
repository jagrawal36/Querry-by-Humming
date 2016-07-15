function [RTree, track_RTree, database]=indexMIDI(source_file)
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
[RTree, track_RTree] = IndexRTree(database,200,100);
end
