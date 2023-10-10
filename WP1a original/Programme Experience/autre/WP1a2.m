 sca; 
close all;
clearvars;

addpath('C:\Users\DEVAUX Alexandre\Documents\COGMASTER\Master 2\STAGE\Programme\Pretest'); % link to the additional files or functions

PsychDefaultSetup(2);

% What to do next : introduction of turbulences (both ways) and link to
% trials function and make the welcoming screen and the win/loose screen
% and the conversion rule to go from the scale to a value between 0 and 100


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
dot.SizePix = [0 0 10 10]; % size of the mooving dot
baseRect = [0 0 75 75]; % size of the five square
baseTilt = [0 0 4 20]; % size of tilt in self report scales

% Quantity of movement
pixelsPerPressDot = 20; % how much the dot moove on the screen at each press
pixelsPerPressedTilt = 10; % how much the dot moove on the scale at each press

% Gain Matrix
Gain = [1 1 1 2 ; 2 2 2 4 ; 1 1 1 2 ; 2 2 2 4];

numberOfTrials = 4;

% Data from trials function
axis = 1;

% Exit
squareIsReached = false; 
exitSelfReport = false;
exitWeReport = false;



% -------------------------------------------------------------------------
% MAIN EXPERIMENT
% -------------------------------------------------------------------------

try
    
    [Info, expWindow]=GetTheThings(black, screenSize);

    dot.Xpos = Info.xC; 
    dot.Ypos = Info.yC;
    RectNoise = (sd_noise*randn(baseRect(3),baseRect(4))+0.5);
    Screen('TextSize', expWindow, 40);
    
    % Ecran d'accueil
    
    for trial=1:length(numberOfTrials)

        while squareIsReached == false

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

            centeredBall = CenterRectOnPointd(dot.SizePix, dot.Xpos, dot.Ypos);
            Screen('FillOval', expWindow, dot.Color, centeredBall, max(dot.SizePix));

            for ga=1:length(Gain)
            [x,y] = DrawFormattedText(expWindow, num2str(Gain(ga)), allRects(1,ga)+20, allRects(2,ga)+20, black);
            end 

            Screen('Flip', expWindow);

            [keyIsDown,secs,keyCode] = KbCheck;

            if keyCode(Key.escape)
                sca;
            end

            if axis == 1
                if keyCode(Key.left)
                    dot.Xpos = dot.Xpos - pixelsPerPressDot;
                    dot.Ypos = dot.Ypos + 0*pixelsPerPressDot;
                    axis = 2;
                elseif keyCode(Key.right)
                    dot.Xpos = dot.Xpos + pixelsPerPressDot;
                    dot.Ypos = dot.Ypos + 0*pixelsPerPressDot;
                    axis = 2;
                elseif keyCode(Key.up)
                    dot.Ypos = dot.Ypos;
                elseif keyCode(Key.down)
                    dot.Ypos = dot.Ypos;
                end

            elseif axis == 2 
                if keyCode(Key.left)
                    dot.Xpos = dot.Xpos;
                elseif keyCode(Key.right)
                    dot.Xpos = dot.Xpos;
                elseif keyCode(Key.up)
                    dot.Ypos = dot.Ypos - pixelsPerPressDot;
                    dot.Xpos = dot.Xpos + 0*pixelsPerPressDot;
                    axis = 1;
                elseif keyCode(Key.down)
                    dot.Ypos = dot.Ypos + pixelsPerPressDot;
                    dot.Xpos = dot.Xpos + 0*pixelsPerPressDot;
                    axis = 1;
                end

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

            % End of the trial when the dot reach a square
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

        end % end of the reaching task

    %     centeredRect = CenterRectOnPointd(baseRect, Info.xC, Info.yC);
        Screen('FillRect', expWindow, grey, allRects);
    %     Screen( 'FillRect', expWindow, grey, centeredRect);
    %     tex = Screen('MakeTexture', expWindow, RectNoise);
        Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);

        for ga=1:length(Gain)
        [x,y] = DrawFormattedText(expWindow, num2str(Gain(ga)), allRects(1,ga), allRects(2,ga), black);
        end 
        Screen('FrameRect', expWindow, frameColor, whichIsReached, penWidthPixels);

        Screen('Flip', expWindow);
        WaitSecs(2);

        % self agency add to the trial function the 50-50
        selfPos = 0.25 + (0.25+0.25)*rand;
        tilt.XposSelf = Info.rect(3)*selfPos;
        tilt.YposSelf = Info.rect(4)*0.5; 

        wePos = 0.25 + (0.25+0.25)*rand;
        tilt.XposWe = Info.rect(3)*wePos;
        tilt.YposWe = Info.rect(4)*0.5; 

        while exitSelfReport == false

            Screen('TextSize', expWindow, 25);
            selfLine1 = 'How much do you feel in control';
            selfLine2 = '\n\n with your right hand?';
            DrawFormattedText(expWindow, [selfLine1 selfLine2], 'center',Info.rect(4)*0.25, white);
            Screen('TextSize', expWindow, 20);
            DrawFormattedText(expWindow, '0',Info.rect(3)*0.25-12,Info.rect(4)*0.5+10,white); 
            DrawFormattedText(expWindow, '100',Info.rect(3)*0.75-36,Info.rect(4)*0.5+10,white); 

            Screen('DrawLine', expWindow, white, Info.rect(3)*0.25, Info.rect(4)*0.5, Info.rect(3)*0.75, Info.rect(4)*0.5,4);
            Screen('DrawLine', expWindow, white, Info.rect(3)*0.25, Info.rect(4)*0.5-7, Info.rect(3)*0.25, Info.rect(4)*0.5+7,4);
            Screen('DrawLine', expWindow, white, Info.rect(3)*0.75, Info.rect(4)*0.5-7, Info.rect(3)*0.75, Info.rect(4)*0.5+7,4);

            [keyIsDown, secs, keyCode] = KbCheck;

            if keyCode(Key.escape)
                sca;
            elseif keyCode(Key.space)
                exitSelfReport = true;
            end

            if keyCode(Key.left)
                tilt.XposSelf = tilt.XposSelf - pixelsPerPressedTilt;
            elseif keyCode(Key.right)
                tilt.XposSelf = tilt.XposSelf + pixelsPerPressedTilt;
            end

            if tilt.XposSelf <Info.rect(3)*0.25
                tilt.XposSelf = Info.rect(3)*0.25;
            elseif tilt.XposSelf > Info.rect(3)*0.75
                tilt.XposSelf = Info.rect(3)*0.75;
                exitSelfReport = true;
            end

            centeredTiltSelf = CenterRectOnPointd(baseTilt, tilt.XposSelf, tilt.YposSelf);
            Screen('FillRect', expWindow, white, centeredTiltSelf);

            Screen('Flip', expWindow);
        end

        % we agency add to the trial function the 50-50
        while exitWeReport == false

            Screen('TextSize', expWindow, 25);
            weLine1 = 'How much do you feel in control';
            weLine2 = '\n\n with yourself?';
            DrawFormattedText(expWindow, [weLine1 weLine2], 'center',Info.rect(4)*0.25, white)
            Screen('TextSize', expWindow, 20);
            DrawFormattedText(expWindow, '0',Info.rect(3)*0.25-12,Info.rect(4)*0.5+10,white); 
            DrawFormattedText(expWindow, '100',Info.rect(3)*0.75-36,Info.rect(4)*0.5+10,white); 

            Screen('DrawLine', expWindow, white, Info.rect(3)*0.25, Info.rect(4)*0.5, Info.rect(3)*0.75, Info.rect(4)*0.5,4)
            Screen('DrawLine', expWindow, white, Info.rect(3)*0.25, Info.rect(4)*0.5-7, Info.rect(3)*0.25, Info.rect(4)*0.5+7,4)
            Screen('DrawLine', expWindow, white, Info.rect(3)*0.75, Info.rect(4)*0.5-7, Info.rect(3)*0.75, Info.rect(4)*0.5+7,4)

            [keyIsDown, secs, keyCode] = KbCheck;

            if keyCode(Key.escape)
                sca;
            elseif keyCode(Key.space)
                exitWeReport = true;
            end

            if keyCode(Key.left)
                tilt.XposWe = tilt.XposWe - pixelsPerPressedTilt;
            elseif keyCode(Key.right)
                tilt.XposWe = tilt.XposWe + pixelsPerPressedTilt;
            end

            if tilt.XposWe <Info.rect(3)*0.25
                tilt.XposWe = Info.rect(3)*0.25;
            elseif tilt.XposWe > Info.rect(3)*0.75
                tilt.XposWe = Info.rect(3)*0.75;
                exitWeReport = true;
            end

            centeredTiltWe = CenterRectOnPointd(baseTilt, tilt.XposWe, tilt.YposWe);
            Screen('FillRect', expWindow, white, centeredTiltWe);

            Screen('Flip',expWindow)

        end

        Fline1 = 'L''expérience est terminée';
        Fline2 = '\n \n Merci pour votre participation';
        Fline3 = '\n \n Appuyer sur espace pour quitter';
        DrawFormattedText(expWindow, [Fline1 Fline2 Fline3], 'center', 'center');

        Screen('Flip', expWindow);
        passKey(Key.space)
    end
    Screen('Close', expWindow); 
    
catch WhatsTheError
    Screen('CloseAll')
    rethrow(WhatsTheError)
end
    
    
    