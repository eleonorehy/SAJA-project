% CLEANING
close all;
clear all;

%addpath('C:\Users\DEVAUX Alexandre\Documents\COGMASTER\Master 2\STAGE\ExperienceFinal\Programme Experience\Function');
 
addpath('/Users/agencyteam/Desktop/SLB IJN/pilote2/Programme Experience/Function');
PsychDefaultSetup(2);
KbName('UnifyKeyNames');

% NOT WRITTING IN THE SCRIPT DURING THE EXPERIMENT
input('Appuyez sur ENTREE')
KbWait;


% -------------------------------------------------------------------------
% VARIABLES
% -------------------------------------------------------------------------
 
% Key QWERTY A = Q ; Z = W; K = K ; L = L
Key.escape = KbName('ESCAPE'); Key.space = KbName('SPACE');
Key.up = KbName('A'); Key.down = KbName('Z');
Key.left = KbName('K'); Key.right = KbName('L');

%CODE RESPONSE SCALE 1
Key.one1 = KbName('1!'); Key.two1 = KbName('2@'); Key.three1 = KbName('3#');
Key.four1 = KbName('4$'); Key.five1 = KbName('5%'); Key.six1 = KbName('6^');
Key.seven1 = KbName('7&');Key.eight1 = KbName('8*');Key.nine1 = KbName('9(');

%CODE REPONSE SCALE 2
Key.one2 = KbName('Q'); Key.two2 = KbName('W'); Key.three2 = KbName('E');
Key.four2 = KbName('R'); Key.five2 = KbName('T'); Key.six2 = KbName('Y');
Key.seven2 = KbName('U');Key.eight2 = KbName('I');Key.nine2 = KbName('O');
 
% Colors
black = [0 0 0]; 
white = [255 255 255]; 
grey = white/2; 
red = [255 0 0]; 
green = [0 255 0];
     
dot.Color = white;

% Size 
screenSize = [];

penWidthPixels = 6; % size of the framed square
dot.SizePix = [0 0 15 15]; % size of the mooving dot

baseRect = [0 0 90 90]; % size of the five square

% Quantity of movement
pixelsPerPressDot = 6; % how much the dot moove on the screen at each press

maxTime = 5;

numberOfTrials = 128; 

trialsPerBlock = 32;

cagnotte = 7.5; % cagnotte de base

% NUMBER OF TARGETs

%numberOfEasyTarget = 128;
%numberOfBasicTarget = 128;

% Visual white noise
sd_noise = 1; 

% Fluency  
lowNoise = 2.5;
%lowNoise = 0;
highNoise = 5; 
%highNoise = 0;


% Audio white noise
sr = 44100;
d = 1000;  
noise = (rand(1, round(sr*d))*2)-1;
 
% Scales       
space = 25;
size_line=5;
scaleNumber = 1:9;
scaleSpace=0.4:0.15:1.6;

% Psychtoolbox preferences
Screen('Preference', 'SkipSyncTests', 2);
Screen('Preference', 'DefaultFontSize', 30);
Screen('Preference', 'DefaultFontStyle', 0); 
Screen('Preference', 'DefaultTextYPositionIsBaseline', 1);
  
% % Data storage
[condition,which,sub,gender,date] = subjectVariables;
ResultFolderSelf = '/Users/agencyteam/Desktop/SLB IJN/pilote2/Stockage Resultat/';
OutputFileMainSelf = [ResultFolderSelf 'pilote2' sub '.mat'];

% -------------------------------------------------------------------------
% MAIN EXPERIMENT
% -------------------------------------------------------------------------

try
    
    HideCursor;
    [Info, expWindow]=GetTheThings(black, screenSize);
    nXi = Info.xC - Info.rect(4)/2;

    dot.Xpos = Info.xC; 
    dot.Ypos = Info.yC;
    RectNoise = (sd_noise*randn(baseRect(3),baseRect(4)));
    
    % Ecran d'accueil
    sound(noise,sr);
    DrawFormattedText(expWindow, 'Appuyer sur espace pour commencer', 'center','center', white);

    Screen('Flip', expWindow);  
    passKey(Key.space);
    
    trials  = WP1a_trials; % function that conterbalances all the experimental conditions
    DrawFormattedText(expWindow, 'Placez votre main GAUCHE sur\n \nles fleches HAUT et BAS', 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);            
    DrawFormattedText(expWindow, 'Placez votre main DROITE sur\n \nles fleches GAUCHE et DROITE', 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]); 
    Screen('Flip', expWindow);
    WaitSecs(3.5)
    
    % Set variables 
                
     HiLeSquare = 0;
     HiRiSquare = 0;
     LoLeSquare = 0;
     LoRiSquare = 0;
     missTrials = 0;
     succeedTrials = 0;
     errTrials = 0;
    
    for itrial=1:numberOfTrials
        %if itrial ~= 1 && isfinite(trials.axisControl(itrial))
            %DrawFormattedText(expWindow, 'Vous  avez le droit a une pause\n \nAppuyer sur espace pour reprendre', 'center', 'center', white);            
            %Screen('Flip', expWindow);
            %passKey(Key.space);
        %end
        
        %creation dependant variables concerning cursor location, fluent factor, keypresses
        data(itrial).Xaxe = [];
        data(itrial).Yaxe = [];
        data(itrial).Fluent = [];
        data(itrial).Up = [];
        data(itrial).Down = [];
        data(itrial).Left = [];
        data(itrial).Right = [];
        
        target = trials.gains(itrial); % specific value to reach in order to succeed
        targetPosition = trials.position(itrial);
        %targetBasic = trials.basic(itrial);
        %targetEasy = trials.easy(itrial);
       
        actualGain = [1 1 1 1];
        actualGain(targetPosition) = target;
        easyGain = randi([2,5],1);
        
        [allRects, square] = DrawTheSquares(baseRect, Info, nXi); % specific fonction that draws 4 squares    
        Screen('FillRect', expWindow, grey, allRects);
        
        centeredRect = CenterRectOnPointd(baseRect, Info.xC, Info.yC);
        Screen('FillRect', expWindow, grey, centeredRect);
        
        tex = Screen('MakeTexture', expWindow, RectNoise);
        Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);
       
        
        %%% TRIAL TYPE EASY / NORMAl
        
        % BASIC condition, 1 target to reach, easy code == 1
        
        if trials.easy(itrial) == 1 
            
            for ga=1:length(actualGain) % position of gains in squares
            DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
            %DrawFormattedText(expWindow, num2str(easyGain), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
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

                [allRects, square] = DrawTheSquares(baseRect, Info, nXi); % draws the squares, beginning trials
                Screen('FillRect', expWindow, grey, allRects);

                centeredRect = CenterRectOnPointd(baseRect, Info.xC, Info.yC);
                Screen('FillRect', expWindow, grey, centeredRect);

                tex = Screen('MakeTexture', expWindow, RectNoise);
                Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);

                for ga=1:length(actualGain)
                DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
                %DrawFormattedText(expWindow, num2str(easyGain), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
                end 
                centeredBall = CenterRectOnPointd(dot.SizePix, dot.Xpos, dot.Ypos);
                Screen('FillOval', expWindow, dot.Color, centeredBall, max(dot.SizePix));

                % CountDown
                WhatIsTheTime = tStartTask - GetSecs + maxTime;
                DrawFormattedText(expWindow, num2str(roundn(WhatIsTheTime, -2)), 'center', Info.yC/5, white);

                [keyIsDown,secs,keyCode] = KbCheck;
                if keyCode(Key.escape)
                    ShowCursor;
                    sca;
                    clear sound
                end

                HowFluent = MakeTheNoise(lowNoise, highNoise);
                actualNoise = HowFluent(trials.fluency(itrial));
                upKP = 0;
                downKP = 0;
                leftKP = 0;
                rightKP = 0;
     

                if keyCode(Key.left)
                    dot.Xpos = dot.Xpos - pixelsPerPressDot;
                    dot.Ypos = dot.Ypos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 0;
                    downKP = downKP + 0;
                    leftKP = leftKP + 1;
                    rightKP = rightKP + 0;                    
                end
                if keyCode(Key.right)
                    dot.Xpos = dot.Xpos + pixelsPerPressDot;
                    dot.Ypos = dot.Ypos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 0;
                    downKP = downKP + 0;
                    leftKP = leftKP + 0;
                    rightKP = rightKP + 1;
                end
                if keyCode(Key.up)
                    dot.Ypos = dot.Ypos - pixelsPerPressDot;
                    dot.Xpos = dot.Xpos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 1;
                    downKP = downKP + 0;
                    leftKP = leftKP + 0;
                    rightKP = rightKP + 0;
                end
                if keyCode(Key.down)
                    dot.Ypos = dot.Ypos + pixelsPerPressDot;
                    dot.Xpos = dot.Xpos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 0;
                    downKP = downKP + 1;
                    leftKP = leftKP + 0;
                    rightKP = rightKP + 0;
                end

                data(itrial).Xaxe = [data(itrial).Xaxe dot.Xpos];
                data(itrial).Yaxe = [data(itrial).Yaxe dot.Ypos];
                data(itrial).Fluent = [data(itrial).Fluent actualNoise];
                data(itrial).Up = [data(itrial).Up upKP];
                data(itrial).Down = [data(itrial).Down downKP];
                data(itrial).Left = [data(itrial).Left leftKP];
                data(itrial).Right = [data(itrial).Right rightKP];

                % AVOIDING THE DOT TO GET OFF THE WINDOW
                if dot.Xpos < 10
                    dot.Xpos = 10;
                elseif dot.Xpos > Info.screenXpixels - 10
                    dot.Xpos = Info.screenXpixels - 10;
                end

                if dot.Ypos < 10
                    dot.Ypos = 10;
                elseif dot.Ypos > Info.screenYpixels - 10
                    dot.Ypos = Info.screenYpixels - 10;
                end

                % End of the trial when the dot reaches a square (dot reaches
                % one square limits)
                if allRects(1,1) < dot.Xpos && dot.Xpos < allRects(3,1) && allRects(2,1) < dot.Ypos && dot.Ypos < allRects(4,1)
                    TaskIsDown = true;
                    whichIsReached = Square1;
                    results.Reach(itrial) = true;
                    %HiLeSquare = HiLeSquare + 1;                                                               
                elseif allRects(1,2) < dot.Xpos && dot.Xpos < allRects(3,2) && allRects(2,2) < dot.Ypos && dot.Ypos < allRects(4,2)
                    TaskIsDown = true;
                    whichIsReached = Square2;
                    results.Reach(itrial) = true;
                    %LoLeSquare = LoLeSquare + 1;
                elseif allRects(1,3) < dot.Xpos && dot.Xpos < allRects(3,3) && allRects(2,3) < dot.Ypos && dot.Ypos < allRects(4,3)
                    TaskIsDown = true;
                    whichIsReached = Square3;
                    results.Reach(itrial) = true;
                    %HiRiSquare = HiRiSquare + 1;
                elseif allRects(1,4) < dot.Xpos && dot.Xpos < allRects(3,4) && allRects(2,4) < dot.Ypos && dot.Ypos < allRects(4,4)
                    TaskIsDown = true;
                    whichIsReached = Square4;
                    results.Reach(itrial) = true;
                    %LoRiSquare = LoRiSquare + 1;
                end

                Screen('Flip', expWindow);

                % End of the trial when the dot does not reach a square 
                % Time to reach the square
                if GetSecs - tStartTask >= maxTime
                    TaskIsDown = true;
                    results.Reach(itrial) = false;
                    results.Success(itrial) = 0;
                    results.Gain(itrial) = 0; 
                    missTrials = missTrials + 1;
                end

            end % end of the reaching task

            results.Time(itrial) = WhatIsTheTime;

            % Validation screen
            dot.Xpos = Info.xC; 
            dot.Ypos = Info.yC;

            Screen('FillRect', expWindow, grey, allRects);
            Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);

            for ga=1:length(actualGain)
            DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15 , black);
            %DrawFormattedText(expWindow, num2str(easyGain), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
            end

            if results.Reach(itrial) == true
                if whichIsReached == allRects(: ,actualGain~=1)
                    results.Success(itrial) = 1;
                    results.Gain(itrial) = 1;
                    frameColor = green;
                    succeedTrials = succeedTrials + 1;
                else
                    results.Success(itrial) = 0;
                    results.Gain(itrial) = 0; 
                    frameColor = red;
                    errTrials = errTrials + 1;
                end
                Screen('FrameRect', expWindow, frameColor, whichIsReached, penWidthPixels);
            end

            Screen('Flip', expWindow);
            WaitSecs(0.2);
            
        % EASY condition, 4 targets to reach, code == 2
        
        elseif trials.easy(itrial) == 2
        
            for ga=1:length(actualGain) % position of gains in squares
            %DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
            DrawFormattedText(expWindow, num2str(easyGain), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
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

                [allRects, square] = DrawTheSquares(baseRect, Info, nXi); % draws the squares, beginning trials
                Screen('FillRect', expWindow, grey, allRects);

                centeredRect = CenterRectOnPointd(baseRect, Info.xC, Info.yC);
                Screen('FillRect', expWindow, grey, centeredRect);

                tex = Screen('MakeTexture', expWindow, RectNoise);
                Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);

                for ga=1:length(actualGain)
                %DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
                DrawFormattedText(expWindow, num2str(easyGain), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
                end 
                centeredBall = CenterRectOnPointd(dot.SizePix, dot.Xpos, dot.Ypos);
                Screen('FillOval', expWindow, dot.Color, centeredBall, max(dot.SizePix));

                % CountDown
                WhatIsTheTime = tStartTask - GetSecs + maxTime;
                DrawFormattedText(expWindow, num2str(roundn(WhatIsTheTime, -2)), 'center', Info.yC/5, white);

                [keyIsDown,secs,keyCode] = KbCheck;
                if keyCode(Key.escape)
                    ShowCursor;
                    sca;
                    clear sound
                end

                HowFluent = MakeTheNoise(lowNoise, highNoise);
                actualNoise = HowFluent(trials.fluency(itrial));
                upKP = 0;
                downKP = 0;
                leftKP = 0;
                rightKP = 0;
     

                if keyCode(Key.left)
                    dot.Xpos = dot.Xpos - pixelsPerPressDot;
                    dot.Ypos = dot.Ypos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 0;
                    downKP = downKP + 0;
                    leftKP = leftKP + 1;
                    rightKP = rightKP + 0;
                end
                if keyCode(Key.right)
                    dot.Xpos = dot.Xpos + pixelsPerPressDot;
                    dot.Ypos = dot.Ypos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 0;
                    downKP = downKP + 0;
                    leftKP = leftKP + 0;
                    rightKP = rightKP + 1;
                end
                if keyCode(Key.up)
                    dot.Ypos = dot.Ypos - pixelsPerPressDot;
                    dot.Xpos = dot.Xpos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 1;
                    downKP = downKP + 0;
                    leftKP = leftKP + 0;
                    rightKP = rightKP + 0;
                end
                if keyCode(Key.down)
                    dot.Ypos = dot.Ypos + pixelsPerPressDot;
                    dot.Xpos = dot.Xpos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 0;
                    downKP = downKP + 1;
                    leftKP = leftKP + 0;
                    rightKP = rightKP + 0;
                end

                data(itrial).Xaxe = [data(itrial).Xaxe dot.Xpos];
                data(itrial).Yaxe = [data(itrial).Yaxe dot.Ypos];
                data(itrial).Fluent = [data(itrial).Fluent actualNoise];
                data(itrial).Up = [data(itrial).Up upKP];
                data(itrial).Down = [data(itrial).Down downKP];
                data(itrial).Left = [data(itrial).Left leftKP];
                data(itrial).Right = [data(itrial).Right rightKP];

                % AVOIDING THE DOT TO GET OFF THE WINDOW
                if dot.Xpos < 10
                    dot.Xpos = 10;
                elseif dot.Xpos > Info.screenXpixels - 10
                    dot.Xpos = Info.screenXpixels - 10;
                end

                if dot.Ypos < 10
                    dot.Ypos = 10;
                elseif dot.Ypos > Info.screenYpixels - 10
                    dot.Ypos = Info.screenYpixels - 10;
                end

                % End of the trial when the dot reaches a square (dot reaches
                % one square limits)
                if allRects(1,1) < dot.Xpos && dot.Xpos < allRects(3,1) && allRects(2,1) < dot.Ypos && dot.Ypos < allRects(4,1)
                    TaskIsDown = true;
                    whichIsReached = Square1;
                    results.Reach(itrial) = true;
                    HiLeSquare = HiLeSquare + 1;                   
                elseif allRects(1,2) < dot.Xpos && dot.Xpos < allRects(3,2) && allRects(2,2) < dot.Ypos && dot.Ypos < allRects(4,2)
                    TaskIsDown = true;
                    whichIsReached = Square2;
                    results.Reach(itrial) = true;
                    LoLeSquare = LoLeSquare + 1;
                elseif allRects(1,3) < dot.Xpos && dot.Xpos < allRects(3,3) && allRects(2,3) < dot.Ypos && dot.Ypos < allRects(4,3)
                    TaskIsDown = true;
                    whichIsReached = Square3;
                    results.Reach(itrial) = true;
                    HiRiSquare = HiRiSquare + 1;
                elseif allRects(1,4) < dot.Xpos && dot.Xpos < allRects(3,4) && allRects(2,4) < dot.Ypos && dot.Ypos < allRects(4,4)
                    TaskIsDown = true;
                    whichIsReached = Square4;
                    results.Reach(itrial) = true;
                    LoRiSquare = LoRiSquare + 1
                end

                Screen('Flip', expWindow);

                % End of the trial when the dot does not reach a square 
                % Time to reach the square
                if GetSecs - tStartTask >= maxTime
                    TaskIsDown = true;
                    results.Reach(itrial) = false;
                    results.Success(itrial) = 0;
                    results.Gain(itrial) = 0; 
                    missTrials = missTrials + 1
                end

            end % end of the reaching task

            results.Time(itrial) = WhatIsTheTime;

            % Validation screen
            dot.Xpos = Info.xC; 
            dot.Ypos = Info.yC;

            Screen('FillRect', expWindow, grey, allRects);
            Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);

            for ga=1:length(actualGain)
            %DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15 , black);
            DrawFormattedText(expWindow, num2str(easyGain), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
            end

            if results.Reach(itrial) == true
                if whichIsReached == allRects(: ,actualGain~=1)
                    results.Success(itrial) = 1;
                    results.Gain(itrial) = 1;
                    frameColor = green;
                    succeedTrials = succeedTrials + 1;
                else
                    results.Success(itrial) = 1;
                    results.Gain(itrial) = 1; 
                    frameColor = green;
                    succeedTrials = succeedTrials + 1;
                end
                Screen('FrameRect', expWindow, frameColor, whichIsReached, penWidthPixels);
            end

            Screen('Flip', expWindow);
            WaitSecs(0.2);
            
        end
        
        Q_1 = 'A quel point pensez vous\n \ncontroler le mouvement du point';
            rep_min1 = 'Pas du tout';
            rep_max1 = 'Completement';
            Q_2 = 'Etait ce votre\n \ncible initiale?';
            rep_min2 = 'NON';
            rep_max2 = 'OUI';

            % Q1 is white, Q2 is grey i.e. Q1 is to be answered
            Screen('TextSize', expWindow, 25);     
            DrawFormattedText(expWindow, Q_1, 'center',Info.yC/3, white); 
            DrawFormattedText(expWindow, Q_2, 'center',4*Info.yC/3, grey); 

            DrawFormattedText(expWindow, rep_min1, Info.xC*0.4-55,2*Info.yC/3+100, white);
            DrawFormattedText(expWindow, rep_max1, Info.xC*1.6-55,2*Info.yC/3+100, white);

            DrawFormattedText(expWindow, rep_min2, Info.xC*0.4-80,5*Info.yC/3+100, grey);
            DrawFormattedText(expWindow, rep_max2, Info.xC*1.6-60,5*Info.yC/3+100, grey);

            Screen('TextSize', expWindow, 20);
            Screen('DrawLine', expWindow, white, Info.xC*0.4, 2*Info.yC/3, Info.xC*1.6, 2*Info.yC/3,4);
            for scale1=1:9
                DrawFormattedText(expWindow, num2str(scaleNumber(scale1)), Info.xC*scaleSpace(scale1),2*Info.yC/3+2*space, white);
                Screen('DrawLine', expWindow, white, Info.xC*scaleSpace(scale1), 2*Info.yC/3-size_line, Info.xC*scaleSpace(scale1), 2*Info.yC/3+size_line,4);
            end

            Screen('TextSize', expWindow, 20);    
            %Screen('DrawLine', expWindow, grey, Info.xC*0.4, 5*Info.yC/3, Info.xC*1.6, 5*Info.yC/3,4); 
            %for scale2=1:9
                %DrawFormattedText(expWindow, num2str(scaleNumber(scale2)), Info.xC*scaleSpace(scale2),5*Info.yC/3+2*space, grey);
                %Screen('DrawLine', expWindow, grey, Info.xC*scaleSpace(scale2), 5*Info.yC/3-size_line, Info.xC*scaleSpace(scale2), 5*Info.yC/3+size_line,4);
            %end

            Screen('Flip', expWindow);

            Q1answered = false;
            tStartQuestion1 = GetSecs;
            while Q1answered == false 
                [keyIsDown, secs, keyScale] = KbCheck;
                while keyScale == 0
                    [keyIsDown, secs, keyScale] = KbCheck;
                end

                if keyScale(Key.escape)
                    sca;
                    ShowCursor
                    clear sound
                end
                if keyScale(Key.one1)
                    results.Answer_Q1(itrial) = 1;
                    Q1answered = true;
                elseif keyScale(Key.two1)
                    results.Answer_Q1(itrial) = 2;
                    Q1answered = true;
                elseif keyScale(Key.three1)
                    results.Answer_Q1(itrial) = 3;
                    Q1answered = true;
                elseif keyScale(Key.four1)
                    results.Answer_Q1(itrial) = 4;
                    Q1answered = true;
                elseif keyScale(Key.five1)
                    results.Answer_Q1(itrial) = 5;
                    Q1answered = true;
                elseif keyScale(Key.six1)
                    results.Answer_Q1(itrial) = 6;
                    Q1answered = true;
                elseif keyScale(Key.seven1)
                    results.Answer_Q1(itrial) = 7;
                    Q1answered = true;
                elseif keyScale(Key.eight1)
                    results.Answer_Q1(itrial) = 8;
                    Q1answered = true;
                elseif keyScale(Key.nine1)
                    results.Answer_Q1(itrial) = 9;
                    Q1answered = true;
                else
                    [keyIsDown, secs, keyScale] = KbCheck;
                end

                while not(keyScale(Key.one1) == 0 && keyScale(Key.two1) == 0 && keyScale(Key.three1) == 0 && keyScale(Key.four1) == 0 && keyScale(Key.five1) == 0 && keyScale(Key.six1) == 0 && keyScale(Key.seven1) == 0 && keyScale(Key.eight1) == 0 && keyScale(Key.nine1) == 0)
                    [keyIsDown, secs, keyScale] = KbCheck;
                end
            end

            % Q1 is grey, Q2 is white i.e. Q2 is to be answered
            Screen('TextSize', expWindow, 25);
            DrawFormattedText(expWindow, Q_1, 'center',Info.yC/3, grey); 
            DrawFormattedText(expWindow, Q_2, 'center',4*Info.yC/3, white); 

            DrawFormattedText(expWindow, rep_min1, Info.xC*0.4-55,2*Info.yC/3+100, grey);
            DrawFormattedText(expWindow, rep_max1, Info.xC*1.6-55,2*Info.yC/3+100, grey);

            DrawFormattedText(expWindow, rep_min2, Info.xC*0.4-80,5*Info.yC/3+100, white);
            DrawFormattedText(expWindow, rep_max2, Info.xC*1.6-60,5*Info.yC/3+100, white);

            Screen('TextSize', expWindow, 20);
            Screen('DrawLine', expWindow, grey, Info.xC*0.4, 2*Info.yC/3, Info.xC*1.6, 2*Info.yC/3,4); %horizontal
            for scale1=1:9
                DrawFormattedText(expWindow, num2str(scaleNumber(scale1)), Info.xC*scaleSpace(scale1),2*Info.yC/3+2*space, grey);
                Screen('DrawLine', expWindow, grey, Info.xC*scaleSpace(scale1), 2*Info.yC/3-size_line, Info.xC*scaleSpace(scale1), 2*Info.yC/3+size_line,4); 
            end

            Screen('TextSize', expWindow, 20);    
            %Screen('DrawLine', expWindow, white, Info.xC*0.4, 5*Info.yC/3, Info.xC*1.6, 5*Info.yC/3,4); %horizontal
            %for scale2=1:9
                %DrawFormattedText(expWindow, num2str(scaleNumber(scale2)), Info.xC*scaleSpace(scale2),5*Info.yC/3+2*space, white);
                %Screen('DrawLine', expWindow, white, Info.xC*scaleSpace(scale2), 5*Info.yC/3-size_line, Info.xC*scaleSpace(scale2), 5*Info.yC/3+size_line,4);
            %end

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
                    ShowCursor;
                    clear sound
                end
                if keyScale(Key.one2)
                    results.Answer_Q2(itrial) = 1;
                    Q2answered = true;
                %elseif keyScale(Key.two2)
                    %results.Answer_Q2(itrial) = 2;
                    %Q2answered = true;
                %elseif keyScale(Key.three2)
                    %results.Answer_Q2(itrial) = 3;
                    %Q2answered = true;
                %elseif keyScale(Key.four2)
                    %results.Answer_Q2(itrial) = 4;
                    %Q2answered = true;
                %elseif keyScale(Key.five2)
                    %results.Answer_Q2(itrial) = 5;
                    %Q2answered = true;
                %elseif keyScale(Key.six2)
                    %results.Answer_Q2(itrial) = 6;
                    %Q2answered = true;
                %elseif keyScale(Key.seven2)
                    %results.Answer_Q2(itrial) = 7;
                    %Q2answered = true;
                %elseif keyScale(Key.eight2)
                    %results.Answer_Q2(itrial) = 8;
                    %Q2answered = true;
                elseif keyScale(Key.nine2)
                    results.Answer_Q2(itrial) = 9;
                    Q2answered = true;
                else
                    [keyIsDown, secs, keyScale] = KbCheck;
                end

                %while not(keyScale(Key.one2) == 0 && keyScale(Key.two2) == 0 && keyScale(Key.three2) == 0 && keyScale(Key.four2) == 0 && keyScale(Key.five2) == 0 && keyScale(Key.six2) == 0 && keyScale(Key.seven2) == 0 && keyScale(Key.eight2) == 0 && keyScale(Key.nine2) == 0)
                    %[keyIsDown, secs, keyScale] = KbCheck;
                %end
                while not(keyScale(Key.one2) == 0 && keyScale(Key.nine2) == 0)
                    [keyIsDown, secs, keyScale] = KbCheck;
                end

            end 
            
       % Show the gains
            Screen('TextSize', expWindow, 30);   
            %DrawFormattedText(expWindow, ['Vous avez gagne :' '\n \n' num2str(results.Gain(itrial)) ' points'], 'center', 'center', white);
            Screen('Flip', expWindow);
            WaitSecs(1.5); % ITI
            
        %if itrial ~= 1 && isfinite(trials.axisControl(itrial))
            %DrawFormattedText(expWindow, 'Vous  avez le droit a une pause\n \nAppuyer sur espace pour reprendre', 'center', 'center', white);            
            %Screen('Flip', expWindow);
            %passKey(Key.space);
        %end
        
        % breaks and feedback
        
        if itrial == 32 | itrial == 64 | itrial == 96 | itrial == 128 
            
            % sum of bloc variables
            results.blocGain = sum(results.Gain);
            
            
            DrawFormattedText(expWindow, 'Vous  avez le droit a une pause\n \nAppuyer sur espace pour vos stats', 'center', 'center', white);            
            Screen('Flip', expWindow);
            passKey(Key.space);
            DrawFormattedText(expWindow, ['Vous gagnez ' num2str(succeedTrials) '/32 points pour ce block\n \nLors des choix libres vous avez atteint\n \ncibles haut gauche: ' num2str((HiLeSquare/16)*100) '% \n \ncibles bas gauche: ' num2str((LoLeSquare/16)*100) '% \n \ncibles haut droit: ' num2str((HiRiSquare/16)*100) '% \n \ncibles bas droit: ' num2str((LoRiSquare/16)*100) '% \n \nAppuyer sur espace pour reprendre'], 'center', 'center');            
            Screen('Flip', expWindow);
            passKey(Key.space);
            
            % reset to 0 block variables after feedback
            HiLeSquare = 0;
            HiRiSquare = 0;
            LoLeSquare = 0;
            LoRiSquare = 0;
            missTrials = 0;
            succeedTrials = 0;
            errTrials = 0;
        
        end
        
    end
    
    results.TotalGain = sum(results.Gain);
    cagnotte = cagnotte + (results.TotalGain * 0.01953125)
    DrawFormattedText(expWindow, ['Merci de votre participation\n \nVous avez gagne ' num2str(cagnotte) ' euros'], 'center', 'center')
    Screen('Flip', expWindow);
    passKey(Key.space);
    
    save(OutputFileMainSelf, 'condition', 'which', 'sub', 'gender', 'date', 'trials', 'results', 'data');
    
    Screen('Close', expWindow); 
    ShowCursor;
    clear sound

catch WhatsTheError
      Screen('CloseAll')
      clear sound
      rethrow(WhatsTheError)
    
end

    

     