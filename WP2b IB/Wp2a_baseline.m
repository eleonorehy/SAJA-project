% CLEANING
close all;
clear all;
clearvars;

addpath('/Users/izeldilan/iCloud Drive/Documents/Cogmaster/Cogmaster Fall 2018/Joint Agency/ Izel IJN/WP2a_new/Function');
PsychDefaultSetup(2);
KbName('UnifyKeyNames'); 

% NOT WRITTING IN THE SCRIPT DURING THE EXPERIMENT
input('Appuyez sur ENTREE')
KbWait; 


% -------------------------------------------------------------------------
% VARIABLES
% -------------------------------------------------------------------------

[keyboardIndices, productNames, allInfos] = GetKeyboardIndices;
% Key QWERTY A = Q ; Z = W; K = K ; L = L
Key.escape = KbName('ESCAPE'); Key.space = KbName('SPACE');
Key.up = KbName('A'); Key.down = KbName('Z');
Key.left = KbName('K'); Key.right = KbName('L');

%CODE RESPONSE SCALE 1
Key.one1 = KbName('1!'); Key.two1 = KbName('2@'); Key.three1 = KbName('3#');
Key.four1 = KbName('4$'); Key.five1 = KbName('5%'); Key.six1 = KbName('6^');
Key.seven1 = KbName('7&');Key.eight1 = KbName('8*');Key.nine1 = KbName('9('); Key.ten1 = KbName('0)');

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

maxTime = 7;

TendDelay = 3;

numberOfTrials = 288; %208 

numberOfBaseline = 48; %48

% trialsPerBlock = 32;

cagnotte = 0; % cagnotte de base

% NUMBER OF TARGETs

%numberOfEasyTarget = 128;
%numberOfBasicTarget = 128;

% Visual white noise
sd_noise = 1; 

% Fluency  
% lowNoise = 2.5;
% %lowNoise = 0;
% highNoise = 5; 
% %highNoise = 0;


% Audio white noise
sr = 44100;
d = 1000;  
noise = (rand(1, round(sr*d))*2)-1;
 
% Scales       
space = 25;
size_line=5;
scaleNumber = 1:9;
scaleNumber1 = 0:100:800;
scaleSpace=0.1:0.1:0.9;
scaleSpace1=0.3:0.15:1.65;

keyIsDownSujet1 = []; 
keyIsDownSujet2 = [];

% Psychtoolbox preferences
Screen('Preference', 'SkipSyncTests', 2);
Screen('Preference', 'DefaultFontSize', 30);
Screen('Preference', 'DefaultFontStyle', 0); 
Screen('Preference', 'DefaultTextYPositionIsBaseline', 1);
  
% % Data storage
[condition,which,sub,gender,date] = subjectVariables;
ResultFolderSelf = '/Users/izeldilan/iCloud Drive/Documents/Cogmaster/Cogmaster Fall 2018/Joint Agency/ Izel IJN/WP2a_new/data';
OutputFileMainSelf = [ResultFolderSelf 'IBself_full' sub '.mat'];
OutputFileTrial = [ResultFolderSelf 'IBself_trials' sub '.mat'];
OutputFileBaselineSelf = [ResultFolderSelf 'IBself_baseline' sub '.mat'];

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

% Ecran d'accueil
%     sound(noise,sr);
%    DrawFormattedText(expWindow, 'Appuyer sur espace pour commencer', 'center','center', white);

%    Screen('Flip', expWindow);
%    passKey(Key.space);

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

            if PressSpaceS1 == 1 && PressSpaceS2 == 1
                PressSpace = 1;
            end

    end

trials = WP1a_baseline ;
   
for itrial=1:numberOfBaseline
    
    OutputFileTrial = [ResultFolderSelf 'IBself_baseline' sub '.mat'];


    if trials.blocRating(itrial) == 1 || trials.blocRating(itrial) == 2 
        delay = trials.randomDelay(itrial);
    end 
    
            
        %%%%% First trial

   if itrial == 1 %|| itrial == 25 || itrial == 49 || itrial == 73 || itrial == 97 || itrial == 121 % the first trial of each block (24 trials per block)


     if trials.blocRating(itrial) == 1 || trials.blocRating(itrial) == 2
         DrawFormattedText(expWindow, 'Durant ce block, vous devrez estimer l"intervalle de temps entre le flash et le beep \n \nLorsque cela vous le sera demande, \nestimez cet intervalle de temps a l"aide de l"echelle. \n \nMaintenez votre regard sur le carre qui apparaitra au centre de l" ecran.', 'center', 'center', white);            
         Screen('Flip', expWindow);
         WaitSecs(10);
     end



   end 
       
    
%     t_spacePress_baseline(itrial).S1 = [];
%     results = [];
    
centeredRect = CenterRectOnPointd(baseRect, Info.xC, Info.yC);
Screen('FillRect', expWindow, grey, centeredRect);
tex = Screen('MakeTexture', expWindow, RectNoise);
Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);
Screen('Flip', expWindow);

WaitSecs(2);


%frameColor =  green;
% Screen('FillRect', expWindow, grey, centeredRect);
% tex = Screen('MakeTexture', expWindow, RectNoise);
% Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);
% Screen('FrameRect', expWindow, frameColor, centeredRect, penWidthPixels);          
% Screen('Flip', expWindow);
% screenColor = green;

Screen('FillRect', expWindow, white) %flash
Screen('Flip', expWindow); 
WaitSecs(0.1);

%screenColor = black;
% Screen('TextSize', expWindow, 80);
% DrawFormattedText(expWindow, '', 'center','center', white)

    
Screen('FillRect', expWindow, black)
Screen('Flip', expWindow); 

WaitSecs(delay);
    

 [keyIsDownSujet1,secsSujet1, keyCode] = PsychHID('KbCheck', keyboardIndices(1,1));
[keyIsDownSujet2,secsSujet2, keyCodeSujet2] = PsychHID('KbCheck', keyboardIndices(1,2));
%[keyIsDown,secs,keyCode] = KbCheck;
    if keyCode1Sujet1(Key.escape) || keyCodeSujet2(Key.escape)
        sca;
        ShowCursor;
        clear sound
    end

        
      Beeper(500, 1, 0.150);


%Screen('TextSize', expWindow, 80);
%DrawFormattedText(expWindow, '', 'center','center', white)
%Screen('Flip', expWindow);
WaitSecs(0.150);

Q_0 = 'Delai en ms entre\n \nle flash et le beep';
            rep_min0 = '0 ms';
            rep_100 = '100ms';
            rep_200 = '200ms';
            rep_300 = '300ms';
            rep_400 = '400ms';
            rep_500 = '500ms';
            rep_600 = '600ms';
            rep_700 = '700ms';
            rep_800 = '800ms';
            rep_max0 = '800 ms';

Screen('DrawLine', expWindow, white, Info.xC, 0, Info.xC, Info.rect(4),2);

Screen('TextSize', expWindow, 25);

DrawFormattedText(expWindow, Q_0, 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, 1.25*Info.yC]);
DrawFormattedText(expWindow, Q_0, 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), 1.25*Info.yC]);

Screen('TextSize', expWindow, 15); %20

DrawFormattedText(expWindow, rep_min0, Info.xC*0.1-10,1.25*Info.yC, white);
DrawFormattedText(expWindow, rep_max0, Info.xC*0.9-10-10,1.25*Info.yC, white);

DrawFormattedText(expWindow, rep_min0, Info.xC*1.1-10,1.25*Info.yC, white);
DrawFormattedText(expWindow, rep_max0, Info.xC*1.9-10-10,1.25*Info.yC, white);


Screen('TextSize', expWindow, 20);
Screen('DrawLine', expWindow, white, Info.xC*0.1, 1.25*Info.yC-100, Info.xC*0.9, 1.25*Info.yC-100,4);

for scale1a=1:9
    DrawFormattedText(expWindow, num2str(scaleNumber(scale1a)), Info.xC*scaleSpace(scale1a)-10,1.25*Info.yC-100+2*space, white);
    Screen('DrawLine', expWindow, white, Info.xC*scaleSpace(scale1a), 1.25*Info.yC-100-size_line, Info.xC*scaleSpace(scale1a), 1.25*Info.yC-100+size_line,4);
end

Screen('DrawLine', expWindow, white, Info.xC*1.1, 1.25*Info.yC-100, Info.xC*1.9, 1.25*Info.yC-100,4);

for scale1b=1:9
    DrawFormattedText(expWindow, num2str(scaleNumber(scale1b)), Info.xC*(scaleSpace(scale1b)+1)-10,1.25*Info.yC-100+2*space, white);
    Screen('DrawLine', expWindow, white, Info.xC*(scaleSpace(scale1b)+1), 1.25*Info.yC-100-size_line, Info.xC*(scaleSpace(scale1b)+1), 1.25*Info.yC-100+size_line,4);
end

Screen('Flip', expWindow);

tStartQuestion0 = GetSecs;
Q0answered = 0;
Q0S1answered = 0;
Q0S2answered = 0;


while Q0answered == 0

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
            results.Baseline_Q0S1(itrial) = 1;
            Q0S1answered = 1;
        elseif keyCode1Sujet1(Key.two1)
            results.Baseline_Q0S1(itrial) = 2;
            Q0S1answered = 1;
        elseif keyCode1Sujet1(Key.three1)
            results.Baseline_Q0S1(itrial) = 3;
            Q0S1answered = 1;
        elseif keyCode1Sujet1(Key.four1)
            results.Baseline_Q0S1(itrial) = 4;
            Q0S1answered = 1;
        elseif keyCode1Sujet1(Key.five1)
            results.Baseline_Q0S1(itrial) = 5;
            Q0S1answered = 1;
        elseif keyCode1Sujet1(Key.six1)
            results.Baseline_Q0S1(itrial) = 6;
            Q0S1answered = 1;
        elseif keyCode1Sujet1(Key.seven1)
            results.Baseline_Q0S1(itrial) = 7;
            Q0S1answered = 1;
        elseif keyCode1Sujet1(Key.eight1)
            results.Baseline_Q0S1(itrial) = 8;
            Q0S1answered = 1;
        elseif keyCode1Sujet1(Key.nine1)
            results.Baseline_Q0S1(itrial) = 9;
            Q0S1answered = 1;
        else
            [keyIsDown1Sujet1,secs1Sujet1, keyCode1Sujet1] = PsychHID('KbCheck', keyboardIndices(1,1));
        end
    end

    if keyIsDown1Sujet2 == 1
        if keyCode1Sujet2(Key.one1)
            results.Baseline_Q0S2(itrial) = 1;
            Q0S2answered = 1;
        elseif keyCode1Sujet2(Key.two1)
            results.Baseline_Q0S2(itrial) = 2;
            Q0S2answered = 1;
        elseif keyCode1Sujet2(Key.three1)
            results.Baseline_Q0S2(itrial) = 3;
            Q0S2answered = 1;
        elseif keyCode1Sujet2(Key.four1)
            results.Baseline_Q0S2(itrial) = 4;
            Q0S2answered = 1;
        elseif keyCode1Sujet2(Key.five1)
            results.Baseline_Q0S2(itrial) = 5;
            Q0S2answered = 1;
        elseif keyCode1Sujet2(Key.six1)
            results.Baseline_Q0S2(itrial) = 6;
            Q0S2answered = 1;
        elseif keyCode1Sujet2(Key.seven1)
            results.Baseline_Q0S2(itrial) = 7;
            Q0S2answered = 1;
        elseif keyCode1Sujet2(Key.eight1)
            results.Baseline_Q0S2(itrial) = 8;
            Q0S2answered = 1;
        elseif keyCode1Sujet2(Key.nine1)
            results.Baseline_Q0S2(itrial) = 9;
            Q0S2answered = 1;
        else
            [keyIsDown1Sujet2,secs1Sujet2, keyCode1Sujet2] = PsychHID('KbCheck', keyboardIndices(1,2));
        end
    end

        if Q0S1answered == 1 && Q0S2answered == 1
            Q0answered = 1;
        end
end


%Screen('DrawLine', expWindow, white, Info.xC, 0, Info.xC, Info.rect(4),2);

    
    delaybis = trials.randomDelay(itrial)*1000;
    results.realDelay_baseline(itrial) = delaybis;
    results.estimDelay_baselineS1(itrial) = results.Baseline_Q0S1(itrial);
    results.estimDelay_baselineS2(itrial) = results.Baseline_Q0S2(itrial);
    

    if results.realDelay_baseline(itrial) > results.estimDelay_baselineS1(itrial) & results.estimDelay_baselineS1(itrial) > 0
        results.estimAccuracy_baselineS1(itrial) = (results.estimDelay_baselineS1(itrial) / results.realDelay_baseline(itrial))*100 ;
        results.estimSens_baselineS1(itrial) = 1; % intentional binding
    elseif results.realDelay_baseline(itrial) < results.estimDelay_baselineS1(itrial)
        results.estimAccuracy_baselineS1(itrial) = (results.realDelay_baseline(itrial) / results.estimDelay_baselineS1(itrial))*100 ;
        results.estimSens_baselineS1(itrial) = 0; % repulsion
    elseif results.realDelay_baseline(itrial) == results.estimDelay_baselineS1(itrial) 
        results.estimAccuracy_baselineS1(itrial) = 100;
        results.estimSens_baselineS1(itrial) = 2; % perfect estimation
    elseif results.estimDelay_baselineS1(itrial) == 0 & results.realDelay_baseline(itrial) > 0       
            results.estimAccuracy_baselineS1(itrial) = NaN;
            results.estimSens_baselineS1(itrial) = 1; % inetional binding
    end

    if results.realDelay_baseline(itrial) > results.estimDelay_baselineS2(itrial) & results.estimDelay_baselineS2(itrial) > 0
        results.estimAccuracy_baselineS2(itrial) = (results.estimDelay_baselineS2(itrial) / results.realDelay_baseline(itrial))*100 ;
        results.estimSens_baselineS2(itrial) = 1; % intentional binding
    elseif results.realDelay_baseline(itrial) < results.estimDelay_baselineS2(itrial)
        results.estimAccuracy_baselineS2(itrial) = (results.realDelay_baseline(itrial) / results.estimDelay_baselineS2(itrial))*100 ;
        results.estimSens_baselineS2(itrial) = 0; % repulsion
    elseif results.realDelay_baseline(itrial) == results.estimDelay_baselineS2(itrial)
        results.estimAccuracy_baselineS2(itrial) = 100;
        results.estimSens_baselineS2(itrial) = 2; % perfect estimation
    elseif results.estimDelay_baselineS2(itrial) == 0 & results.realDelay_baseline(itrial) > 0
        results.estimAccuracy_baselineS2(itrial) = NaN;
        results.estimSens_baselineS2(itrial) = 1; % inetional binding
    end

    
end 
catch WhatsTheError
    Screen('CloseAll')
    rethrow(WhatsTheError)
end
 save(OutputFileBaselineSelf, 'condition', 'which', 'sub', 'gender', 'date', 'trials', 'results');


    

     
