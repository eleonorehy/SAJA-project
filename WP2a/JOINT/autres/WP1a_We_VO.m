sca; 
close all;
clearvars;

addpath('C:\Users\DEVAUX Alexandre\Documents\COGMASTER\Master 2\STAGE\Experience\Programme Experience\Function');
PsychDefaultSetup(2);
KbName('UnifyKeyNames');

% -------------------------------------------------------------------------
% VARIABLES
% -------------------------------------------------------------------------
 
% Key
Key.escape = KbName('ESCAPE'); Key.space = KbName('SPACE');
Key.up = KbName('UpArrow'); Key.down = KbName('DownArrow');
Key.left = KbName('LeftArrow'); Key.right = KbName('RightArrow');
Key.one = KbName('A'); Key.two = KbName('Z'); Key.three = KbName('E');
Key.four = KbName('R'); Key.five = KbName('T'); Key.six = KbName('Y');
Key.seven = KbName('U');Key.eight = KbName('I');Key.nine = KbName('O');
 
% Colors
black = [0 0 0]; 
white = [255 255 255]; 
grey = white/2; 

frameColor = [255 0 0]; 
dot.Color = white;  

sd_noise = 1; 

axis = 1;

% Size 
penWidthPixels = 6; % size of the framed square
screenSize = [0 0 800 800]; % size of the screen = [] if full screen
dot.SizePix = [0 0 15 15]; % size of the mooving dot
baseRect = [0 0 90 90]; % size of the five square

% Quantity of movement
pixelsPerPressDot = 20; % how much the dot moove on the screen at each press

maxTime = 5;

numberOfTrials = 2; %128

% Scales 
space = 25;
size_line=5;

scaleNumber = 1:9;
scaleSpace=0.1:0.1:0.9;

% Psychtoolbox preferences
Screen('Preference', 'SkipSyncTests', 2);
Screen('Preference', 'DefaultFontName', 'helvetica');
Screen('Preference', 'DefaultFontSize', 30);
Screen('Preference', 'DefaultFontStyle', 0); 
Screen('Preference', 'DefaultTextYPositionIsBaseline', 1);

% Data storage
% [condition1,which1,sub1,gender1,date1,hour1] = subjectVariables;
% [condition2,which2,sub2,gender2,date2,hour2] = subjectVariables;
% ResultFolderWe = 'C:\Users\DEVAUX Alexandre\Documents\COGMASTER\Master 2\STAGE\Experience\Stockage Resultat\';
% OutputFileWe = [ResultFolderSelf 'We' sub '.mat'];


% -------------------------------------------------------------------------
% TRANNING SESSION
%--------------------------------------------------------------------------

% The only difference between trainning sesssion and main experiment is the
% countdown timer, which is is the main one for now

% -------------------------------------------------------------------------
% MAIN EXPERIMENT
% -------------------------------------------------------------------------

try
    
    HideCursor;
    [Info, expWindow]=GetTheThings(black, screenSize);
    dot.Xpos = Info.xC; 
    dot.Ypos = Info.yC;
    RectNoise = (sd_noise*randn(baseRect(3),baseRect(4)));
    
    % Ecran d'accueil
    ALine1 = 'CONSIGNE';
    ALine2 = '\n\n Press space to continue'; 
    DrawFormattedText(expWindow, [ALine1 ALine2], 'center','center', white);

    Screen('Flip', expWindow);  
    passKey(Key.space);
    
    trials  = WP1a_trials(1); % function that conterbalance all the experimental conditions
    for trial=1:numberOfTrials
         
        target = trials.gains(trial); % specific value to reach in order to succed 
        GainMatrix = [1 1 1 target];
        actualGain=Shuffle(GainMatrix);
        
        [allRects, square] = DrawTheSquares(baseRect, Info);
        
        Screen('FillRect', expWindow, grey, allRects);
        centeredRect = CenterRectOnPointd(baseRect, Info.xC, Info.yC);

        Screen('FillRect', expWindow, grey, centeredRect);
        tex = Screen('MakeTexture', expWindow, RectNoise);
        Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);
        
        for ga=1:length(actualGain)
        DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
        end 
         
        Screen('Flip', expWindow);
        WaitSecs(2);
        
        squareIsReached = false; 
        tStartTask = GetSecs;
        
        while squareIsReached == false 

            [allRects, square] = DrawTheSquares(baseRect, Info);

            Screen('FillRect', expWindow, grey, allRects);
            centeredRect = CenterRectOnPointd(baseRect, Info.xC, Info.yC);

            Screen('FillRect', expWindow, grey, centeredRect);
            tex = Screen('MakeTexture', expWindow, RectNoise);
            Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);
            
            for ga=1:length(actualGain)
            [x,y] = DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
            end 
            centeredBall = CenterRectOnPointd(dot.SizePix, dot.Xpos, dot.Ypos);
            Screen('FillOval', expWindow, dot.Color, centeredBall, max(dot.SizePix));
            
            % CountDown
            DrawFormattedText(expWindow, num2str(roundn(tStartTask - GetSecs + maxTime, -2)), 'center', Info.yC/4, white);

            [keyIsDown,secs,keyCode] = KbCheck;
            if keyCode(Key.escape)
                ShowCursor;
                sca;
            end

            if axis == 1
                if keyCode(Key.left)
                    dot.Xpos = dot.Xpos - pixelsPerPressDot*trials.fluency(trial);
                    dot.Ypos = dot.Ypos + pixelsPerPressDot;
                    axis = 2;
                elseif keyCode(Key.right)
                    dot.Xpos = dot.Xpos + pixelsPerPressDot*trials.fluency(trial);
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
                    dot.Ypos = dot.Ypos - pixelsPerPressDot*trials.fluency(trial);
                    dot.Xpos = dot.Xpos - pixelsPerPressDot;
                    axis = 1;
                elseif keyCode(Key.down)
                    dot.Ypos = dot.Ypos + pixelsPerPressDot*trials.fluency(trial);
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
                results.whichIsReached(itrial) = [allRects(1,1) allRects(2,1) allRects(3,1) allRects(4,1)];
                Reached = true;
            elseif allRects(1,2) < dot.Xpos && dot.Xpos < allRects(3,2) && allRects(2,2) < dot.Ypos && dot.Ypos < allRects(4,2)
                squareIsReached = true;
                results.whichIsReached(itrial) = [allRects(1,2) allRects(2,2) allRects(3,2) allRects(4,2)];
                Reached = true;
            elseif allRects(1,3) < dot.Xpos && dot.Xpos < allRects(3,3) && allRects(2,3) < dot.Ypos && dot.Ypos < allRects(4,3)
                squareIsReached = true;
                results.whichIsReached(itrial) = [allRects(1,3) allRects(2,3) allRects(3,3) allRects(4,3)];
                Reached = true;
            elseif allRects(1,4) < dot.Xpos && dot.Xpos < allRects(3,4) && allRects(2,4) < dot.Ypos && dot.Ypos < allRects(4,4)
                squareIsReached = true;
                results.whichIsReached(itrial) = [allRects(1,4) allRects(2,4) allRects(3,4) allRects(4,4)];
                Reached = true;
            end
            
            Screen('Flip', expWindow);
            
            % Time to reach the square
            if GetSecs - tStartTask >= maxTime
                squareIsReached = true;
                Reached = false;
            end
            
        end % end of the reaching task
        
        % Validation screen
        dot.Xpos = Info.xC; 
        dot.Ypos = Info.yC;

        Screen('FillRect', expWindow, grey, allRects);
        Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);

        for ga=1:length(GainMatrix)
        DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15 , black);
        end 
        if Reached == true
            Screen('FrameRect', expWindow, frameColor, whichIsReached, penWidthPixels);
            gain = target*0.01;
        else
            gain = 0; 
        end

        Screen('Flip', expWindow);
        WaitSecs(0.2);
        
        % Evaluation of feeling of control
        
        
        Q_1 = 'Question 1';
        Q_2 = 'Question 2';

        Screen('DrawLine', expWindow, white, Info.xC, 0, Info.xC, Info.rect(4),2);
        
        % Q1 is white, Q2 is grey i.e. Q1 is to be answered
        Screen('TextSize', expWindow, 25);
        DrawFormattedText(expWindow, Q_1, Info.xC/2-80,Info.yC/3, white);
        DrawFormattedText(expWindow, Q_1, 3*Info.xC/2-80,Info.yC/3, white);
        DrawFormattedText(expWindow, Q_2, Info.xC/2-80,4*Info.yC/3, grey);
        DrawFormattedText(expWindow, Q_2, 3*Info.xC/2-80,4*Info.yC/3, grey);

        Screen('TextSize', expWindow, 20);
        Screen('DrawLine', expWindow, white, Info.xC*0.1, 2*Info.yC/3, Info.xC*0.9, 2*Info.yC/3,4);
        for scale1a=1:9
            DrawFormattedText(expWindow, num2str(scaleNumber(scale1a)), Info.xC*scaleSpace(scale1a)-10,2*Info.yC/3+2*space, white);
            Screen('DrawLine', expWindow, white, Info.xC*scaleSpace(scale1a), 2*Info.yC/3-size_line, Info.xC*scaleSpace(scale1a), 2*Info.yC/3+size_line,4);
        end

        Screen('DrawLine', expWindow, white, Info.xC*1.1, 2*Info.yC/3, Info.xC*1.9, 2*Info.yC/3,4);
        for scale1b=1:9
            DrawFormattedText(expWindow, num2str(scaleNumber(scale1b)), Info.xC*(scaleSpace(scale1b)+1)-10,2*Info.yC/3+2*space, white);
            Screen('DrawLine', expWindow, white, Info.xC*(scaleSpace(scale1b)+1), 2*Info.yC/3-size_line, Info.xC*(scaleSpace(scale1b)+1), 2*Info.yC/3+size_line,4);
        end
           
        Screen('DrawLine', expWindow, grey, Info.xC*0.1, 5*Info.yC/3, Info.xC*0.9, 5*Info.yC/3,4); 
        for scale2a=1:9
            DrawFormattedText(expWindow, num2str(scaleNumber(scale2a)), Info.xC*scaleSpace(scale2a),5*Info.yC/3+2*space, grey);
            Screen('DrawLine', expWindow, grey, Info.xC*scaleSpace(scale2a), 5*Info.yC/3-size_line, Info.xC*scaleSpace(scale2a), 5*Info.yC/3+size_line,4);
        end

        Screen('DrawLine', expWindow, grey, Info.xC*1.1, 5*Info.yC/3, Info.xC*1.9, 5*Info.yC/3,4); 
        for scale2b=1:9
            DrawFormattedText(expWindow, num2str(scaleNumber(scale2b)), Info.xC*(scaleSpace(scale2b)+1),5*Info.yC/3+2*space, grey);
            Screen('DrawLine', expWindow, grey, Info.xC*(scaleSpace(scale2b)+1), 5*Info.yC/3-size_line, Info.xC*(scaleSpace(scale2b)+1), 5*Info.yC/3+size_line,4);
        end
        Screen('Flip', expWindow);
                
        tStartQuestion1 = GetSecs;
        answer_Q1 = CheckTheScale(Key);
        
        % Q1 is grey, Q2 is white i.e. Q2 is to be answered
        Screen('TextSize', expWindow, 25);
        DrawFormattedText(expWindow, Q_1, 'center',Info.yC/3, grey); %bf: Info.yC/2
        DrawFormattedText(expWindow, Q_2, 'center',4*Info.yC/3, white); %bf 3*Info.yC/2

        Screen('TextSize', expWindow, 20);
        Screen('DrawLine', expWindow, grey, Info.xC*0.4, 2*Info.yC/3, Info.xC*1.6, 2*Info.yC/3,4); %horizontal
        for scale1b=1:9
            DrawFormattedText(expWindow, num2str(scaleNumber(scale1b)), Info.xC*scaleSpace(scale1b),2*Info.yC/3+2*space, grey);
            Screen('DrawLine', expWindow, grey, Info.xC*scaleSpace(scale1b), 2*Info.yC/3-size_line, Info.xC*scaleSpace(scale1b), 2*Info.yC/3+size_line,4); 
        end

        Screen('TextSize', expWindow, 20);    
        Screen('DrawLine', expWindow, white, Info.xC*0.4, 5*Info.yC/3, Info.xC*1.6, 5*Info.yC/3,4); %horizontal
        for scale2b=1:9
            DrawFormattedText(expWindow, num2str(scaleNumber(scale2b)), Info.xC*scaleSpace(scale2b),5*Info.yC/3+2*space, white);
            Screen('DrawLine', expWindow, white, Info.xC*scaleSpace(scale2b), 5*Info.yC/3-size_line, Info.xC*scaleSpace(scale2b), 5*Info.yC/3+size_line,4);
        end

        Screen('Flip', expWindow);

        answer_Q2 = CheckTheScale(Key);
                
        
        % Show the gains
        Screen('TextSize', expWindow, 30);   
        DrawFormattedText(expWindow, ['Vous avez gagné :' '\n \n' num2str(gain) ' euros'], 'center', 'center', white);
        Screen('Flip', expWindow);
        WaitSecs(1.5);

    end
    
    DrawFormattedText(expWindow, 'Merci de votre participation', 'center', 'center');
    Screen('Flip', expWindow);
    passKey(Key.space);
    
%     save(OutputFileSelf, trials, VD);
    
    Screen('Close', expWindow); 
    ShowCursor;
    
catch WhatsTheError
    Screen('CloseAll')
    rethrow(WhatsTheError)
end
    
    
    