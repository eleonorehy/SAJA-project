close all
clear all
clc

L=500;
mu=48000;
sigma=1200;
X=sigma+randn(L,1)+mu;

figure(1)
plot(X)
title('White noise');
xlabel('Samples')
ylabel('Sample Values')
grid on;
%%
close all
clear all
clc

f = 1000;
d = 2;
sr = 44100;
beep=MakeBeep(f,d,sr);
InitializePsychSound;
pahandle = PsychPortAudio('Open', [], [], [], sr, 1);
PsychPortAudio('FillBuffer', pahandle, beep);
PsychPortAudio('Start', pahandle);
PsychPortAudio('Stop', pahandle, d);
%%
% Clear the workspace
% clearvars;
% close all;
% sca;

% Initialize Sounddriver
InitializePsychSound(1);
sound = 0;
X = 48002;
while sound < 6
% Number of channels and Frequency of the sound
nrchannels = 2;
freq = 48000;

% L=1;
% mu=48000;
% sigma=2;
% X=sigma+randn(L,1)+mu;
% X = 48002;
% How many times to we wish to play the sound
repetitions = 1;

% Length of the beep
beepLengthSecs = 1;

% Length of the pause between beeps
beepPauseTime = 0;

% Start immediately (0 = immediately)
startCue = 0;

% Should we wait for the device to really start (1 = yes)
% INFO: See help PsychPortAudio
waitForDeviceStart = 1;

% Open Psych-Audio port, with the follow arguements
% (1) [] = default sound device
% (2) 1 = sound playback only
% (3) 1 = default level of latency
% (4) Requested frequency in samples per second
% (5) 2 = stereo putput
pahandle = PsychPortAudio('Open', [], 1, 1, X, nrchannels);

% Set the volume to half for this demo
PsychPortAudio('Volume', pahandle, 0.5);

% Make a beep which we will play back to the user
myBeep = MakeBeep(500, beepLengthSecs, X);

% Fill the audio playback buffer with the audio data, doubled for stereo
% presentation
PsychPortAudio('FillBuffer', pahandle, [myBeep; myBeep]);


    
% Start audio playback
PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart);

% Wait for the beep to end. Here we use an improved timing method suggested
% by Mario.
% See: https://groups.yahoo.com/neo/groups/psychtoolbox/conversations/messages/20863
% For more details.
[actualStartTime, ~, ~, estStopTime] = PsychPortAudio('Stop', pahandle, 1, 1);

% Compute new start time for follow-up beep, beepPauseTime after end of
% previous one
startCue = estStopTime + beepPauseTime;

% Start audio playback
% PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart);
X = X + 1000;    
sound = sound+1;

end
% Wait for stop of playback
PsychPortAudio('Stop', pahandle, 1, 1);

% Close the audio device
PsychPortAudio('Close', pahandle);

%%
% Clear the workspace
clearvars;
close all;
sca;



%---------------
% Sound Setup
%---------------

% Initialize Sounddriver
InitializePsychSound(1);

% Number of channels and Frequency of the sound
nrchannels = 2;
freq = 48000;

% How many times to we wish to play the sound
repetitions = 1;

% Length of the beep
beepLengthSecs = 1;

% Length of the pause between beeps
beepPauseTime = 1;

% Start immediately (0 = immediately)
startCue = 0;

% Should we wait for the device to really start (1 = yes)
% INFO: See help PsychPortAudio
waitForDeviceStart = 1;

% Open Psych-Audio port, with the follow arguements
% (1) [] = default sound device
% (2) 1 = sound playback only
% (3) 1 = default level of latency
% (4) Requested frequency in samples per second
% (5) 2 = stereo putput
pahandle = PsychPortAudio('Open', [], 1, 1, freq, nrchannels);

% Set the volume to half for this demo
PsychPortAudio('Volume', pahandle, 0.5);

% Make a beep which we will play back to the user
myBeep = MakeBeep(500, beepLengthSecs, freq);

% Fill the audio playback buffer with the audio data, doubled for stereo
% presentation
PsychPortAudio('FillBuffer', pahandle, [myBeep; myBeep]);





%---------------
% Screen Setup
%---------------

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Select the external screen if it is present, else revert to the native
% screen
screenNumber = max(screens);

% Define black, white and grey
black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
grey = white / 2;

% Open an on screen window and color it grey
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

% Set the blend funciton for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Get the size of the on screen window in pixels
% For help see: Screen WindowSize?
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter
[xCenter, yCenter] = RectCenter(windowRect);

% Set the text size
Screen('TextSize', window, 70);

% Calculate how long the beep and pause are in frames
beepLengthFrames = round(beepLengthSecs / ifi);
beepPauseLengthFrames = round(beepPauseTime / ifi);


% Now we draw our sequence of silence and beeps. You could obviously put
% this in a loop, but we will just do everything sequentially code-wise to
% show what is going on

% Draw silence text
for i = 1:beepPauseLengthFrames

    % Draw text
    DrawFormattedText(window, 'SILENCE #1', 'center', 'center', [0 0 1]);

    % Flip to the screen
    Screen('Flip', window);

end

% Start audio playback #1
PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart);

% Draw beep text
for i = 1:beepLengthFrames

    % Draw text
    DrawFormattedText(window, 'BEEP #1', 'center', 'center', [1 0 0]);

    % Flip to the screen
    Screen('Flip', window);

end

% Stop playback, regardless whether it has finished or not. One would hope
% it had as the length of our drawing was the length of the beep. However,
% see https://groups.yahoo.com/neo/groups/psychtoolbox/conversations/messages/20863
% for more details. Here I have taken the approach that the visuals are
% what is most important and the beep should simply be stopped after the
% visuals have finished, regardless whether in reality there are timing
% differences due to how soundcards may function. One could easily do it
% the other way i.e. have timing controled directly by the sound and
% terminate the visuals based on this. Note also we use Screen('Flip', window)
% So our visual timing might not be all the great. Full explanation in
% "Accurate Timing Demo" and the related "Wait Frames Demo"
PsychPortAudio('Stop', pahandle);

% Draw silence text
for i = 1:beepPauseLengthFrames

    % Draw text
    DrawFormattedText(window, 'SILENCE #2', 'center', 'center', [0 0 1]);

    % Flip to the screen
    Screen('Flip', window);

end

% Start audio playback #2
PsychPortAudio('Start', pahandle, repetitions, startCue, waitForDeviceStart);

% Draw beep text
for i = 1:beepLengthFrames

    % Draw text
    DrawFormattedText(window, 'BEEP #2', 'center', 'center', [1 0 0]);

    % Flip to the screen
    Screen('Flip', window);

end

% Stop playback
PsychPortAudio('Stop', pahandle);

% Draw silence text
for i = 1:beepPauseLengthFrames

    % Draw text
    DrawFormattedText(window, 'SILENCE #3', 'center', 'center', [0 0 1]);

    % Flip to the screen
    Screen('Flip', window);

end

% Close the audio device
PsychPortAudio('Close', pahandle);

% Clear up and leave the building
sca
close all
clear all

%%

