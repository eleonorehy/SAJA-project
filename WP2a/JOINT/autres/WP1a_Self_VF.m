sca; 
close all;
clearvars;

addpath('C:\Users\DEVAUX Alexandre\Documents\COGMASTER\Master 2\STAGE\Experience\Programme Experience\Function');
PsychDefaultSetup(2);
KbName('UnifyKeyNames');


% Préciser quel axe est controlé par le sujet
% Mettre à jour les consignes
% Déterminer les questions
% Si pause, alors l'installer à la moitié de la tâche i.e. essai 64
% Déterminer les gains
% Faire la même chose pour le WE programme avec séparation des écrans et
% distinction des claviers
% Trouver l'échelle manquante
% Ecrire l'annonce RISC


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

red = [255 0 0]; 
green = [0 255 0]; 
dot.Color = white;  

% Size 
penWidthPixels = 6; % size of the framed square
screenSize = [0 0 800 800]; % size of the screen = [] if full screen
dot.SizePix = [0 0 15 15]; % size of the mooving dot
baseRect = [0 0 90 90]; % size of the five square

% Quantity of movement
pixelsPerPressDot = 6; % how much the dot moove on the screen at each press

maxTime = 5;

numberOfTrials = 2; %128

sd_noise = 1; 
lowNoise = 5;
highNoise = 20;
% Scales 
space = 25;
size_line=5;

scaleNumber = 1:9;
scaleSpace=0.4:0.15:1.6;
% 
% data.Xaxe = [];
% data.Yaxe = [];
% data.Fluent = [];

% Psychtoolbox preferences
Screen('Preference', 'SkipSyncTests', 2);
Screen('Preference', 'DefaultFontName', 'helvetica');
Screen('Preference', 'DefaultFontSize', 30);
Screen('Preference', 'DefaultFontStyle', 0); 
Screen('Preference', 'DefaultTextYPositionIsBaseline', 1);

% Data storage
[condition,which,sub,gender,date,hour] = subjectVariables;
ResultFolderSelf = 'C:\Users\DEVAUX Alexandre\Documents\COGMASTER\Master 2\STAGE\Experience\Stockage Resultat\';
OutputFileTrainSelf = [ResultFolderSelf 'TrainSelf' sub '.mat'];
OutputFileMainSelf = [ResultFolderSelf 'MainSelf' sub '.mat'];

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
    for itrial=1:numberOfTrials
        
        data(itrial).Xaxe = [];
        data(itrial).Yaxe = [];
        data(itrial).Fluent = [];
        
        target = trials.gains(itrial); % specific value to reach in order to succed 
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
        
        Square1 = allRects(:,1);
        Square2 = allRects(:,2);
        Square3 = allRects(:,3);
        Square4 = allRects(:,4);
            
        Screen('Flip', expWindow);
        WaitSecs(2);
        
        TaskIsDown = false; 
        tStartTask = GetSecs;
        
        while TaskIsDown == false 

            [allRects, square] = DrawTheSquares(baseRect, Info);

            Screen('FillRect', expWindow, grey, allRects);
            centeredRect = CenterRectOnPointd(baseRect, Info.xC, Info.yC);

            Screen('FillRect', expWindow, grey, centeredRect);
            tex = Screen('MakeTexture', expWindow, RectNoise);
            Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);
            
            for ga=1:length(actualGain)
            DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
            end 
            centeredBall = CenterRectOnPointd(dot.SizePix, dot.Xpos, dot.Ypos);
            Screen('FillOval', expWindow, dot.Color, centeredBall, max(dot.SizePix));
             
            % CountDown
            WhatIsTheTime = tStartTask - GetSecs + maxTime;
            DrawFormattedText(expWindow, num2str(roundn(WhatIsTheTime, -2)), 'center', Info.yC/4, white);

            [keyIsDown,secs,keyCode] = KbCheck;
            if keyCode(Key.escape)
                ShowCursor;
                sca;
            end
            
            HowFluent = MakeTheNoise(lowNoise, highNoise);
            actualNoise = HowFluent(trials.fluency(itrial));
%             trials.fluency(itrial) = 10; 
%             HowFluent = - trials.fluency(itrial)+(trials.fluency(itrial)+trials.fluency(itrial))*rand(1,1);
            if keyCode(Key.left)
                dot.Xpos = dot.Xpos - pixelsPerPressDot + actualNoise;
            end
            if keyCode(Key.right)
                dot.Xpos = dot.Xpos + pixelsPerPressDot + actualNoise;
            end
            if keyCode(Key.up)
                dot.Ypos = dot.Ypos - pixelsPerPressDot + actualNoise;
            end
            if keyCode(Key.down)
                dot.Ypos = dot.Ypos + pixelsPerPressDot + actualNoise;
            end
            
            data(itrial).Xaxe = [data(itrial).Xaxe dot.Xpos];
            data(itrial).Yaxe = [data(itrial).Yaxe dot.Ypos];
            data(itrial).Fluent = [data(itrial).Fluent actualNoise];
            
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
                TaskIsDown = true;
                whichIsReached = Square1;
                results.Reach(itrial) = true;
            elseif allRects(1,2) < dot.Xpos && dot.Xpos < allRects(3,2) && allRects(2,2) < dot.Ypos && dot.Ypos < allRects(4,2)
                TaskIsDown = true;
                whichIsReached = Square2;
                results.Reach(itrial) = true;
            elseif allRects(1,3) < dot.Xpos && dot.Xpos < allRects(3,3) && allRects(2,3) < dot.Ypos && dot.Ypos < allRects(4,3)
                TaskIsDown = true;
                whichIsReached = Square3;
                results.Reach(itrial) = true;
            elseif allRects(1,4) < dot.Xpos && dot.Xpos < allRects(3,4) && allRects(2,4) < dot.Ypos && dot.Ypos < allRects(4,4)
                TaskIsDown = true;
                whichIsReached = Square4;
                results.Reach(itrial) = true;
            end
            
            Screen('Flip', expWindow);
            
            % Time to reach the square
            if GetSecs - tStartTask >= maxTime
                TaskIsDown = true;
                results.Reach(itrial) = false;
                results.Success(itrial) = 0;
                results.Gain(itrial) = 0; 
            end
              
        end % end of the reaching task
        
        results.Time(itrial) = WhatIsTheTime;
        
        % Validation screen
        dot.Xpos = Info.xC; 
        dot.Ypos = Info.yC;

        Screen('FillRect', expWindow, grey, allRects);
        Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);

        for ga=1:length(GainMatrix)
        DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15 , black);
        end
        
        if results.Reach(itrial) == true
            if whichIsReached == allRects(: ,actualGain~=1)
                results.Success(itrial) = 1;
                results.Gain(itrial) = target*0.01;
                frameColor = green;
            else
                results.Success(itrial) = 0;
                results.Gain(itrial) = 0; 
                frameColor = red;
            end
            Screen('FrameRect', expWindow, frameColor, whichIsReached, penWidthPixels);
        end
          
        
        Screen('Flip', expWindow);
        WaitSecs(0.2);
             
        Q_1 = 'Question 1';
        Q_2 = 'Question 2';

        % Q1 is white, Q2 is grey i.e. Q1 is to be answered
        Screen('TextSize', expWindow, 25);
        DrawFormattedText(expWindow, Q_1, 'center',Info.yC/3, white); 
        DrawFormattedText(expWindow, Q_2, 'center',4*Info.yC/3, grey); 

        Screen('TextSize', expWindow, 20);
        Screen('DrawLine', expWindow, white, Info.xC*0.4, 2*Info.yC/3, Info.xC*1.6, 2*Info.yC/3,4);
        for scale1=1:9
            DrawFormattedText(expWindow, num2str(scaleNumber(scale1)), Info.xC*scaleSpace(scale1),2*Info.yC/3+2*space, white);
            Screen('DrawLine', expWindow, white, Info.xC*scaleSpace(scale1), 2*Info.yC/3-size_line, Info.xC*scaleSpace(scale1), 2*Info.yC/3+size_line,4);
        end

        Screen('TextSize', expWindow, 20);    
        Screen('DrawLine', expWindow, grey, Info.xC*0.4, 5*Info.yC/3, Info.xC*1.6, 5*Info.yC/3,4); 
        for scale2=1:9
            DrawFormattedText(expWindow, num2str(scaleNumber(scale2)), Info.xC*scaleSpace(scale2),5*Info.yC/3+2*space, grey);
            Screen('DrawLine', expWindow, grey, Info.xC*scaleSpace(scale2), 5*Info.yC/3-size_line, Info.xC*scaleSpace(scale2), 5*Info.yC/3+size_line,4);
        end

        Screen('Flip', expWindow);
        
        Q1answered = false;
        tStartQuestion1 = GetSecs;
%         while Q1answered == false 
        [keyIsDown, secs, keyScale] = KbCheck;
        while keyScale == 0
            [keyIsDown, secs, keyScale] = KbCheck;
        end

        if keyScale(Key.escape)
            sca;
        elseif keyScale(Key.one)
            results.Answer_Q1(itrial) = 1;
            Q1answered = true;
        elseif keyScale(Key.two)
            results.Answer_Q1(itrial) = 2;
            Q1answered = true;
        elseif keyScale(Key.three)
            results.Answer_Q1(itrial) = 3;
            Q1answered = true;
        elseif keyScale(Key.four)
            results.Answer_Q1(itrial) = 4;
            Q1answered = true;
        elseif keyScale(Key.five)
            results.Answer_Q1(itrial) = 5;
            Q1answered = true;
        elseif keyScale(Key.six)
            results.Answer_Q1(itrial) = 6;
            Q1answered = true;
        elseif keyScale(Key.seven)
            results.Answer_Q1(itrial) = 7;
            Q1answered = true;
        elseif keyScale(Key.eight)
            results.Answer_Q1(itrial) = 8;
            Q1answered = true;
        elseif keyScale(Key.nine)
            results.Answer_Q1(itrial) = 9;
            Q1answered = true;
        else
            [keyIsDown, secs, keyScale] = KbCheck;
        end

        while not(keyScale(Key.one) == 0 && keyScale(Key.two) == 0 && keyScale(Key.three) == 0 && keyScale(Key.four) == 0 && keyScale(Key.five) == 0 && keyScale(Key.six) == 0 && keyScale(Key.seven) == 0 && keyScale(Key.eight) == 0 && keyScale(Key.nine) == 0)
            [keyIsDown, secs, keyScale] = KbCheck;
        end
%         end
        
        % Q1 is grey, Q2 is white i.e. Q2 is to be answered
        Screen('TextSize', expWindow, 25);
        DrawFormattedText(expWindow, Q_1, 'center',Info.yC/3, grey); 
        DrawFormattedText(expWindow, Q_2, 'center',4*Info.yC/3, white); 

        Screen('TextSize', expWindow, 20);
        Screen('DrawLine', expWindow, grey, Info.xC*0.4, 2*Info.yC/3, Info.xC*1.6, 2*Info.yC/3,4); %horizontal
        for scale1=1:9
            DrawFormattedText(expWindow, num2str(scaleNumber(scale1)), Info.xC*scaleSpace(scale1),2*Info.yC/3+2*space, grey);
            Screen('DrawLine', expWindow, grey, Info.xC*scaleSpace(scale1), 2*Info.yC/3-size_line, Info.xC*scaleSpace(scale1), 2*Info.yC/3+size_line,4); 
        end

        Screen('TextSize', expWindow, 20);    
        Screen('DrawLine', expWindow, white, Info.xC*0.4, 5*Info.yC/3, Info.xC*1.6, 5*Info.yC/3,4); %horizontal
        for scale2=1:9
            DrawFormattedText(expWindow, num2str(scaleNumber(scale2)), Info.xC*scaleSpace(scale2),5*Info.yC/3+2*space, white);
            Screen('DrawLine', expWindow, white, Info.xC*scaleSpace(scale2), 5*Info.yC/3-size_line, Info.xC*scaleSpace(scale2), 5*Info.yC/3+size_line,4);
        end

        Screen('Flip', expWindow);
        
        Q2answered = false;
        tStartQuestion2 = GetSecs;
        while Q2answered == false 
            [keyIsDown, secs, keyScale] = KbCheck;
            while keyScale == 0
                [keyIsDown, secs, keyScale] = KbCheck;
            end

            if keyScale(Key.escape)
                sca;
            end
            if keyScale(Key.one)
                results.Answer_Q2(itrial) = 1;
                Q2answered = true;
            elseif keyScale(Key.two)
                results.Answer_Q2(itrial) = 2;
                Q2answered = true;
            elseif keyScale(Key.three)
                results.Answer_Q2(itrial) = 3;
                Q2answered = true;
            elseif keyScale(Key.four)
                results.Answer_Q2(itrial) = 4;
                Q2answered = true;
            elseif keyScale(Key.five)
                results.Answer_Q2(itrial) = 5;
                Q2answered = true;
            elseif keyScale(Key.six)
                results.Answer_Q2(itrial) = 6;
                Q2answered = true;
            elseif keyScale(Key.seven)
                results.Answer_Q2(itrial) = 7;
                Q2answered = true;
            elseif keyScale(Key.eight)
                results.Answer_Q2(itrial) = 8;
                Q2answered = true;
            elseif keyScale(Key.nine)
                results.Answer_Q2(itrial) = 9;
                Q2answered = true;
            else
                [keyIsDown, secs, keyScale] = KbCheck;
            end

            while not(keyScale(Key.one) == 0 && keyScale(Key.two) == 0 && keyScale(Key.three) == 0 && keyScale(Key.four) == 0 && keyScale(Key.five) == 0 && keyScale(Key.six) == 0 && keyScale(Key.seven) == 0 && keyScale(Key.eight) == 0 && keyScale(Key.nine) == 0)
                [keyIsDown, secs, keyScale] = KbCheck;
            end
           
        end

        % Show the gains
        Screen('TextSize', expWindow, 30);   
        DrawFormattedText(expWindow, ['Vous avez gagné :' '\n \n' num2str(results.Gain(itrial)) ' euros'], 'center', 'center', white);
        Screen('Flip', expWindow);
        WaitSecs(1.5);
    end

    
    DrawFormattedText(expWindow, 'Merci de votre participation', 'center', 'center');
    Screen('Flip', expWindow);
    passKey(Key.space);
    
    save(OutputFileMainSelf, 'condition', 'which', 'sub', 'gender', 'date', 'hour', 'trials', 'results', 'data');
    
    Screen('Close', expWindow); 
    ShowCursor;
    
catch WhatsTheError
    Screen('CloseAll')
    rethrow(WhatsTheError)
end

    
    
     