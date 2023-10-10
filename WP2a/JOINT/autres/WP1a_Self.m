 sca; 
close all;
clearvars;

addpath('C:\Users\DEVAUX Alexandre\Documents\COGMASTER\Master 2\STAGE\Experience\Programme Experience\Function'); % link to the additional files or functions
 
PsychDefaultSetup(2);

% -------------------------------------------------------------------------
% VARIABLES
% -------------------------------------------------------------------------

% Key
Key.escape = KbName('ESCAPE'); % Quit the experiment
Key.up = KbName('UpArrow'); 
Key.down = KbName('DownArrow');
Key.left = KbName('LeftArrow'); 
Key.right = KbName('RightArrow');
Key.space = KbName('SPACE'); % Go to the next step

% Colors
black = [0 0 0]; % screen color 
white = [255 255 255]; % text and scale color
grey = white/2; % square color
sd_noise = 1; % noise the fixation square
frameColor = [255 0 0]; % color of square reached
dot.Color = white; % color of the moving ball

% Size 
penWidthPixels = 6; % size of the framed square
screenSize = [0 0 800 800]; % size of the screen = [] if full screen
dot.SizePix = [0 0 15 15]; % size of the mooving dot
baseRect = [0 0 90 90]; % size of the five square
baseTilt = [0 0 4 20]; % size of tilt in self report scales

% Quantity of movement
pixelsPerPressDot = 20; % how much the dot moove on the screen at each press
pixelsPerPressedTilt = 10; % how much the dot moove on the scale at each press

% Gain Matrix
Gain = [1 1 1 2 ; 1 1 1 3 ; 1 1 1 4 ; 1 1 1 5];

numberOfTrials = 4;

% Data from trials function
axis = 1;


try
    [Info, expWindow]=GetTheThings(black, screenSize);
    dot.Xpos = Info.xC; 
    dot.Ypos = Info.yC;
    RectNoise = (sd_noise*randn(baseRect(3),baseRect(4)));
    Screen('TextSize', expWindow, 30);
     
    % Ecran d'accueil
    ALine1 = 'WELCOME';
    ALine2 = '\n\n Press space to continue'; 
    DrawFormattedText(expWindow, [ALine1 ALine2], 'center','center', white);
    Screen('Flip', expWindow);
    passKey(Key.space);
    
    square.Xpos = [Info.rect(3)*0.25 Info.rect(3)*0.25 Info.rect(3)*0.75 Info.rect(3)*0.75];
    square.Ypos = [Info.rect(4)*0.25 Info.rect(4)*0.75 Info.rect(4)*0.25 Info.rect(4)*0.75];
    square.Num = length(square.Xpos);

    allRects = nan(4,3);
    for sq = 1:square.Num
    allRects(:,sq) = CenterRectOnPointd(baseRect, square.Xpos(sq), square.Ypos(sq));
    end

    Screen('FillRect', expWindow, grey, allRects);
    centeredRect = CenterRectOnPointd(baseRect, Info.xC, Info.yC);

    Screen('FillRect', expWindow, grey, centeredRect);
    tex = Screen('MakeTexture', expWindow, RectNoise);
    Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);

    Screen('TextSize', expWindow, 40);
    for ga=1:length(actualGain)
    [x,y] = DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+30, allRects(2,ga)+20, black);
    end 

    Screen('Flip', expWindow)
    WaitSecs(2);
    
    Screen('Close', expWindow); 
    
catch WhatsTheError
    Screen('CloseAll')
    rethrow(WhatsTheError)
end 