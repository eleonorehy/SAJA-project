function WhiteNoiseSound
InitializePsychSound(1);

freq = 48000;
nrchannels = 1;
repetitions = 1;

pahandle = PsychPortAudio('Open', [], [], 1, freq, nrchannels);
PsychPortAudio('FillBuffer', pahandle, MakeBeep(1000, 0.1, freq));

while ~KbCheck
    PsychPortAudio('Start', pahandle, repetitions, 0, 1);
    
end

PsychPortAudio('Stop', pahandle, 1);
PsychPortAudio('Close', pahandle);
end

