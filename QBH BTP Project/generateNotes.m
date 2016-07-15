function[notes_new, len] = generateNotes(Notes, majorChannel)
    notes_new=zeros(length(Notes),6);
    len=0;
    for i=1:length(Notes)
        if Notes(i,2)==majorChannel
            len=len+1;
            notes_new(len,:)=Notes(i,1:6);
        end
    end
end