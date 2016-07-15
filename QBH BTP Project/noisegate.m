function[y] = noisegate(x,Fs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Implementation of             %
%       Noise Gate                    %
%    Author: Kaustubh Kumar           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

format long;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% holdtime     -time in seconds the sound level has to be below the 
%               threshold value before the gate is activated
% ltrhold      -threshold value for activating the gate
% utrhold      -threshold value for deactivating the gate >ltrhold
% release      -time in seconds before the sound level reaches zero 
%               after activating the gate
% attack       -time in seconds before the output sound level is the 
%               same as the input level after deactivating the gate
% a            -pole placement of the envelope detecting filter <1
% Fs           -sampling frequency
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



a = 0.5;
release = 0.05;
attack = 0.5;
holdtime = 0.005;
ltrhold = 0.1;
utrhold = 0.15;

rel = round(release*Fs);           %number of samples for fade
att = round(attack*Fs);            %number of samples for recover
ht = round(holdtime*Fs);           %number of samples for holdtime

lthcnt = 0;                        %Lower Threshold Counter
uthcnt = 0;                        %Upper Threshold Counter
g = zeros(size(x));                %Static Gain Vector
g1 = zeros(size(x));               %Dynamic Gain Vector
g1(1) = 0;

gain_at = 50;                      %Dynamic Gain Attack Time
gain_rt = 10;                      %Dynamic Gain Release Time

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Convert the attack and release times to     %
%  parameters usable in the transfer functions.%
%  This is calculated in the delayTime function%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%G_rt = delayTime(gain_rt/1000, 1/Fs);
%G_at = delayTime(gain_at/1000, 1/Fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Envelope Detection and Normalization  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h = filter([(1-a)^2], [1.0000 -2*a a^2], abs(x));
h = h/max(h);
for (i=2:length(h))
    if((h(i)<=ltrhold)||((h(i)<utrhold)&&(lthcnt>0)))
        %Value below the lower threshold?
        lthcnt = lthcnt+1;
        uthcnt = 0;
        if (lthcnt>ht)
            %Time below the lower threshold longer than the hold time?
            if (lthcnt>(rel+ht))
                g(i) = 0;
            else
                g(i) = 1-(lthcnt-ht)/rel;    %fades the signal to zero
            end 
        elseif ((i<ht) && (lthcnt==i))
                g(i) = 0;
        else
                g(i) = 1;
        end
    elseif (h(i)>=utrhold)||((h(i)>ltrhold)&&(uthcnt>0))
            %Value above the upper threshold or is the signal being faded
            %in?
            uthcnt = uthcnt + 1;
            if (g(i-1)<1)
                %Has the gate been activated or isn't the signal faded in
                %yet?
                g(i) = max(uthcnt/att, g(i-1));
            else
                g(i) = 1;
            end
            lthcnt = 0;
    else
            g(i) = g(i-1);
            lthcnt = 0;
            uthcnt = 0;
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Perform Dynamic Gain          %
%      Adjustments                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%for (n=2:length(x))
%    g1(n) = (1-G_rt)*g1(n-1)+G_at*g(n);
%end
 y = x.*g;
 y = y*max(abs(x))/max(abs(y));
 
end
 
            
                
        
 