clear all;
clearvars;
  
%addpath('C:\Users\DEVAUX Alexandre\Documents\COGMASTER\Master
%2\STAGE\Experience\Programme
%Experience\Function');

addpath('/Users/agencyteam/Documents/Alexandre/ExperienceFinal/Programme Experience/Function');
PsychDefaultSetup(2);
KbName('UnifyKeyNames');

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

maxTime = 5;

numberOfTrials = 128;

% Visual white noise
sd_noise = 1;  

% Fluency
lowNoise = 2.5;
highNoise = 5;

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
ResultFolderWe = '/Users/agencyteam/Documents/Alexandre/ExperienceFinal/Stockage Resultat';
OutputFileMainWe = [ResultFolderWe 'MainWe' sub '.mat'];

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
    nXi = Info.xC - Info.rect(4)/2;
    
    dot.Xpos = Info.xC; 
    dot.Ypos = Info.yC;
    RectNoise = (sd_noise*randn(baseRect(3),baseRect(4)));
    
    % Ecran d'accueil et attendre que les deux le fasse
    sound(noise,sr);
    DrawFormattedText(expWindow, 'Appuyer sur espace pour commencer', 'center','center', white);
    Screen('Flip', expWindow);  
    passKey(Key.space);
    
    trials  = WP1a_trials ; % function that conterbalance all the experimental conditions
    for itrial=1:numberOfTrials
        
        
        if itrial ~= 1 && isfinite(trials.axisControl(itrial))
            DrawFormattedText(expWindow, 'Vous avez le droit a une pause\n \nAppuyer sur espace pour reprendre', 'center', 'center', white);            
            Screen('Flip', expWindow);
            passKey(Key.space);
        end
        
        if trials.axisControl(itrial) == 0            
            DrawFormattedText(expWindow, 'Placez votre main droite sur\n \nles touches GAUCHE et DROITE', 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);            
            DrawFormattedText(expWindow, 'Placez votre main droite sur\n \nles touches HAUT et BAS', 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]); 
            Screen('Flip', expWindow);
            WaitSecs(5)
        elseif trials.axisControl(itrial) == 1
            DrawFormattedText(expWindow, 'Placez votre main droite sur\n \nles touches HAUT et BAS', 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);            
            DrawFormattedText(expWindow, 'Placez votre main droite sur\n \nles touches GAUCHE et DROITE', 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]); 
            Screen('Flip', expWindow);
            WaitSecs(5)
            
        end
        
        if trials.effectiveControl(itrial) == 1
            Sujet1 = 1;
        elseif trials.effectiveControl(itrial) == 0
            Sujet1 = 0;
        end
        
        data(itrial).Xaxe = [];
        data(itrial).Yaxe = [];
        data(itrial).Fluent = [];
        
        target = trials.gains(itrial); % specific value to reach in order to succed 
        targetPosition = trials.position(itrial);
        actualGain = [1 1 1 1];
        actualGain(targetPosition) = target;
        
        [allRects, square] = DrawTheSquares(baseRect, Info, nXi);
        
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

            [allRects, square] = DrawTheSquares(baseRect, Info, nXi);

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
            DrawFormattedText(expWindow, num2str(roundn(WhatIsTheTime, -2)), 'center', Info.yC/5, white);
            
            HowFluent = MakeTheNoise(lowNoise, highNoise);
            actualNoise = HowFluent(trials.fluency(itrial));
            
            [keyIsDownSujet1,secsSujet1, keyCodeSujet1] = PsychHID('KbCheck', keyboardIndices(1,1));                      
            [keyIsDownSujet2,secsSujet2, keyCodeSujet2] = PsychHID('KbCheck', keyboardIndices(1,2));
            
            if keyCodeSujet1(Key.escape) || keyCodeSujet2(Key.escape)
                sca;
                ShowCursor;
                clear sound
            end
            
            if Sujet1 == 0
                
                if keyCodeSujet1(Key.left)
                    dot.Xpos = dot.Xpos - pixelsPerPressDot;
                    dot.Ypos = dot.Ypos + (actualNoise * trials.signe(itrial));
                end
                if keyCodeSujet1(Key.right)
                    dot.Xpos = dot.Xpos + pixelsPerPressDot;
                    dot.Ypos = dot.Ypos + (actualNoise * trials.signe(itrial));
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
                end
                if keyCodeSujet2(Key.down)
                    dot.Ypos = dot.Ypos + pixelsPerPressDot;
                    dot.Xpos = dot.Xpos + (actualNoise * trials.signe(itrial));
                end
                if keyCodeSujet2(Key.left)
                    dot.Xpos = dot.Xpos;
                end
                if keyCodeSujet2(Key.right)
                    dot.Xpos = dot.Xpos;
                end
                
               
            elseif Sujet1 == 1 
                
                if keyCodeSujet2(Key.left)
                    dot.Xpos = dot.Xpos - pixelsPerPressDot + actualNoise;
                end
                if keyCodeSujet2(Key.right)
                    dot.Xpos = dot.Xpos + pixelsPerPressDot + actualNoise;
                end
                if keyCodeSujet2(Key.up)
                    dot.Ypos = dot.Ypos;
                end
                if keyCodeSujet2(Key.down)
                    dot.Ypos = dot.Ypos;
                end
            
                if keyCodeSujet1(Key.up)
                    dot.Ypos = dot.Ypos - pixelsPerPressDot + actualNoise;
                end
                if keyCodeSujet1(Key.down)
                    dot.Ypos = dot.Ypos + pixelsPerPressDot + actualNoise;
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

        for ga=1:length(actualGain)
        DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15 , black);
        end
        
        if results.Reach(itrial) == true
            if whichIsReached == allRects(: ,actualGain~=1)
                results.Success(itrial) = 1;
                results.Gain(itrial) = 1;
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
             
       % Evaluation of feeling of control       
        
        Q_1 = 'A quel point pensez vous\n \ncontroler le mouvement du point';
        rep_min1 = 'Pas du tout';
        rep_max1 = 'Completement';
        place = 40;
        if trials.question2(itrial) == 1
            Q_2 = 'Evaluer votre sentiment de\n \ncontrole sur l''essai';
            rep_min2 = 'Controle\n \nindependant';
            rep_max2 = 'Controle\n \npartage';
            place = 60;
        elseif trials.question2(itrial) == 2
            Q_2 = 'A quel point pensez vous\n \nque l''autre controle le mouvement du point ';
            rep_min2 = 'Pas du tout';
            rep_max2 = 'Completement';
            place = 40;
        end
        
        Screen('DrawLine', expWindow, white, Info.xC, 0, Info.xC, Info.rect(4),2);
        
        % Q1 is white, Q2 is grey i.e. Q1 is to be answered
        Screen('TextSize', expWindow, 25);
        DrawFormattedText(expWindow, Q_1, 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.yC*0.75]);
        DrawFormattedText(expWindow, Q_1, 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.yC*0.75]);
        DrawFormattedText(expWindow, Q_2, 'center', 'center', grey, [], [], [], [], [], [Info.rect(1) Info.yC Info.xC, Info.rect(4)*0.875]);
        DrawFormattedText(expWindow, Q_2, 'center', 'center', grey, [], [], [], [], [], [Info.xC Info.yC Info.rect(3), Info.rect(4)*0.875]);

        Screen('TextSize', expWindow, 20);
        DrawFormattedText(expWindow, rep_min1, Info.xC*0.1-place,2*Info.yC/3+100, white);
        DrawFormattedText(expWindow, rep_max1, Info.xC*0.9-place-10,2*Info.yC/3+100, white);
        
        DrawFormattedText(expWindow, rep_min1, Info.xC*1.1-place,2*Info.yC/3+100, white);
        DrawFormattedText(expWindow, rep_max1, Info.xC*1.9-place-10,2*Info.yC/3+100, white);
        
        DrawFormattedText(expWindow, rep_min2, Info.xC*0.1-place,5*Info.yC/3+100, grey);
        DrawFormattedText(expWindow, rep_max2, Info.xC*0.9-place-10,5*Info.yC/3+100, grey);
        
        DrawFormattedText(expWindow, rep_min2, Info.xC*1.1-place,5*Info.yC/3+100, grey);
        DrawFormattedText(expWindow, rep_max2, Info.xC*1.9-place-10,5*Info.yC/3+100, grey);
        
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
        Screen('TextSize', expWindow, 20);
        DrawFormattedText(expWindow, Q_1, 'center', 'center', grey, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.yC*0.75]);
        DrawFormattedText(expWindow, Q_1, 'center', 'center', grey, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.yC*0.75]);
        DrawFormattedText(expWindow, Q_2, 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.yC Info.xC, Info.rect(4)*0.875]);
        DrawFormattedText(expWindow, Q_2, 'center', 'center', white, [], [], [], [], [], [Info.xC Info.yC Info.rect(3), Info.rect(4)*0.875]);

        DrawFormattedText(expWindow, rep_min1, Info.xC*0.1-55,2*Info.yC/3+100, grey);
        DrawFormattedText(expWindow, rep_max1, Info.xC*0.9-55,2*Info.yC/3+100, grey);
        
        DrawFormattedText(expWindow, rep_min1, Info.xC*1.1-55,2*Info.yC/3+100, grey);
        DrawFormattedText(expWindow, rep_max1, Info.xC*1.9-55,2*Info.yC/3+100, grey);
        
        DrawFormattedText(expWindow, rep_min2, Info.xC*0.1-80,5*Info.yC/3+100, white);
        DrawFormattedText(expWindow, rep_max2, Info.xC*0.9-60,5*Info.yC/3+100, white);
        
        DrawFormattedText(expWindow, rep_min2, Info.xC*1.1-80,5*Info.yC/3+100, white);
        DrawFormattedText(expWindow, rep_max2, Info.xC*1.9-60,5*Info.yC/3+100, white);
        
        
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
        Screen('TextSize', expWindow, 30);   
        DrawFormattedText(expWindow, ['Vous avez gagne :' '\n \n' num2str(results.Gain(itrial)) ' points'], 'center', 'center', white);
        Screen('Flip', expWindow);
        WaitSecs(1.5);
    end

    results.TotalGain = sum(results.Gain);
    DrawFormattedText(expWindow, ['Merci de votre participation\n \nVous avez gagne :' num2str(results.TotalGain) ' point'], 'center', 'center');
    Screen('Flip', expWindow);
    passKey(Key.space);
    
    save(OutputFileMainWe, 'condition', 'which', 'sub', 'gender', 'date', 'trials', 'results', 'data');
    
    Screen('Close', expWindow); 
    ShowCursor;
    clear sound
    
catch WhatsTheError
    Screen('CloseAll')
    rethrow(WhatsTheError)
end

    
    
     