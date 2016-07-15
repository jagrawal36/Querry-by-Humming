function[c1, c2, c3] = topAverageChannels(Notes)

% The code searches for top 3 MIDI channels having highest average pitch of
% notes. 
% Channel 10 & 11 are ignored as percussion is not important for Melody
% Extraction.
%
% It is assumed that the MIDI file contains maximum of 16 channels.

frame_size = 0.046;
start_of_frame = 0;
end_of_frame = 0.046;
channel_pitch = zeros(17,1);
total_pitch = zeros(17,1);
pitch=zeros(17,1);
frame_count=0;
for i = 1:length(Notes)
    start = Notes(i,5);
    finish = Notes(i,6);
    if((start<=start_of_frame && finish>=end_of_frame)||(start<=start_of_frame+(frame_size*0.6) && finish>end_of_frame)||(start<start_of_frame && finish>=end_of_frame-(frame_size*0.6)))
        channel_number = Notes(i,2);
        midi_number = Notes(i,3);
        % add condition : if channel_number ~=0 && 
        if(channel_number ~=0 && channel_pitch(channel_number)<midi_number && channel_number ~= 9 && channel_number~=10)
            channel_pitch(channel_number)= midi_number;
        else if(channel_number == 0 && channel_pitch(17)<midi_number)
                channel_pitch(17) = midi_number;
            end
        end
    else if(start>end_of_frame)
            start_of_frame = start_of_frame+frame_size;
            end_of_frame = end_of_frame+frame_size;
            total_pitch = total_pitch+channel_pitch;
            channel_pitch=zeros(17,1);
            frame_count = frame_count+1;
        end
    end
            
end
pitch=total_pitch;
total_pitch=total_pitch/frame_count;

[p1,c1] = max(total_pitch);
total_pitch(c1)=0;
[p2,c2] = max(total_pitch);
total_pitch(c2)=0;
[p3,c3] = max(total_pitch);
end
