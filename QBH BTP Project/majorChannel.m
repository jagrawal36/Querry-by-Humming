function[major_channel]=majorChannel(Notes, c1, c2, c3)


frame_size = 0.046;
c1zerosegcnt=0;
c2zerosegcnt=0;
c3zerosegcnt=0;
start_frame = 0;
end_frame = 0.046;
frame_count=0;
c1present=0;
c2present=0;
c3present=0;
flag=0;
for i=1:length(Notes)
    s=Notes(i,5);
    f=Notes(i,6);
    if(s<=start_frame && f>=end_frame)
        flag=1;
        midi_channel=Notes(i,2);
        if(midi_channel==c1)
            c1present=1;
        else if(midi_channel==c2)
            c2present=1;
             else if(midi_channel==c3)
                c3present=1;
                  end
            end
        end
    else if(s>=end_frame)
            if(flag==1)
            if(c1present==0)
                c1zerosegcnt=c1zerosegcnt+1;
            end
            if(c2present==0)
                c2zerosegcnt=c2zerosegcnt+1;
            end
            if(c3present==0)
                c3zerosegcnt=c3zerosegcnt+1;
            end
            end
            c1present=0;
            c2present=0;
            c3present=0;
            flag=0;
            frame_count=frame_count+1;
            start_frame=start_frame+frame_size;
            end_frame=end_frame+frame_size;
        end
    end
            
end
mincount=min([c1zerosegcnt,c2zerosegcnt,c3zerosegcnt]);
if(mincount==c1zerosegcnt)
    major_channel=c1;
end
if(mincount==c2zerosegcnt)
    major_channel=c2;
end
if(mincount==c3zerosegcnt)
    major_channel=c3;
end
end