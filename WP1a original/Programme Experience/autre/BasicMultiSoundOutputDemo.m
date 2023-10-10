% History:
% 06/12/2008 Written (MK)
function BasicMultiSoundOutputDemo(repetitions, wavfilename)
% Running on PTB-3? Abort otherwise.
AssertOpenGL;

if nargin < 1
    repetitions = [];
end

if isempty(repetitions)
    repetitions = 0;
end

% Filename provided?
if nargin < 2
    wavfilename = [];
end

if isempty(wavfilename)
    % No sound file provided. Load standard handel.mat of Matlab:
    load handel;
    nrchannels = 1; % One channel only -> Mono sound.
    freq = Fs;      % Fs is the correct playback frequency for handel.
    wavedata = y';  % Need sound vector as row vector, one row per channel.
else
    % Read WAV file from filesystem:
    [y, freq ] = audioread(wavfilename);
    wavedata = y';
    nrchannels = size(wavedata,1); % Number of rows == number of channels.
end

% Perform basic initialization of the sound driver:
InitializePsychSound(1);

% Open the default audio device [], with default mode [] (==Only playback),
% and a required latencyclass of one 1 == Standard low-latency mode, as well as
% a frequency of freq and nrchannels sound channels.
%
% We use low-latency mode here not because we need low latency, but to
% switch the driver into high-precision timing mode.
%
% This returns handles to the audio device:
pahandle1 = PsychPortAudio('Open', [], [], 1, freq, nrchannels);
pahandle2 = PsychPortAudio('Open', [], [], 1, freq, nrchannels);

% Fill the audio playback buffer with the audio data 'wavedata':
PsychPortAudio('FillBuffer', pahandle1, wavedata);
PsychPortAudio('FillBuffer', pahandle2, MakeBeep(1000, 0.1, freq));

% Start audio playback for 'repetitions' repetitions of the sound data,
% start it immediately (0) and wait for the playback to start, return onset
% timestamp.
t1 = PsychPortAudio('Start', pahandle1, repetitions, 0, 1);

% Wait for release of all keys on keyboard:
KbReleaseWait;

fprintf('Audio playback started, press any key for about 1 second to quit.\n');
fprintf('Will play a beep tone of 0.1 secs duration every second.\n');

% tlast is the start time of the last time the beep tone was played. We set
% it to the onset time of the background soundtrack as a starter, so the
% first beep will happen 5 second after onset of the background soundtrack:
tlast = t1 + 4;

% Stay in a little loop until keypress:
while ~KbCheck
    % Onset of next beep 1 second after last one:
    when = tlast + 1;
    
    % Request sound onset of beep tone at system time 'when', 1 repetition,
    % wait for sound onset to happen, store real onset time in 'tlast' as a
    % baseline for next iteration...
    tlast = PsychPortAudio('Start', pahandle2, 1, when, 1);
    
    % Now we know the sound is playing. Before we can restart it, we need
    % to stop it. We could do something useful here for at least 0.1 secs
    % as we know the sound will last that long.
    fprintf('Delta between onset of this beep and onset of sound track is %f secs.\n', tlast - t1);
    
    % dumdidumdidum....
    % Ok, for the fun of it, query playback status and print it...
    s = PsychPortAudio('GetStatus', pahandle2);
    % Or maybe not - it clutters so much .... disp(s);
    
    % Instead we simply request a 'Stop' of playback, but tell the driver
    % it should wait until the sound has played out completely, then stop
    % it... A Stop is always needed to reset the playback engine,
    % regardless if the sound has already finished or not!
    %
    % This is done by setting the optional waitForendOfPlayback flag to 1:
    PsychPortAudio('Stop', pahandle2, 1);
    
    % Here - after playback has been stopped - we could use the 'FillBufer'
    % subcommand to load a new sound into the playback buffer...
    newpitch = 100 * ( 1 + round(rand * 20));
    PsychPortAudio('FillBuffer', pahandle2, MakeBeep(newpitch, 0.1, freq));
end

% Stop playback of background sound track:
PsychPortAudio('Stop', pahandle1);

% Close the audio devices:
PsychPortAudio('Close', pahandle1);
PsychPortAudio('Close', pahandle2);

% Done.
fprintf('Demo finished, bye!\n');
end