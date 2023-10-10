clear all;
clearvars;

addpath('/Users/agencyteam/Desktop/SLB IJN/WP2a followup/JOINT/Function');
PsychDefaultSetup(2);
KbName('UnifyKeyNames'); 

% NOT WRITTING IN THE SCRIPT DURING THE EXPERIMENT
%% 

input('Appuyez sur ENTREE')
KbWait; 

% -------------------------------------------------------------------------
% VARIABLES
% -------------------------------------------------------------------------
 
% Key

[keyboardIndices, productNames, allInfos] = GetKeyboardIndices; 
Key.escape = KbName('ESCAPE'); Key.space = KbName('SPACE');
Key.up = KbName('A'); Key.down = KbName('Z');
Key.left = KbName('K'); Key.right = KbName('L');

Key.one1 = KbName('1!'); Key.two1 = KbName('2@'); Key.three1 = KbName('3#');
Key.four1 = KbName('4$'); Key.five1 = KbName('5%'); Key.six1 = KbName('6^');
Key.seven1 = KbName('7&');Key.eight1 = KbName('8*');Key.nine1 = KbName('9(');

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

maxTime = 7;

numberOfTrials = 192  ; % 9 suconditions : 3 levels of motor noise * 3 levels of decision noise  --> 9 * 24 trials

% Visual white noise
sd_noise = 1;  

% Fluency  
lowNoise = 0;
highNoise = 4; 

% Audio white noise
sr = 44100;
d = 1000;  
noise = (rand(1, round(sr*d))*2)-1;

% Scales 
space = 25;
size_line=5;
scaleNumber = 1:9;
scaleSpace=0.1:0.1:0.9;

keyIsDownSujet1 = []; 
keyIsDownSujet2 = [];

% Psychtoolbox preferences
Screen('Preference', 'SkipSyncTests', 2);
%Screen('Preference', 'DefaultFontName', 'helvetica');
Screen('Preference', 'DefaultFontSize', 30);
Screen('Preference', 'DefaultFontStyle', 0); 
Screen('Preference', 'DefaultTextYPositionIsBaseline', 1);

% Data storage
[condition,which,sub,gender,date] = subjectVariables;
ResultFolder = '/Users/agencyteam/Desktop/SLB IJN/WP2a followup/JOINT/';
OutputFileMainWe = [ResultFolder 'WP2pilote' sub '.mat'];
OutputFileTrial = [ResultFolder 'WP2piloteTrial' sub '.mat'];

% -------------------------------------------------------------------------
% TRAINING SESSION DONE
%--------------------------------------------------------------------------

 % The training session is individual and without motor noise

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
    PressSpace = 0;
    PressSpaceS1 = 0;
    PressSpaceS2 = 0;
    
    % Ecran d'accueil et attendre que les deux le fassent
    sound(noise,sr);
    
    while PressSpace == 0
            
            [keyIsDown1Sujet1,secs1Sujet1, keyCode1Sujet1] = PsychHID('KbCheck', keyboardIndices(1,1));
            [keyIsDown1Sujet2,secs1Sujet2, keyCode1Sujet2] = PsychHID('KbCheck', keyboardIndices(1,2));

            if keyCode1Sujet1(Key.escape) || keyCode1Sujet2(Key.escape)
                sca;
                ShowCursor;
                clear sound
            end
            
            DrawFormattedText(expWindow, 'Appuyer tou(te)s les deux sur espace pour commencer', 'center','center', white);
            Screen('Flip', expWindow);  
            %passKey(Key.space);

                        
            if keyCode1Sujet1(Key.space) 
                PressSpaceS1 = 1;
            elseif keyCode1Sujet2(Key.space)
                PressSpaceS2 = 1;
            end
            
            if PressSpaceS1 == 1 & PressSpaceS1 == 1
                PressSpace = 1;
            end 
                
      end
    
    trials  = WP2a_trials ; % function that conterbalances all the experimental conditions
    
    % Set variables 
    
    Cagnotte1 = 0;
    Cagnotte2 = 0;
    
    Reward1block =  0;
    Reward2block = 0;

    blocknumb = 1;

    succeedTrials = 0;
    
    
    % trial loop 
    
    for itrial=1:numberOfTrials
        
        
        if itrial ~= 1 && isfinite(trials.axisControl(itrial))
            DrawFormattedText(expWindow, 'Vous avez le droit a une pause\n \nAppuyer sur espace pour reprendre', 'center', 'center', white);            
            Screen('Flip', expWindow);
            passKey(Key.space);
        end
        
        if trials.axisControl(itrial) == 0            
            DrawFormattedText(expWindow, 'PLAYER 1 : Placez votre main droite sur\n \nles touches GAUCHE et DROITE', 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);            
            DrawFormattedText(expWindow, 'PLAYER 2 : Placez votre main droite sur\n \nles touches HAUT et BAS', 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]); 
            Screen('Flip', expWindow);
            WaitSecs(5) %5
        elseif trials.axisControl(itrial) == 1
            DrawFormattedText(expWindow, 'PLAYER 1 : Placez votre main droite sur\n \nles touches HAUT et BAS', 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);            
            DrawFormattedText(expWindow, 'PLAYER 2 : Placez votre main droite sur\n \nles touches GAUCHE et DROITE', 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]); 
            Screen('Flip', expWindow);
            WaitSecs(5) %5
            
        end
        
        if trials.effectiveControl(itrial) == 1
            Sujet1 = 1;
        elseif trials.effectiveControl(itrial) == 0
            Sujet1 = 0;
        end
        
%         if trials.fluency(itrial) == 1 % regular trials
%             lowNoise = 0;
%             highNoise = 0;
%         elseif trials.fluency(itrial) == 2 % training trials
%             lowNoise = 1.5;
%             highNoise = 1.5;
%         elseif trials.fluency(itrial) == 3 % catch trials
%             lowNoise = 4;
%             highNoise = 4;
%         end
        
        data(itrial).Xaxe = [];
        data(itrial).Yaxe = [];
        data(itrial).Fluent = [];
        data(itrial).Up = [];
        data(itrial).Down = [];
        data(itrial).Left = [];
        data(itrial).Right = [];
        Contrib(itrial).Xaxe = [];
        Contrib(itrial).Yaxe = [];
        
        
        % sprintf allows to keep a chosen number of digits as decimal.
        % we want to keep 1 decimal digit to display the gains like '2.2'
        % or '0.0'        
        
        target1 = trials.values1(itrial); % one of the specific value to reach in order to succeed and win something
        target2 = trials.values2(itrial); % one of the specific value to reach in order to succeed and win something
        targetPosition1 = trials.position1(itrial);
        targetPosition2 = trials.position2(itrial);
        actualGain = [0 0 0 0]; % distractors
        actualGain(targetPosition1) = target1; % replace the 0 gain in the matrix
        actualGain(targetPosition2) = target2; % replace the 0 gain in the matrix
        %easyGain = randi([2,5],1); % value of the gain in the matrix
         
        [allRects, square] = DrawTheSquares(baseRect, Info, nXi);
        
        Screen('FillRect', expWindow, grey, allRects);
        centeredRect = CenterRectOnPointd(baseRect, Info.xC, Info.yC);

        Screen('FillRect', expWindow, grey, centeredRect);
        tex = Screen('MakeTexture', expWindow, RectNoise);
        Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);
        
        for ga=1:length(actualGain) % positon of the gain in the squares
        DrawFormattedText(expWindow, num2str(sprintf('%0.1f', actualGain(ga))), allRects(1,ga)+baseRect(3)/2-18, allRects(4,ga)-baseRect(3)/2+10, black);
        %allRects(1, :) --> X position of the gain in the squares
        %allRects(4, :) --> Y position of the gain in the squares
        %DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
        end 
 
         
        % first decision noise => 2 similar targets
        
%         % big decision noise => 4 identical targets
%         for ga=1:length(actualGain)
%         DrawFormattedText(expWindow, num2str(easyGain), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
%         end
        
         
        Square1 = allRects(:,1);
        Square2 = allRects(:,2);
        Square3 = allRects(:,3);
        Square4 = allRects(:,4);
        
        DrawFormattedText(expWindow, 'Choix ?', 'center', Info.yC/5, white);
        
        Screen('TextSize', expWindow, 20);
        DrawFormattedText(expWindow, num2str(1), Info.xC/2-85, Info.yC/5-65, white);
        DrawFormattedText(expWindow, num2str(2), Info.xC+395, Info.yC/5-65, white);
        DrawFormattedText(expWindow, num2str(3), Info.xC+395, Info.yC+350, white);
        DrawFormattedText(expWindow, num2str(4), Info.xC/2-85, Info.yC+350, white);
%         DrawFormattedText(expWindow, num2str(1), Info.xC/2, Info.yC/5+30, white);
%         DrawFormattedText(expWindow, num2str(2), Info.xC+320, Info.yC/5+30, white);
%         DrawFormattedText(expWindow, num2str(3), Info.xC+320, Info.yC+240, white);
%         DrawFormattedText(expWindow, num2str(4), Info.xC/2, Info.yC+240, white);
            
        Screen('Flip', expWindow); %% INSERT DECISION SCREEN HERE
        
        tStartChoice = GetSecs;
        Choiceanswered = 0;
        ChoiceS1answered = 0;
        ChoiceS2answered = 0;
         
        
        while Choiceanswered == 0
        
        Screen('TextSize', expWindow, 30);
            
            [keyIsDown1Sujet1,secs1Sujet1, keyCode1Sujet1] = PsychHID('KbCheck', keyboardIndices(1,1));
            [keyIsDown1Sujet2,secs1Sujet2, keyCode1Sujet2] = PsychHID('KbCheck', keyboardIndices(1,2));

            if keyCode1Sujet1(Key.escape) || keyCode1Sujet2(Key.escape)
                sca;
                ShowCursor;
                clear sound
            end
            
% Go back to it with the update of the first question

            if keyIsDown1Sujet1 == 1
                if keyCode1Sujet1(Key.one1)
                    results.Answer_ChoiceS1(itrial) = 1;
                    ChoiceS1answered = 1;  
                elseif keyCode1Sujet1(Key.two1)
                    results.Answer_ChoiceS1(itrial) = 2;
                    ChoiceS1answered = 1;
                elseif keyCode1Sujet1(Key.three1)
                    results.Answer_ChoiceS1(itrial) = 3;
                    ChoiceS1answered = 1;
                elseif keyCode1Sujet1(Key.four1)
                    results.Answer_ChoiceS1(itrial) = 4;
                    ChoiceS1answered = 1;
               
                else
                   [keyIsDown1Sujet1,secs1Sujet1, keyCode1Sujet1] = PsychHID('KbCheck', keyboardIndices(1,1));
                end
            end 
            
            if keyIsDown1Sujet2 == 1
                if keyCode1Sujet2(Key.one1)
                    results.Answer_ChoiceS2(itrial) = 1;
                    ChoiceS2answered = 1;  
                elseif keyCode1Sujet2(Key.two1)
                    results.Answer_ChoiceS2(itrial) = 2;
                    ChoiceS2answered = 1;
                elseif keyCode1Sujet2(Key.three1)
                    results.Answer_ChoiceS2(itrial) = 3;
                    ChoiceS2answered = 1;
                elseif keyCode1Sujet2(Key.four1)
                    results.Answer_ChoiceS2(itrial) = 4;
                    ChoiceS2answered = 1; 
                else
                   [keyIsDown1Sujet2,secs1Sujet2, keyCode1Sujet2] = PsychHID('KbCheck', keyboardIndices(1,2));
                end
            end
            
            if ChoiceS1answered == 1 && ChoiceS2answered == 1
                Choiceanswered = 1;
            end
        end
        
        results.choiceT(itrial) = GetSecs - tStartChoice;
        
        WaitSecs(0.2); % 1 sec delay before onset of the ball
        
        TaskIsDown = false; 
        tStartTask = GetSecs;
        
        while TaskIsDown == false 

            [allRects, square] = DrawTheSquares(baseRect, Info, nXi);

            Screen('FillRect', expWindow, grey, allRects);
            centeredRect = CenterRectOnPointd(baseRect, Info.xC, Info.yC);

            Screen('FillRect', expWindow, grey, centeredRect);
            tex = Screen('MakeTexture', expWindow, RectNoise);
            Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);
            
            for ga=1:length(actualGain) % positon of the gain in the squares
            DrawFormattedText(expWindow, num2str(sprintf('%0.1f', actualGain(ga))), allRects(1,ga)+baseRect(3)/2-18, allRects(4,ga)-baseRect(3)/2+10, black);
            %DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
            end 
            centeredBall = CenterRectOnPointd(dot.SizePix, dot.Xpos, dot.Ypos);
            Screen('FillOval', expWindow, dot.Color, centeredBall, max(dot.SizePix));
             
            % CountDown
            WhatIsTheTime = tStartTask - GetSecs + maxTime;
            DrawFormattedText(expWindow, num2str(roundn(WhatIsTheTime, -2)), 'center', Info.yC/5, white);
            
            HowFluent = MakeTheNoise(lowNoise, highNoise);
            actualNoise = HowFluent(trials.fluency(itrial));
            upKP = 0;
            downKP = 0;
            leftKP = 0;
            rightKP = 0;
            
            [keyIsDownSujet1,secsSujet1, keyCodeSujet1] = PsychHID('KbCheck', keyboardIndices(1,1));                      
            [keyIsDownSujet2,secsSujet2, keyCodeSujet2] = PsychHID('KbCheck', keyboardIndices(1,2));
            
            if keyCodeSujet1(Key.escape) || keyCodeSujet2(Key.escape)
                sca;
                ShowCursor;
                clear sound
            end
            
            if Sujet1 == 0 % sujet1 controls Xaxis and sujet2 controls Yaxis & noise on the non-controlled axis
                                
                if keyCodeSujet1(Key.left)
                    dot.Xpos = dot.Xpos - pixelsPerPressDot;
                    dot.Ypos = dot.Ypos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 0;
                    downKP = downKP + 0;
                    leftKP = leftKP + 1;
                    rightKP = rightKP + 0
                end
                if keyCodeSujet1(Key.right)
                    dot.Xpos = dot.Xpos + pixelsPerPressDot;
                    dot.Ypos = dot.Ypos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 0;
                    downKP = downKP + 0;
                    leftKP = leftKP + 0;
                    rightKP = rightKP + 1;
                end
                if keyCodeSujet1(Key.up)
                    dot.Ypos = dot.Ypos;
                end
                if keyCodeSujet1(Key.down)
                    dot.Ypos = dot.Ypos;
                end
            
            
                if keyCodeSujet2(Key.up)
                    dot.Ypos = dot.Ypos - pixelsPerPressDot;
                    dot.Xpos = dot.Xpos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 1;
                    downKP = downKP + 0;
                    leftKP = leftKP + 0;
                    rightKP = rightKP + 0;
                end
                if keyCodeSujet2(Key.down)
                    dot.Ypos = dot.Ypos + pixelsPerPressDot;
                    dot.Xpos = dot.Xpos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 0;
                    downKP = downKP + 1;
                    leftKP = leftKP + 0;
                    rightKP = rightKP + 0; 
                end
                if keyCodeSujet2(Key.left)
                    dot.Xpos = dot.Xpos;
                end
                if keyCodeSujet2(Key.right)
                    dot.Xpos = dot.Xpos;
                end
                
               
            elseif Sujet1 == 1 
                
                if keyCodeSujet2(Key.left)
                    dot.Xpos = dot.Xpos - pixelsPerPressDot ;
                    dot.Ypos = dot.Ypos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 0;
                    downKP = downKP + 0;
                    leftKP = leftKP + 1;
                    rightKP = rightKP + 0;
                end
                if keyCodeSujet2(Key.right)
                    dot.Xpos = dot.Xpos + pixelsPerPressDot ;
                    dot.Ypos = dot.Ypos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 0;
                    downKP = downKP + 0;
                    leftKP = leftKP + 0;
                    rightKP = rightKP + 1;
                end
                if keyCodeSujet2(Key.up)
                    dot.Ypos = dot.Ypos;
                end
                if keyCodeSujet2(Key.down)
                    dot.Ypos = dot.Ypos;
                end
            
                if keyCodeSujet1(Key.up)
                    dot.Ypos = dot.Ypos - pixelsPerPressDot ;
                    dot.Xpos = dot.Xpos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 1;
                    downKP = downKP + 0;
                    leftKP = leftKP + 0;
                    rightKP = rightKP + 0;
                end
                if keyCodeSujet1(Key.down)
                    dot.Ypos = dot.Ypos + pixelsPerPressDot ;
                    dot.Xpos = dot.Xpos + (actualNoise * trials.signe(itrial));
                    upKP = upKP + 0;
                    downKP = downKP + 1;
                    leftKP = leftKP + 0;
                    rightKP = rightKP + 0;
                end
                if keyCodeSujet1(Key.left)
                    dot.Xpos = dot.Xpos;
                end
                if keyCodeSujet1(Key.right)
                    dot.Xpos = dot.Xpos;
                end
            end
%            
            data(itrial).Xaxe = [data(itrial).Xaxe dot.Xpos];
            data(itrial).Yaxe = [data(itrial).Yaxe dot.Ypos];
            data(itrial).Fluent = [data(itrial).Fluent actualNoise];
            data(itrial).Up = [data(itrial).Up upKP];
            data(itrial).Down = [data(itrial).Down downKP];
            data(itrial).Left = [data(itrial).Left leftKP];
            data(itrial).Right = [data(itrial).Right rightKP];
            
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
            
            % End of the trial when the dot reach a square
            if allRects(1,1) < dot.Xpos && dot.Xpos < allRects(3,1) && allRects(2,1) < dot.Ypos && dot.Ypos < allRects(4,1)
                TaskIsDown = true;
                whichIsReached = Square1;
                results.Reach(itrial) = true;
                results.Win(itrial) = actualGain(1);
            elseif allRects(1,2) < dot.Xpos && dot.Xpos < allRects(3,2) && allRects(2,2) < dot.Ypos && dot.Ypos < allRects(4,2)
                TaskIsDown = true;
                whichIsReached = Square2;
                results.Reach(itrial) = true;
                results.Win(itrial) = actualGain(2);
            elseif allRects(1,3) < dot.Xpos && dot.Xpos < allRects(3,3) && allRects(2,3) < dot.Ypos && dot.Ypos < allRects(4,3)
                TaskIsDown = true;
                whichIsReached = Square3;
                results.Reach(itrial) = true;
                results.Win(itrial) = actualGain(3)
            elseif allRects(1,4) < dot.Xpos && dot.Xpos < allRects(3,4) && allRects(2,4) < dot.Ypos && dot.Ypos < allRects(4,4)
                TaskIsDown = true;
                whichIsReached = Square4;
                results.Reach(itrial) = true;
                results.Win(itrial) = actualGain(4)
            end
            
            Screen('Flip', expWindow);
            
            % Time to reach the square
            if GetSecs - tStartTask >= maxTime
                TaskIsDown = true;
                results.Reach(itrial) = false;
                results.Success(itrial) = 0;
                results.Gain(itrial) = 0; 
                results.Win(itrial) = 0;
            end
              
        end % end of the reaching task
        
        results.Time(itrial) = WhatIsTheTime;
        
        % Validation screen
        dot.Xpos = Info.xC; 
        dot.Ypos = Info.yC;

        Screen('FillRect', expWindow, grey, allRects);
        Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);

        for ga=1:length(actualGain) % positon of the gain in the squares
        DrawFormattedText(expWindow, num2str(sprintf('%0.1f', actualGain(ga))), allRects(1,ga)+baseRect(3)/2-18, allRects(4,ga)-baseRect(3)/2+10, black);
        %DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
        end
        
%         if results.Reach(itrial) == true
%             if whichIsReached == allRects(: ,actualGain > 0)
%                 results.Success(itrial) = 1;
%                 results.Gain(itrial) = 1;
%                 frameColor = green;
%             elseif whichIsReached == allRects(: ,actualGain == 0)
%                 results.Success(itrial) = 0;
%                 results.Gain(itrial) = 0; 
%                 frameColor = red;
%             else 
%                 results.Success(itrial) = 0;
%                 results.Gain(itrial) = 0; 
%                 frameColor = red;
%             end
%             Screen('FrameRect', expWindow, frameColor, whichIsReached, penWidthPixels);
%         end
        
        if results.Reach(itrial) == true
            if results.Win(itrial) > 0
                results.Success(itrial) = 1;
                results.Gain(itrial) = 1;
                frameColor = green;
            elseif results.Win(itrial) == 0
                results.Success(itrial) = 0;
                results.Gain(itrial) = 0; 
                frameColor = red;
            else 
                results.Win(itrial) = 0;
                results.Success(itrial) = 0;
                results.Gain(itrial) = 0; 
                frameColor = red;
            end
            Screen('FrameRect', expWindow, frameColor, whichIsReached, penWidthPixels);
        end
          
        
        Screen('Flip', expWindow);
        WaitSecs(0.2);
        
        ContribX = (mean(data(itrial).Right) + mean(data(itrial).Left)) / (mean(data(itrial).Right) + mean(data(itrial).Left) + mean(data(itrial).Up) + mean(data(itrial).Down));
        ContribY = (mean(data(itrial).Up) + mean(data(itrial).Down)) / (mean(data(itrial).Right) + mean(data(itrial).Left) + mean(data(itrial).Up) + mean(data(itrial).Down));
        
        Contrib(itrial).Xaxe = [Contrib(itrial).Xaxe ContribX];
        Contrib(itrial).Yaxe = [Contrib(itrial).Yaxe ContribY]; 
        
        if results.Win(itrial) == 0
            results.CagnotteP1(itrial) = 0;
            results.CagnotteP2(itrial) = 0;
        elseif results.Win(itrial) > 0
            results.CagnotteP1(itrial) = round(results.Win(itrial)); % rounding to suppress the decimal digit corresponding to player2' cagnotte
            results.CagnotteP2(itrial) = (results.Win(itrial) - results.CagnotteP1(itrial))*10;
        end 
             
       % Evaluation of feeling of control       
        
        Q_1 = 'A quel point penses tu\n \ncontroler le mouvement du point';
        rep_min1 = 'Pas du tout';
        rep_max1 = 'Completement';
        place = 40;
        %if trials.question2(itrial) == 1
%             Q_2 = 'Evaluer votre sentiment de\n \ncontrole sur l''essai';
%             rep_min2 = 'Controle\n \nindependant';
%             rep_max2 = 'Controle\n \npartage';
%             place = 60;
        %elseif trials.question2(itrial) == 2
        Q_2 = 'A quel point \n \ncontroliez-vous le mouvement du point ensemble';
        rep_min2 = 'Pas du tout';
        rep_max2 = 'Completement';
        place = 40;
        %end
        
        Screen('DrawLine', expWindow, white, Info.xC, 0, Info.xC, Info.rect(4),2);
        
        % Q1 is white, Q2 is grey i.e. Q1 is to be answered
        Screen('TextSize', expWindow, 25);
        DrawFormattedText(expWindow, Q_1, 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.yC*0.75]);
        DrawFormattedText(expWindow, Q_1, 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.yC*0.75]);
        DrawFormattedText(expWindow, Q_2, 'center', 'center', grey, [], [], [], [], [], [Info.rect(1) Info.yC Info.xC, Info.rect(4)*0.875]);
        DrawFormattedText(expWindow, Q_2, 'center', 'center', grey, [], [], [], [], [], [Info.xC Info.yC Info.rect(3), Info.rect(4)*0.875]);

        Screen('TextSize', expWindow, 15); %20
        DrawFormattedText(expWindow, rep_min1, Info.xC*0.1-place,2*Info.yC/3+100, white);
        DrawFormattedText(expWindow, rep_max1, Info.xC*0.9-place-10,2*Info.yC/3+100, white);
        
        DrawFormattedText(expWindow, rep_min1, Info.xC*1.1-place,2*Info.yC/3+100, white);
        DrawFormattedText(expWindow, rep_max1, Info.xC*1.9-place-10,2*Info.yC/3+100, white);
        
        DrawFormattedText(expWindow, rep_min2, Info.xC*0.1-place,5*Info.yC/3+100, grey);
        DrawFormattedText(expWindow, rep_max2, Info.xC*0.9-place-10,5*Info.yC/3+100, grey);
        
        DrawFormattedText(expWindow, rep_min2, Info.xC*1.1-place,5*Info.yC/3+100, grey);
        DrawFormattedText(expWindow, rep_max2, Info.xC*1.9-place-10,5*Info.yC/3+100, grey);
        
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
        Q1answered = 0;
        Q1S1answered = 0;
        Q1S2answered = 0;
         
        
        while Q1answered == 0
            
            [keyIsDown1Sujet1,secs1Sujet1, keyCode1Sujet1] = PsychHID('KbCheck', keyboardIndices(1,1));
            [keyIsDown1Sujet2,secs1Sujet2, keyCode1Sujet2] = PsychHID('KbCheck', keyboardIndices(1,2));

            if keyCode1Sujet1(Key.escape) || keyCode1Sujet2(Key.escape)
                sca;
                ShowCursor;
                clear sound
            end
            
% Go back to it with the update of the first question

            if keyIsDown1Sujet1 == 1
                if keyCode1Sujet1(Key.one1)
                    results.Answer_Q1S1(itrial) = 1;
                    Q1S1answered = 1;  
                elseif keyCode1Sujet1(Key.two1)
                    results.Answer_Q1S1(itrial) = 2;
                    Q1S1answered = 1;
                elseif keyCode1Sujet1(Key.three1)
                    results.Answer_Q1S1(itrial) = 3;
                    Q1S1answered = 1;
                elseif keyCode1Sujet1(Key.four1)
                    results.Answer_Q1S1(itrial) = 4;
                    Q1S1answered = 1;
                elseif keyCode1Sujet1(Key.five1)
                    results.Answer_Q1S1(itrial) = 5;
                    Q1S1answered = 1;
                elseif keyCode1Sujet1(Key.six1)
                    results.Answer_Q1S1(itrial) = 6;
                    Q1S1answered = 1;
                elseif keyCode1Sujet1(Key.seven1)
                    results.Answer_Q1S1(itrial) = 7;
                    Q1S1answered = 1;
                elseif keyCode1Sujet1(Key.eight1)
                    results.Answer_Q1S1(itrial) = 8;
                    Q1S1answered = 1;
                elseif keyCode1Sujet1(Key.nine1)
                    results.Answer_Q1S1(itrial) = 9;
                    Q1S1answered = 1;
                else
                   [keyIsDown1Sujet1,secs1Sujet1, keyCode1Sujet1] = PsychHID('KbCheck', keyboardIndices(1,1));
                end
            end 
            
            if keyIsDown1Sujet2 == 1
                if keyCode1Sujet2(Key.one1)
                    results.Answer_Q1S2(itrial) = 1;
                    Q1S2answered = 1;
                elseif keyCode1Sujet2(Key.two1)
                    results.Answer_Q1S2(itrial) = 2;
                    Q1S2answered = 1;
                elseif keyCode1Sujet2(Key.three1)
                    results.Answer_Q1S2(itrial) = 3;
                    Q1S2answered = 1;
                elseif keyCode1Sujet2(Key.four1)
                    results.Answer_Q1S2(itrial) = 4;
                    Q1S2answered = 1;
                elseif keyCode1Sujet2(Key.five1)
                    results.Answer_Q1S2(itrial) = 5;
                    Q1S2answered = 1;
                elseif keyCode1Sujet2(Key.six1)
                    results.Answer_Q1S2(itrial) = 6;
                    Q1S2answered = 1;
                elseif keyCode1Sujet2(Key.seven1)
                    results.Answer_Q1S2(itrial) = 7;
                    Q1S2answered = 1;
                elseif keyCode1Sujet2(Key.eight1)
                    results.Answer_Q1S2(itrial) = 8;
                    Q1S2answered = 1;
                elseif keyCode1Sujet2(Key.nine1)
                    results.Answer_Q1S2(itrial) = 9;
                    Q1S2answered = 1; 
                else
                   [keyIsDown1Sujet2,secs1Sujet2, keyCode1Sujet2] = PsychHID('KbCheck', keyboardIndices(1,2));
                end
            end
            
            if Q1S1answered == 1 && Q1S2answered == 1
                Q1answered = 1;
            end
        end
      
       
        Screen('DrawLine', expWindow, white, Info.xC, 0, Info.xC, Info.rect(4),2);
        % Q1 is grey, Q2 is white i.e. Q2 is to be answered
        Screen('TextSize', expWindow, 25);
        DrawFormattedText(expWindow, Q_1, 'center', 'center', grey, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.yC*0.75]);
        DrawFormattedText(expWindow, Q_1, 'center', 'center', grey, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.yC*0.75]);
        DrawFormattedText(expWindow, Q_2, 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.yC Info.xC, Info.rect(4)*0.875]);
        DrawFormattedText(expWindow, Q_2, 'center', 'center', white, [], [], [], [], [], [Info.xC Info.yC Info.rect(3), Info.rect(4)*0.875]);

        Screen('TextSize', expWindow, 15)
%         DrawFormattedText(expWindow, rep_min1, Info.xC*0.1-55,2*Info.yC/3+100, grey);
%         DrawFormattedText(expWindow, rep_max1, Info.xC*0.9-55,2*Info.yC/3+100, grey);
%         
%         DrawFormattedText(expWindow, rep_min1, Info.xC*1.1-55,2*Info.yC/3+100, grey);
%         DrawFormattedText(expWindow, rep_max1, Info.xC*1.9-55,2*Info.yC/3+100, grey);
        
        DrawFormattedText(expWindow, rep_min1, Info.xC*0.1-place,2*Info.yC/3+100, grey);
        DrawFormattedText(expWindow, rep_max1, Info.xC*0.9-place-10,2*Info.yC/3+100, grey);
        
        DrawFormattedText(expWindow, rep_min1, Info.xC*1.1-place,2*Info.yC/3+100, grey);
        DrawFormattedText(expWindow, rep_max1, Info.xC*1.9-place-10,2*Info.yC/3+100, grey);
        
        DrawFormattedText(expWindow, rep_min2, Info.xC*0.1-place,5*Info.yC/3+100, white);
        DrawFormattedText(expWindow, rep_max2, Info.xC*0.9-place-10,5*Info.yC/3+100, white);
        
        DrawFormattedText(expWindow, rep_min2, Info.xC*1.1-place,5*Info.yC/3+100, white);
        DrawFormattedText(expWindow, rep_max2, Info.xC*1.9-place-10,5*Info.yC/3+100, white);
        
      
        
        Screen('TextSize', expWindow, 20);
        Screen('DrawLine', expWindow, grey, Info.xC*0.1, 2*Info.yC/3, Info.xC*0.9, 2*Info.yC/3,4);
        for scale1a=1:9
            DrawFormattedText(expWindow, num2str(scaleNumber(scale1a)), Info.xC*scaleSpace(scale1a)-10,2*Info.yC/3+2*space, grey);
            Screen('DrawLine', expWindow, grey, Info.xC*scaleSpace(scale1a), 2*Info.yC/3-size_line, Info.xC*scaleSpace(scale1a), 2*Info.yC/3+size_line,4);
        end

        Screen('DrawLine', expWindow, grey, Info.xC*1.1, 2*Info.yC/3, Info.xC*1.9, 2*Info.yC/3,4);
        for scale1b=1:9
            DrawFormattedText(expWindow, num2str(scaleNumber(scale1b)), Info.xC*(scaleSpace(scale1b)+1)-10,2*Info.yC/3+2*space, grey);
            Screen('DrawLine', expWindow, grey, Info.xC*(scaleSpace(scale1b)+1), 2*Info.yC/3-size_line, Info.xC*(scaleSpace(scale1b)+1), 2*Info.yC/3+size_line,4);
        end
           
        Screen('DrawLine', expWindow, white, Info.xC*0.1, 5*Info.yC/3, Info.xC*0.9, 5*Info.yC/3,4); 
        for scale2a=1:9
            DrawFormattedText(expWindow, num2str(scaleNumber(scale2a)), Info.xC*scaleSpace(scale2a),5*Info.yC/3+2*space, white);
            Screen('DrawLine', expWindow, white, Info.xC*scaleSpace(scale2a), 5*Info.yC/3-size_line, Info.xC*scaleSpace(scale2a), 5*Info.yC/3+size_line,4);
        end

        Screen('DrawLine', expWindow, white, Info.xC*1.1, 5*Info.yC/3, Info.xC*1.9, 5*Info.yC/3,4); 
        for scale2b=1:9
            DrawFormattedText(expWindow, num2str(scaleNumber(scale2b)), Info.xC*(scaleSpace(scale2b)+1),5*Info.yC/3+2*space, white);
            Screen('DrawLine', expWindow, white, Info.xC*(scaleSpace(scale2b)+1), 5*Info.yC/3-size_line, Info.xC*(scaleSpace(scale2b)+1), 5*Info.yC/3+size_line,4);
        end
        Screen('Flip', expWindow);
        
        
        tStartQuestion2 = GetSecs;
        Q2answered = 0;
        Q2S1answered = 0;
        Q2S2answered = 0;        
        
        while Q2answered == 0 
            
            [keyIsDown2Sujet1,secs2Sujet1, keyCode2Sujet1] = PsychHID('KbCheck', keyboardIndices(1,1));
            [keyIsDown2Sujet2,secs2Sujet2, keyCode2Sujet2] = PsychHID('KbCheck', keyboardIndices(1,2));

            if keyCode2Sujet1(Key.escape) || keyCode2Sujet2(Key.escape)
                sca;
                ShowCursor;
                clear sound 
            end
            
            
            if keyIsDown2Sujet1 == 1
                if keyCode2Sujet1(Key.one2)
                    results.Answer_Q2S1(itrial) = 1;
                    Q2S1answered = 1;  
                elseif keyCode2Sujet1(Key.two2)
                    results.Answer_Q2S1(itrial) = 2;
                    Q2S1answered = 1;
                elseif keyCode2Sujet1(Key.three2)
                    results.Answer_Q2S1(itrial) = 3;
                    Q2S1answered = 1;
                elseif keyCode2Sujet1(Key.four2)
                    results.Answer_Q2S1(itrial) = 4;
                    Q2S1answered = 1;
                elseif keyCode2Sujet1(Key.five2)
                    results.Answer_Q2S1(itrial) = 5;
                    Q2S1answered = 1;
                elseif keyCode2Sujet1(Key.six2)
                    results.Answer_Q2S1(itrial) = 6;
                    Q2S1answered = 1;
                elseif keyCode2Sujet1(Key.seven2)
                    results.Answer_Q2S1(itrial) = 7;
                    Q2S1answered = 1;
                elseif keyCode2Sujet1(Key.eight2)
                    results.Answer_Q2S1(itrial) = 8;
                    Q2S1answered = 1;
                elseif keyCode2Sujet1(Key.nine2)
                    results.Answer_Q2S1(itrial) = 9;
                    Q2S1answered = 1;
                else
                   [keyIsDown2Sujet1,secs2Sujet1, keyCode2Sujet1] = PsychHID('KbCheck', keyboardIndices(1,1));
                end
            end 
            
            if keyIsDown2Sujet2 == 1
                if keyCode2Sujet2(Key.one2)
                    results.Answer_Q2S2(itrial) = 1;
                    Q2S2answered = 1;
                elseif keyCode2Sujet2(Key.two2)
                    results.Answer_Q2S2(itrial) = 2;
                    Q2S2answered = 1;
                elseif keyCode2Sujet2(Key.three2)
                    results.Answer_Q2S2(itrial) = 3;
                    Q2S2answered = 1;
                elseif keyCode2Sujet2(Key.four2)
                    results.Answer_Q2S2(itrial) = 4;
                    Q2S2answered = 1;
                elseif keyCode2Sujet2(Key.five2)
                    results.Answer_Q2S2(itrial) = 5;
                    Q2S2answered = 1;
                elseif keyCode2Sujet2(Key.six2)
                    results.Answer_Q2S2(itrial) = 6;
                    Q2S2answered = 1;
                elseif keyCode2Sujet2(Key.seven2)
                    results.Answer_Q2S2(itrial) = 7;
                    Q2S2answered = 1;
                elseif keyCode2Sujet2(Key.eight2)
                    results.Answer_Q2S2(itrial) = 8;
                    Q2S2answered = 1;
                elseif keyCode2Sujet2(Key.nine2)
                    results.Answer_Q2S2(itrial) = 9;
                    Q2S2answered = 1; 
                else
                   [keyIsDown2Sujet2,secs2Sujet2, keyCode2Sujet2] = PsychHID('KbCheck', keyboardIndices(1,2));
                end

            end
            
            if Q2S1answered == 1 && Q2S2answered == 1
                Q2answered = 1;
            end
            

           
       end
        
        % Show the gains
        
%         Screen('TextSize', expWindow, 30);   
%         DrawFormattedText(expWindow, ['Vous avez gagne :' '\n \n' num2str(results.Gain(itrial)) ' points'], 'center', 'center', white);
%         Screen('Flip', expWindow);
%         WaitSecs(1.5);

        Screen('DrawLine', expWindow, white, Info.xC, 0, Info.xC, Info.rect(4),2);
        Screen('TextSize', expWindow, 30);   
        DrawFormattedText(expWindow, ['Player1 gagne :' '\n \n' num2str(results.CagnotteP1(itrial)) ' point(s)'], 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);
        DrawFormattedText(expWindow, ['Player2 gagne :' '\n \n' num2str(results.CagnotteP2(itrial)) ' point(s)'], 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]);
        Screen('Flip', expWindow);
        WaitSecs(1);
        
        save(OutputFileTrial, 'condition', 'which', 'sub', 'gender', 'date', 'trials', 'results', 'data', 'Contrib');
 
        
    end


% calculation of total gains per player :
% 1/2 of trials with mean points = 4 for both participants --> 2 identical squares
% last 1/2 of trials with mean points = 3 for both participants --> 2 conflictual squares
% Mean points for 1 succeed trial of this experiment = 3.5 for both players
% Maximal total number of points in the game = 192 (trials) * 3.5 = 672 points
% The total max cagnotte = 30 euros for both --> 15 euros for 1 player
% Conversion of points in euros = 30/672 = 0.0446 euros for 1 point

        CagnotteP1 = (sum(results.CagnotteP1)*0.0446)
        CagnotteP2 = (sum(results.CagnotteP2)*0.0446)

        DrawFormattedText(expWindow, ['Merci de votre participation !!'], 'center', 'center');
        Screen('Flip', expWindow);
        WaitSecs(2);

        Screen('DrawLine', expWindow, white, Info.xC, 0, Info.xC, Info.rect(4),2);
        Screen('TextSize', expWindow, 30);   
        DrawFormattedText(expWindow, ['Player1 gagne :' '\n \n' num2str(CagnotteP1) ' euro(s)'], 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);
        DrawFormattedText(expWindow, ['Player2 gagne :' '\n \n' num2str(CagnotteP2) ' euro(s)'], 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]);
        Screen('Flip', expWindow);
        passKey(Key.space)
     
    save(OutputFileMainWe, 'condition', 'which', 'sub', 'gender', 'date', 'trials', 'results', 'data', 'Contrib');
    
    Screen('Close', expWindow); 
    ShowCursor;
    clear sound
    
catch WhatsTheError
    Screen('CloseAll')
    rethrow(WhatsTheError)
end

    
    
     