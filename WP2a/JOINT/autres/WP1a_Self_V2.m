sca; 
close all;
clearvars;

addpath('C:\Users\DEVAUX Alexandre\Documents\COGMASTER\Master 2\STAGE\Experience\Programme Experience\Function'); % link to the additional files or functions

PsychDefaultSetup(2);

% -------------------------------------------------------------------------
% VARIABLES
% -------------------------------------------------------------------------

% Colors
black = [0 0 0]; white = [255 255 255]; grey = white/2; % square color

frameColor = [255 0 0]; % color of square reached
sd_noise = 1; % noise the fixation square

dot.Color = white; % color of the moving ball

% Size 
penWidthPixels = 6; % size of the framed square
screenSize = [0 0 800 800]; % size of the screen = [] if full screen
dot.SizePix = [0 0 15 15]; % size of the mooving dot
baseRect = [0 0 90 90]; % size of the five square
baseTilt = [0 0 4 20]; % size of tilt in self report scales

% Quantity of movement
pixelsPerPressDot = 20; % how much the dot moove on the screen at each press
pixelsPerPressedTilt = 5; % how much the dot moove on the scale at each press

% Gain Matrix
Gain = [1 1 1 2 ; 2 2 2 4 ; 1 1 1 2 ; 2 2 2 4];
NumbreScale = 1:9;
PlaceNumber = 0.30:0.05:0.70;
numberOfTrials = 4;

Screen('Preference', 'SkipSyncTests', 2); % 2 to skip tests, as we don't need milisecond precision, 0 otherwise
Screen('Preference', 'DefaultFontName', 'helvetica');
Screen('Preference', 'DefaultFontSize', 30);
Screen('Preference', 'DefaultFontStyle', 0); % 0=normal,1=bold,2=italic,4=underline,8=outline,32=condense,64=extend,1+2=bold and italic.
Screen('Preference', 'DefaultTextYPositionIsBaseline', 1); % Permet d'aligner le texte sur une ligne, mÃªme si des lettres hautes (h) ou basses (p) existent


% Key
Key.escape = KbName('ESCAPE'); % Quit the experiment
Key.up = KbName('UpArrow'); 
Key.down = KbName('DownArrow');
Key.left = KbName('LeftArrow'); 
Key.right = KbName('RightArrow');
Key.space = KbName('SPACE'); % Go to the next step

Key.one = KbName('1');
Key.two = KbName('2');
Key.three = KbName('3');
Key.four = KbName('4');
Key.five = KbName('5');
Key.six = KbName('6');
Key.seven = KbName('7');
Key.eight = KbName('8');
Key.nine  = KbName('9');

% -------------------------------------------------------------------------
% MAIN EXPERIMENT
% -------------------------------------------------------------------------


try
    
    [Info, expWindow] = GetTheThings(black, screenSize);
    
    % Ecran d'accueil
    AText = 'WELCOME \n \n Press space to continue';
    DrawFormattedText(expWindow, AText, 'center', 'center', white);
    Screen('Flip', expWindow);
    passKey(Key.space);
    
    dot.Xpos = Info.xC;
    dot.Ypos = Info.yC;
    RectNoise = (sd_noise*randn(baseRect(3),baseRect(4)));
    Screen('TextSize', expWindow, 30);
    
    for trial=1:length(numberOfTrials)
        
        
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
        actualGain=Shuffle(Gain(trial,:));
        for ga=1:length(actualGain)
        DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+30, allRects(2,ga)+20, black);
        end 
        
        Screen('Flip', expWindow)
        WaitSecs(2);
        
        squareIsReached = false;
        while squareIsReached == false
            
            Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);
        
            Screen('TextSize', expWindow, 40);
            actualGain=Shuffle(Gain(trial,:));
            for ga=1:length(actualGain)
            DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+30, allRects(2,ga)+20, black);
            end 
            
            [keyIsDown, secs, keyCode] = KbCheck;
            
            if keyCode(Key.escape)
                sca;
            end
            
            if keyCode(Key.left)
                dot.Xpos = dot.Xpos - pixelsPerPressDot;
            elseif keyCode(Key.right)
                dot.Xpos = dot.Xpos + pixelsPerPressDot;
            elseif keyCode(Key.up)
                dot.Ypos = dot.Ypos - pixelsPerPressDot;
            elseif keyCode(Key.down)
                dot.Ypos = dot.Ypos + pixelsPerPressDot;   
            end
            
            if dot.Xpos < dot.SizePix/2
                dot.Xpos = dot.SizePix/2;
            elseif dot.Xpos > Info.screenXpixels
                dot.Xpos = Info.screenXpixels - dot.SizePix/2;
            end

            if dot.Ypos < dot.SizePix/2
                dot.Ypos = dot.SizePix/2;
            elseif dot.Ypos > Info.screenYpixels
                dot.Ypos = Info.screenYpixels - dot.SizePix/2;
            end
            
            if allRects(1,1) < dot.Xpos && dot.Xpos < allRects(3,1) && allRects(2,1) < dot.Ypos && dot.Ypos < allRects(4,1)
                squareIsReached = true;
                whichIsReached = [allRects(1,1) allRects(2,1) allRects(3,1) allRects(4,1)];
            elseif allRects(1,2) < dot.Xpos && dot.Xpos < allRects(3,2) && allRects(2,2) < dot.Ypos && dot.Ypos < allRects(4,2)
                squareIsReached = true;
                whichIsReached = [allRects(1,2) allRects(2,2) allRects(3,2) allRects(4,2)];
            elseif allRects(1,3) < dot.Xpos && dot.Xpos < allRects(3,3) && allRects(2,3) < dot.Ypos && dot.Ypos < allRects(4,3)
                squareIsReached = true;
                whichIsReached = [allRects(1,3) allRects(2,3) allRects(3,3) allRects(4,3)];
            elseif allRects(1,4) < dot.Xpos && dot.Xpos < allRects(3,4) && allRects(2,4) < dot.Ypos && dot.Ypos < allRects(4,4)
                squareIsReached = true;
                whichIsReached = [allRects(1,4) allRects(2,4) allRects(3,4) allRects(4,4)];
            end
            
            Screen('Flip', expWindow);
             
        end
         
        % Afficher les gains et remettre à zero à chaque fois mais
        % conserver pour la somme de fin de tâche 
    end
     
    DrawFormattedText(expWindow, 'Thank you for your participation', 'center', 'center');

    Screen('Flip', expWindow);
    passKey(Key.space)
    Screen('Close', expWindow); 
    
catch WhatsTheError
    Screen('CloseAll')
    rethrow(WhatsTheError)
end
