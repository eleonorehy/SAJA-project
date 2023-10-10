sca; 
close all;
clearvars;

addpath('C:\Users\DEVAUX Alexandre\Documents\COGMASTER\Master 2\STAGE\Experience\Programme Experience\Function'); % link to the additional files or functions

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

% Data from trials function
axis = 1;

% Exit





% -------------------------------------------------------------------------
% MAIN EXPERIMENT
% -------------------------------------------------------------------------

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
    
    trial = 3;
    while trial < numberOfTrials+1 
        actualGain=Shuffle(Gain(trial,:));
        if mod(trial,2) == 1
            p = 0.25;
            n = 0.5;
        elseif mod(trial,2) == 0
            p = 0.75;
        end
        if trial == 1 || trial == 2
            agent = 1;
        elseif trial == 3 || trial == 4
            agent = 2;
        end
        
        P = p+(p+p)*rand;
        N = n+(n+n)*rand;
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
        
        squareIsReached = false; 
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
            
            for ga=1:length(actualGain)
            [x,y] = DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+30, allRects(2,ga)+20, black);
            end 
            centeredBall = CenterRectOnPointd(dot.SizePix, dot.Xpos, dot.Ypos);
            Screen('FillOval', expWindow, dot.Color, centeredBall, max(dot.SizePix));
            Screen('TextSize', expWindow, 40);


            Screen('Flip', expWindow);

            [keyIsDown,secs,keyCode] = KbCheck;

            if keyCode(Key.escape)
                sca;
            end

            if axis == 1
                if keyCode(Key.left)
                    dot.Xpos = dot.Xpos - pixelsPerPressDot*P;
                    dot.Ypos = dot.Ypos + pixelsPerPressDot;
                    axis = 2;
                elseif keyCode(Key.right)
                    dot.Xpos = dot.Xpos + pixelsPerPressDot*P;
                    dot.Ypos = dot.Ypos + pixelsPerPressDot ;
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
                    dot.Ypos = dot.Ypos - pixelsPerPressDot*P;
                    dot.Xpos = dot.Xpos - pixelsPerPressDot;
                    axis = 1;
                elseif keyCode(Key.down)
                    dot.Ypos = dot.Ypos + pixelsPerPressDot*P;
                    dot.Xpos = dot.Xpos + pixelsPerPressDot;
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
        
        dot.Xpos = Info.xC; 
        dot.Ypos = Info.yC;
        
        Screen('FillRect', expWindow, grey, allRects);
        Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);
        
        Screen('TextSize', expWindow, 40);
        for ga=1:length(Gain)
        DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+30, allRects(2,ga)+20, black);
        end 
        Screen('FrameRect', expWindow, frameColor, whichIsReached, penWidthPixels);

        Screen('Flip', expWindow);
        WaitSecs(0.2);
        
        Screen('TextSize', expWindow, 30);
        P1Line1 = 'Player 1:';
        P1Line2 = '\n \n   x €';
        [x,y] = DrawFormattedText(expWindow, [P1Line1 P1Line2], Info.rect(3)*0.25-88, Info.rect(4)*0.25, white);
        P2Line1 = 'Player 2:';
        P2Line2 = '\n \n   y €';
        [x2,y2] = DrawFormattedText(expWindow, [P2Line1 P2Line2], Info.rect(3)*0.75-88, Info.rect(4)*0.25, white);
        TLine1 = 'The team earned:';
        TLine2 = '\n \n     x + y €';
        [x3,y3] = DrawFormattedText(expWindow, [TLine1 TLine2], Info.rect(3)*0.5-176, Info.rect(4)*0.6, white);
        
        Screen('Flip', expWindow)
        WaitSecs(2);
        

        % self agency add to the trial function the 50-50
        selfPos = 0.25 + (0.25+0.25)*rand;
        tilt.XposSelf = Info.rect(3)*selfPos;
        tilt.YposSelf = Info.rect(4)*0.5; 

        wePos = 0.25 + (0.25+0.25)*rand;
        tilt.XposWe = Info.rect(3)*wePos;
        tilt.YposWe = Info.rect(4)*0.5; 
        
        exitSelfReport = false;
        while exitSelfReport == false
            
            Screen('TextSize', expWindow, 30);
            if agent == 1 && trial == 1
            selfLine1 = 'How much did your';
            selfLine2 = '\n \n left hand contribute?';
            elseif agent == 1 && trial == 2
            selfLine1 = 'How much did your';
            selfLine2 = '\n \n right hand contribute?';
            elseif agent == 2 && trial == 3
            selfLine1 = 'How much did';
            selfLine2 = '\n \n you contribute?';
            elseif agent == 2 && trial == 4
            selfLine1 = 'How much did';
            selfLine2 = '\n \n the co-actor contribute?';    
            end
            DrawFormattedText(expWindow, [selfLine1 selfLine2], 'center',Info.rect(4)*0.25, white);
            Screen('TextSize', expWindow, 25);
            
            for number = 1:9
            DrawFormattedText(expWindow, num2str(NumbreScale(number)),Info.rect(3)*PlaceNumber(number),Info.rect(4)*0.5+15,white);
            Screen('DrawLine', expWindow, white, Info.rect(3)*PlaceNumber(number), Info.rect(4)*0.5-7, Info.rect(3)*PlaceNumber(number), Info.rect(4)*0.5+7,4);
            end

            Screen('DrawLine', expWindow, white, Info.rect(3)*0.25, Info.rect(4)*0.5, Info.rect(3)*0.75, Info.rect(4)*0.5,4);
%             Screen('DrawLine', expWindow, white, Info.rect(3)*0.25, Info.rect(4)*0.5-7, Info.rect(3)*0.25, Info.rect(4)*0.5+7,4);
%             Screen('DrawLine', expWindow, white, Info.rect(3)*0.75, Info.rect(4)*0.5-7, Info.rect(3)*0.75, Info.rect(4)*0.5+7,4);

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
            end

            centeredTiltSelf = CenterRectOnPointd(baseTilt, tilt.XposSelf, tilt.YposSelf);
            Screen('FillRect', expWindow, white, centeredTiltSelf);

            Screen('Flip', expWindow);
        end
        WaitSecs(0.2)
        % we agency add to the trial function the 50-50
        
        
        % Change the modality of response. Here we want a scale from 1 (low
        % feeling) to 9 (hight feeling)
        
        exitWeReport = false; 
        while exitWeReport == false

            Screen('TextSize', expWindow, 30);
            if agent == 1
            weLine1 = 'How much did your';
            weLine2 = '\n \n hands contribute?';
            elseif agent == 2
            weLine1 = 'How much did';
            weLine2 = '\n \n the team contribute?';
            end 
            DrawFormattedText(expWindow, [weLine1 weLine2], 'center',Info.rect(4)*0.25, white)

            Screen('TextSize', expWindow, 25);
            
            for i=1:9
            DrawFormattedText(expWindow, str(i),Info.rect(3)*0.,Info.rect(4)*0.5+15,white); 
            end
%             for i=1:9
%             DrawFormattedText(expWindow, '1',Info.rect(3)*0.25-12,Info.rect(4)*0.5+15,white); 
%             DrawFormattedText(expWindow, '9',Info.rect(3)*0.75-36,Info.rect(4)*0.5+15,white); 
%             end
%             Screen('DrawLine', expWindow, white, Info.rect(3)*0.25, Info.rect(4)*0.5, Info.rect(3)*0.75, Info.rect(4)*0.5,4)
%             Screen('DrawLine', expWindow, white, Info.rect(3)*0.25, Info.rect(4)*0.5-7, Info.rect(3)*0.25, Info.rect(4)*0.5+7,4)
%             Screen('DrawLine', expWindow, white, Info.rect(3)*0.75, Info.rect(4)*0.5-7, Info.rect(3)*0.75, Info.rect(4)*0.5+7,4)

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
            end

            centeredTiltWe = CenterRectOnPointd(baseTilt, tilt.XposWe, tilt.YposWe);
            Screen('FillRect', expWindow, white, centeredTiltWe);

            Screen('Flip',expWindow)

        end
        trial = trial + 1;
    end
    
    DrawFormattedText(expWindow, 'Thank you for your participation', 'center', 'center');

    Screen('Flip', expWindow);
    passKey(Key.space)
    Screen('Close', expWindow); 
    
catch WhatsTheError
    Screen('CloseAll')
    rethrow(WhatsTheError)
end
    
    
    