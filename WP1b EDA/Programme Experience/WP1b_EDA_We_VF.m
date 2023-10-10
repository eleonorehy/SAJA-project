clear all;
clearvars;
close all;  
  

addpath('/Users/agencyteam/Desktop/Tena IJN/WP1b EDA/Programme Experience/Function');
%addpath('/Users/solene/Desktop/Boulot/SLB IJN/WP1b/WP1b_EDA/Programme Experience/Function');
PsychDefaultSetup(2);
KbName('UnifyKeyNames');

% NOT WRITTING IN THE SCRIPT DURING THE EXPERIMENT
input('Appuyez sur ENTREE')
KbWait; 

% TRIGGERS : tester si le stimtrackeur peut ?tre branch? en s?rie ou
% claviers en s?rie : GOOD

%% open serial port

% s1 = serial('/dev/cu.usbserial-A900a2QL', 'BaudRate', 115200,'DataBits', 8, 'StopBits', 1, 'FlowControl', 'none', 'Parity', 'none', 'Terminator', 'CR', 'Timeout', 400, 'InputBufferSize', 16000);
% fopen(s1);

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

numberOfTrials = 192;

% Visual white noise
sd_noise = 1;  

% Fluency
% lowNoise = 2.5;
% highNoise = 5;

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
ResultFolderWe = '/Users/agencyteam/Desktop/Tena IJN/WP1b EDA/Stockage Resultat';
OutputFileMainWe = [ResultFolderWe 'PivoWe' sub '.mat'];

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
    PressSpace = 0;
    PressSpaceS1 = 0;
    PressSpaceS2 = 0;
    
    % Ecran d'accueil et attendre que les deux le fasse
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
    
   
    
    trials  = WP1b_trials ; % function that conterbalances all the experimental conditions
           

    
    % Set variables 
    
    Cagnotte1 = 0;
    Cagnotte2 = 0;
    
    Reward1block =  0;
    Reward2block = 0;

    blocknumb = 1;

    succeedTrials = 0;
    
%      HiLeSquare = 0;
%      HiRiSquare = 0;
%      LoLeSquare = 0;
%      LoRiSquare = 0;
     missTrials = 0;
     succeedTrials = 0;
     errTrials = 0;
     Reward1 = 0;
     Reward2 = 0;
     marker = 0;
    
    for itrial=1:numberOfTrials
        
    OutputFileTrial = [ResultFolderWe 'RewardEDA' sub '.mat'];
    bloctriggers(itrial).time = [];
    bloctriggers(itrial).stim = [];
    bloctriggers(itrial).num = [];
    bloctriggers(itrial).blocReward = []; 
    bloctriggers(itrial).fluency = [];
    bloctriggers(itrial).contrib = [];
    bloctriggers(itrial).kind = [];
    bloctriggers(itrial).ntrial = [];
    bloctriggers(itrial).nbloc = []; 
        
        %%%%% First trial
        
       if itrial == 1
           
        Tstart = GetSecs;
        fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
        fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
        marker = marker + 1;
        bloctriggers(itrial).time = [bloctriggers(itrial).time (GetSecs-Tstart)];
        bloctriggers(itrial).stim = [bloctriggers(itrial).stim 1]; %'start experiment & 1st baseline'
        bloctriggers(itrial).num = [bloctriggers(itrial).num marker];
        bloctriggers(itrial).blocReward = [bloctriggers(itrial).blocReward trials.blocReward(itrial)];
        bloctriggers(itrial).fluency = [bloctriggers(itrial).fluency trials.fluency(itrial)];
        bloctriggers(itrial).contrib = [bloctriggers(itrial).contrib trials.contrib(itrial)];
        bloctriggers(itrial).kind = [bloctriggers(itrial).kind trials.kind(itrial)]; 
        bloctriggers(itrial).ntrial = [bloctriggers(itrial).ntrial itrial];
        bloctriggers(itrial).nbloc = [bloctriggers(itrial).nbloc blocknumb]; 

              DrawFormattedText(expWindow, ['Relax pendant la baseline...\n \n Bougez le moins possible pendant les 2 prochaines minutes '], 'center', 'center', white);            
              Screen('Flip', expWindow);
              WaitSecs(60);
              
        fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
        fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
        marker = marker + 1;
        bloctriggers(itrial).time = [bloctriggers(itrial).time (GetSecs-Tstart)];
        bloctriggers(itrial).stim = [bloctriggers(itrial).stim 2]; %'end first baseline'
        bloctriggers(itrial).num = [bloctriggers(itrial).num marker];
        bloctriggers(itrial).blocReward = [bloctriggers(itrial).blocReward trials.blocReward(itrial)];
        bloctriggers(itrial).fluency = [bloctriggers(itrial).fluency trials.fluency(itrial)];
        bloctriggers(itrial).contrib = [bloctriggers(itrial).contrib trials.contrib(itrial)];
        bloctriggers(itrial).kind = [bloctriggers(itrial).kind trials.kind(itrial)];
        bloctriggers(itrial).ntrial = [bloctriggers(itrial).ntrial itrial];
        bloctriggers(itrial).nbloc = [bloctriggers(itrial).nbloc blocknumb];
           
            if trials.effectiveControl(itrial) == 0  
                Screen('TextSize', expWindow, 30);  
                DrawFormattedText(expWindow, 'PLAYER 1 : Placez votre main droite sur\n \nles touches GAUCHE et DROITE', 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);            
                DrawFormattedText(expWindow, 'PLAYER 2 : Placez votre main droite sur\n \nles touches HAUT et BAS', 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]); 
                Screen('Flip', expWindow);
                WaitSecs(5);
            elseif trials.effectiveControl(itrial) == 1
                Screen('TextSize', expWindow, 30);  
                DrawFormattedText(expWindow, 'PLAYER 1 : Placez votre main droite sur\n \nles touches HAUT et BAS', 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);            
                DrawFormattedText(expWindow, 'PLAYER 2 : Placez votre main droite sur\n \nles touches GAUCHE et DROITE', 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]); 
                Screen('Flip', expWindow);
                WaitSecs(5);
            else
                Screen('Flip', expWindow);
                WaitSecs(1);
            end
            
        fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
        fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
        marker = marker + 1;
        bloctriggers(itrial).time = [bloctriggers(itrial).time (GetSecs-Tstart)];
        bloctriggers(itrial).stim = [bloctriggers(itrial).stim 3]; %'end instructions'
        bloctriggers(itrial).num = [bloctriggers(itrial).num marker];
        bloctriggers(itrial).blocReward = [bloctriggers(itrial).blocReward trials.blocReward(itrial)];
        bloctriggers(itrial).fluency = [bloctriggers(itrial).fluency trials.fluency(itrial)];
        bloctriggers(itrial).contrib = [bloctriggers(itrial).contrib trials.contrib(itrial)];
        bloctriggers(itrial).kind = [bloctriggers(itrial).kind trials.kind(itrial)];
        bloctriggers(itrial).ntrial = [bloctriggers(itrial).ntrial itrial];
        bloctriggers(itrial).nbloc = [bloctriggers(itrial).nbloc blocknumb];
        
        
        %% BASELINE BLOCKS
        
       elseif itrial == 32| itrial == 64 | itrial == 96 | itrial == 128 | itrial == 160 % blocks baselines
           
           
        fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
        fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
        marker = marker + 1;
        bloctriggers(itrial).time = [bloctriggers(itrial).time (GetSecs-Tstart)];
        bloctriggers(itrial).stim = [bloctriggers(itrial).stim 4]; %'start other blocks & baseline'
        bloctriggers(itrial).num = [bloctriggers(itrial).num marker];
        bloctriggers(itrial).blocReward = [bloctriggers(itrial).blocReward trials.blocReward(itrial)];
        bloctriggers(itrial).fluency = [bloctriggers(itrial).fluency trials.fluency(itrial)];
        bloctriggers(itrial).contrib = [bloctriggers(itrial).contrib trials.contrib(itrial)];
        bloctriggers(itrial).kind = [bloctriggers(itrial).kind trials.kind(itrial)];
        bloctriggers(itrial).ntrial = [bloctriggers(itrial).ntrial itrial];
        bloctriggers(itrial).nbloc = [bloctriggers(itrial).nbloc blocknumb];

            
              DrawFormattedText(expWindow, ['Relax pendant la baseline...\n \n Bougez le moins possible pendant les 2 prochaines minutes '], 'center', 'center', white);            
              Screen('Flip', expWindow);
              WaitSecs(60);
              
        fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
        fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
        marker = marker + 1;
        bloctriggers(itrial).time = [bloctriggers(itrial).time (GetSecs-Tstart)];
        bloctriggers(itrial).stim = [bloctriggers(itrial).stim 5]; %'end other baselines & start instructions'
        bloctriggers(itrial).num = [bloctriggers(itrial).num marker];
        bloctriggers(itrial).blocReward = [bloctriggers(itrial).blocReward trials.blocReward(itrial)];
        bloctriggers(itrial).fluency = [bloctriggers(itrial).fluency trials.fluency(itrial)];
        bloctriggers(itrial).contrib = [bloctriggers(itrial).contrib trials.contrib(itrial)];
        bloctriggers(itrial).kind = [bloctriggers(itrial).kind trials.kind(itrial)];
        bloctriggers(itrial).ntrial = [bloctriggers(itrial).ntrial itrial];
        bloctriggers(itrial).nbloc = [bloctriggers(itrial).nbloc blocknumb];
              
            %% INSTRUCTIONS FOR BLOCK
            
            if trials.effectiveControl(itrial) == 0  
                Screen('TextSize', expWindow, 30);  
                DrawFormattedText(expWindow, 'PLAYER 1 : Placez votre main droite sur\n \nles touches GAUCHE et DROITE', 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);            
                DrawFormattedText(expWindow, 'PLAYER 2 : Placez votre main droite sur\n \nles touches HAUT et BAS', 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]); 
                Screen('Flip', expWindow);
                WaitSecs(5);
            elseif trials.effectiveControl(itrial) == 1
                Screen('TextSize', expWindow, 30);  
                DrawFormattedText(expWindow, 'PLAYER 1 : Placez votre main droite sur\n \nles touches HAUT et BAS', 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);            
                DrawFormattedText(expWindow, 'PLAYER 2 : Placez votre main droite sur\n \nles touches GAUCHE et DROITE', 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]); 
                Screen('Flip', expWindow);
                WaitSecs(5);
            else % ITI
                Screen('Flip', expWindow);
                WaitSecs(1);
            end
            
        fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
        fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
        marker = marker + 1;
        bloctriggers(itrial).time = [bloctriggers(itrial).time (GetSecs-Tstart)];
        bloctriggers(itrial).stim = [bloctriggers(itrial).stim 6]; %'end instructions'
        bloctriggers(itrial).num = [bloctriggers(itrial).num marker];
        bloctriggers(itrial).blocReward = [bloctriggers(itrial).blocReward trials.blocReward(itrial)];
        bloctriggers(itrial).fluency = [bloctriggers(itrial).fluency trials.fluency(itrial)];
        bloctriggers(itrial).contrib = [bloctriggers(itrial).contrib trials.contrib(itrial)];
        bloctriggers(itrial).kind = [bloctriggers(itrial).kind trials.kind(itrial)];
        bloctriggers(itrial).ntrial = [bloctriggers(itrial).ntrial itrial];
        bloctriggers(itrial).nbloc = [bloctriggers(itrial).nbloc blocknumb];
            
       end 
        
        
        %%%%% breaks and feedback & BASELINE
        
%         if itrial == 33 | itrial == 65 | itrial == 97 | itrial == 129 | itrial == 161 %| itrial == 192 % | itrial == 224 | itrial == 256 
%             
%             % sum of bloc variables
%             results.blocGain = sum(results.Gain);
%             Reward1block = Reward1block*0.16;
%             Reward2block = Reward2block*0.16;
%             PressSpace = 0;
%             PressSpaceS1 = 0;
%             PressSpaceS2 = 0;
%             
%         fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
%         fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
%         marker = marker + 1;
%         bloctriggers(itrial).time = [bloctriggers(itrial).time (GetSecs-Tstart)];
%         bloctriggers(itrial).stim = [bloctriggers(itrial).stim 7]; %'start break'
%         bloctriggers(itrial).num = [bloctriggers(itrial).num marker];
%         bloctriggers(itrial).blocReward = [bloctriggers(itrial).blocReward trials.blocReward(itrial)];
%         bloctriggers(itrial).fluency = [bloctriggers(itrial).fluency trials.fluency(itrial)];
%         bloctriggers(itrial).contrib = [bloctriggers(itrial).contrib trials.contrib(itrial)];
%         bloctriggers(itrial).kind = [bloctriggers(itrial).kind trials.kind(itrial)];
%         bloctriggers(itrial).ntrial = [bloctriggers(itrial).ntrial itrial];
%         bloctriggers(itrial).nbloc = [bloctriggers(itrial).nbloc blocknumb];
%             
%             Screen('TextSize', expWindow, 30);
%             DrawFormattedText(expWindow, ['Vous  avez le droit a une pause\n \nAppuyer sur espace pour vos stats au block ' num2str(blocknumb) '/6'], 'center', 'center', white);            
%             Screen('Flip', expWindow);
%             passKey(Key.space);
%             
%         while PressSpace == 0
%             
%             [keyIsDown1Sujet1,secs1Sujet1, keyCode1Sujet1] = PsychHID('KbCheck', keyboardIndices(1,1));
%             [keyIsDown1Sujet2,secs1Sujet2, keyCode1Sujet2] = PsychHID('KbCheck', keyboardIndices(1,2));
% 
%             if keyCode1Sujet1(Key.escape) || keyCode1Sujet2(Key.escape)
%                 sca;
%                 ShowCursor;
%                 clear sound
%             end
%             
%             
%             Screen('DrawLine', expWindow, white, Info.xC, 0, Info.xC, Info.rect(4),2);
%             Screen('TextSize', expWindow, 30);   
%             DrawFormattedText(expWindow, ['Player1 a gagne :' '\n \n' num2str(Reward1block) ' euros'], 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);
%             DrawFormattedText(expWindow, ['Player2 a gagne :' '\n \n' num2str(Reward2block) ' euros'], 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]);
%             Screen('Flip', expWindow);
%             %passKey(Key.space);
%                         
%             if keyCode1Sujet1(Key.space) 
%                 PressSpaceS1 = 1;
%             elseif keyCode1Sujet2(Key.space)
%                 PressSpaceS2 = 1;
%             end
%             
%             if PressSpaceS1 == 1 & PressSpaceS1 == 1
%                 PressSpace = 1;
%             end 
%                 
%         end
%         
%         fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
%         fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
%         marker = marker + 1;
%         bloctriggers(itrial).time = [bloctriggers(itrial).time (GetSecs-Tstart)];
%         bloctriggers(itrial).stim = [bloctriggers(itrial).stim 8]; %'end break'
%         bloctriggers(itrial).num = [bloctriggers(itrial).num marker];
%         bloctriggers(itrial).blocReward = [bloctriggers(itrial).blocReward trials.blocReward(itrial)];
%         bloctriggers(itrial).fluency = [bloctriggers(itrial).fluency trials.fluency(itrial)];
%         bloctriggers(itrial).contrib = [bloctriggers(itrial).contrib trials.contrib(itrial)];
%         bloctriggers(itrial).kind = [bloctriggers(itrial).kind trials.kind(itrial)];
%         bloctriggers(itrial).ntrial = [bloctriggers(itrial).ntrial itrial];
%         bloctriggers(itrial).nbloc = [bloctriggers(itrial).nbloc blocknumb];
%      
% 
%             %% RESET & UPDATE BLOCK DATA AFTER BLOCK FEED BACK
%             
%             missTrials = 0;
%             succeedTrials = 0;
%             errTrials = 0;
%             blocknumb = blocknumb + 1;
%             Reward1block =  0;
%             Reward2block = 0;
%        
%         end
        
        
%         if itrial ~= 1 && isfinite(trials.axisControl(itrial))
%             DrawFormattedText(expWindow, 'Vous avez le droit a une pause\n \nAppuyer sur espace pour reprendre', 'center', 'center', white);            
%             Screen('Flip', expWindow);
%             passKey(Key.space);
%         end
%        if trials.axisControl(itrial) == 0            
%             DrawFormattedText(expWindow, 'PLAYER 1 : Placez votre main droite sur\n \nles touches GAUCHE et DROITE', 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);            
%             DrawFormattedText(expWindow, 'PLAYER 2 : Placez votre main droite sur\n \nles touches HAUT et BAS', 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]); 
%             Screen('Flip', expWindow);
%             WaitSecs(5)
%         elseif trials.axisControl(itrial) == 1
%             DrawFormattedText(expWindow, 'PLAYER 1 : Placez votre main droite sur\n \nles touches HAUT et BAS', 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);            
%             DrawFormattedText(expWindow, 'PLAYER 2 : Placez votre main droite sur\n \nles touches GAUCHE et DROITE', 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]); 
%             Screen('Flip', expWindow);
%             WaitSecs(5)
%         end

%%% ongoing TRIALS PARAMETERS

        if trials.effectiveControl(itrial) == 1
            Sujet1 = 1;
        elseif trials.effectiveControl(itrial) == 0
            Sujet1 = 0;
        end
        
        %% fluency parameters for regular, catch and training trials
         
        if trials.kind(itrial) == 1 % regular trials
            lowNoise = 1.5;
            highNoise = 4;
        elseif trials.kind(itrial) == 2 % training trials
            lowNoise = 0;
            highNoise = 0;
        elseif trials.kind(itrial) == 3 % catch trials
            lowNoise = 10;
            highNoise = 10;
        end
                
        data(itrial).Xaxe = [];
        data(itrial).Yaxe = [];
        data(itrial).Fluent = [];
        data(itrial).Up = [];
        data(itrial).Down = [];
        data(itrial).Left = [];
        data(itrial).Right = []; 
        Contrib(itrial).Xaxe = [];
        Contrib(itrial).Yaxe = [];
        %ContribY = [];
        
        trialtriggers(itrial).time = [];
        trialtriggers(itrial).stim = [];
        trialtriggers(itrial).num = [];
        trialtriggers(itrial).blocReward = []; 
        trialtriggers(itrial).fluency = [];
        trialtriggers(itrial).contrib = [];
        trialtriggers(itrial).kind = [];
        trialtriggers(itrial).ntrial = [];
        trialtriggers(itrial).nbloc = []; 


        target = trials.gains(itrial); % specific value to reach in order to succed 
        targetPosition = trials.position(itrial);
        
        actualGain = [1 1 1 1];
        actualGain(targetPosition) = target;
        
       
        %% pivotality parameters for regular, catch and training trials
        
        if trials.contrib(itrial) == 1 % equal contrib
        [allRects, square] = DrawTheSquares(baseRect, Info, nXi);
%         elseif trials.contrib(itrial) == 2 % equal contrib
%         [allRects, square] = DrawTheSquares(baseRect, Info, nXi);  
        elseif trials.contrib(itrial) == 2 % low contrib on X axis
        [allRects, square] = DrawTheSquaresBis(baseRect, Info, nXi);
        elseif trials.contrib(itrial) == 3 % low contribution on  y axis
        [allRects, square] = DrawTheSquaresTer(baseRect, Info, nXi);
        end 
        
        Screen('FillRect', expWindow, grey, allRects);
        
        centeredRect = CenterRectOnPointd(baseRect, Info.xC, Info.yC);
        Screen('FillRect', expWindow, grey, centeredRect);
        
        tex = Screen('MakeTexture', expWindow, RectNoise);
        Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);
        
        fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
        fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
        marker = marker + 1;
        trialtriggers(itrial).time = [trialtriggers(itrial).time (GetSecs-Tstart)];
        trialtriggers(itrial).stim = [trialtriggers(itrial).stim 9]; %'squares onset'
        trialtriggers(itrial).num = [trialtriggers(itrial).num marker];
        trialtriggers(itrial).blocReward = [trialtriggers(itrial).blocReward trials.blocReward(itrial)];
        trialtriggers(itrial).fluency = [trialtriggers(itrial).fluency trials.fluency(itrial)];
        trialtriggers(itrial).contrib = [trialtriggers(itrial).contrib trials.contrib(itrial)];
        trialtriggers(itrial).kind = [trialtriggers(itrial).kind trials.kind(itrial)];
        trialtriggers(itrial).ntrial = [trialtriggers(itrial).ntrial itrial];
        trialtriggers(itrial).nbloc = [trialtriggers(itrial).nbloc blocknumb];
        
        for ga=1:length(actualGain) % position of gains in squares
        Screen('TextSize', expWindow, 30);
        DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
        end 
         
        Square1 = allRects(:,1);
        Square2 = allRects(:,2);
        Square3 = allRects(:,3);
        Square4 = allRects(:,4);
            
        Screen('Flip', expWindow);
        WaitSecs(2);
        
        fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
        fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
        marker = marker + 1;
        trialtriggers(itrial).time = [trialtriggers(itrial).time (GetSecs-Tstart)];
        trialtriggers(itrial).stim = [trialtriggers(itrial).stim 10]; %'ball onset'
        trialtriggers(itrial).num = [trialtriggers(itrial).num marker];
        trialtriggers(itrial).blocReward = [trialtriggers(itrial).blocReward trials.blocReward(itrial)];
        trialtriggers(itrial).fluency = [trialtriggers(itrial).fluency trials.fluency(itrial)];
        trialtriggers(itrial).contrib = [trialtriggers(itrial).contrib trials.contrib(itrial)];
        trialtriggers(itrial).kind = [trialtriggers(itrial).kind trials.kind(itrial)];
        trialtriggers(itrial).ntrial = [trialtriggers(itrial).ntrial itrial];
        trialtriggers(itrial).nbloc = [trialtriggers(itrial).nbloc blocknumb];
        
        TaskIsDown = false; 
        tStartTask = GetSecs;
        
        while TaskIsDown == false 

            %[allRects, square] = DrawTheSquares(baseRect, Info, nXi);
            if trials.contrib(itrial) == 1 % equal contrib
            [allRects, square] = DrawTheSquares(baseRect, Info, nXi);
%             elseif trials.contrib(itrial) == 2 % equal contrib
%             [allRects, square] = DrawTheSquares(baseRect, Info, nXi);  
            elseif trials.contrib(itrial) == 2 % low contrib on X axis
            [allRects, square] = DrawTheSquaresBis(baseRect, Info, nXi);
            elseif trials.contrib(itrial) == 3 % low contribution on  y axis
            [allRects, square] = DrawTheSquaresTer(baseRect, Info, nXi);
            end 

            Screen('FillRect', expWindow, grey, allRects);
            
            centeredRect = CenterRectOnPointd(baseRect, Info.xC, Info.yC);
            Screen('FillRect', expWindow, grey, centeredRect);
            
            tex = Screen('MakeTexture', expWindow, RectNoise);
            Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);
            
            for ga=1:length(actualGain)
            Screen('TextSize', expWindow, 30); 
            DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15, black);
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
                    dot.Xpos = dot.Xpos - pixelsPerPressDot ;
                    dot.Ypos = dot.Ypos + (actualNoise * trials.signe(itrial)) ;
                    upKP = upKP + 0;
                    downKP = downKP + 0;
                    leftKP = leftKP + 1;
                    rightKP = rightKP + 0; 
                end
                if keyCodeSujet1(Key.right)
                    dot.Xpos = dot.Xpos + pixelsPerPressDot ;
                    dot.Ypos = dot.Ypos + (actualNoise * trials.signe(itrial)) ;
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
                    dot.Ypos = dot.Ypos - pixelsPerPressDot ;
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
                
               
            elseif Sujet1 == 1 % sujet1 controls Yaxis and sujet2 controls Xaxis & noise on the controlled axis
                
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
                missTrials = missTrials + 1;
                
                fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
                fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
                marker = marker + 1;
                trialtriggers(itrial).time = [trialtriggers(itrial).time (GetSecs-Tstart)];
                trialtriggers(itrial).stim = [trialtriggers(itrial).stim 11]; %'missed target'
                trialtriggers(itrial).num = [trialtriggers(itrial).num marker];
                trialtriggers(itrial).blocReward = [trialtriggers(itrial).blocReward trials.blocReward(itrial)];
                trialtriggers(itrial).fluency = [trialtriggers(itrial).fluency trials.fluency(itrial)];
                trialtriggers(itrial).contrib = [trialtriggers(itrial).contrib trials.contrib(itrial)];
                trialtriggers(itrial).kind = [trialtriggers(itrial).kind trials.kind(itrial)];
                trialtriggers(itrial).ntrial = [trialtriggers(itrial).ntrial itrial];
                trialtriggers(itrial).nbloc = [trialtriggers(itrial).nbloc blocknumb];
            end
              
        end % end of the reaching task
        
        results.Time(itrial) = WhatIsTheTime;
        
        % Validation screen
        dot.Xpos = Info.xC; 
        dot.Ypos = Info.yC;

        Screen('FillRect', expWindow, grey, allRects);
        Screen('DrawTexture', expWindow, tex, [], centeredRect, [], 0);

        for ga=1:length(actualGain)
        Screen('TextSize', expWindow, 30);   
        DrawFormattedText(expWindow, num2str(actualGain(ga)), allRects(1,ga)+baseRect(3)/2-10, allRects(4,ga)-baseRect(3)/2+15 , black);
        end
        
        if results.Reach(itrial) == true
            if whichIsReached == allRects(: ,actualGain~=1)
                results.Success(itrial) = 1;
                results.Gain(itrial) = 1;
                frameColor = green;
                succeedTrials = succeedTrials + 1;
                
                fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
                fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
                marker = marker + 1;
                trialtriggers(itrial).time = [trialtriggers(itrial).time (GetSecs-Tstart)];
                trialtriggers(itrial).stim = [trialtriggers(itrial).stim 12]; %'green square = success'
                trialtriggers(itrial).num = [trialtriggers(itrial).num marker];
                trialtriggers(itrial).blocReward = [trialtriggers(itrial).blocReward trials.blocReward(itrial)];
                trialtriggers(itrial).fluency = [trialtriggers(itrial).fluency trials.fluency(itrial)];
                trialtriggers(itrial).contrib = [trialtriggers(itrial).contrib trials.contrib(itrial)];
                trialtriggers(itrial).kind = [trialtriggers(itrial).kind trials.kind(itrial)];
                trialtriggers(itrial).ntrial = [trialtriggers(itrial).ntrial itrial];
                trialtriggers(itrial).nbloc = [trialtriggers(itrial).nbloc blocknumb];
            else
                results.Success(itrial) = 0;
                results.Gain(itrial) = 0; 
                frameColor = red;
                errTrials = errTrials + 1;
                
                fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
                fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
                marker = marker + 1;
                trialtriggers(itrial).time = [trialtriggers(itrial).time (GetSecs-Tstart)];
                trialtriggers(itrial).stim = [trialtriggers(itrial).stim 13]; %'red square = error'
                trialtriggers(itrial).num = [trialtriggers(itrial).num marker];
                trialtriggers(itrial).blocReward = [trialtriggers(itrial).blocReward trials.blocReward(itrial)];
                trialtriggers(itrial).fluency = [trialtriggers(itrial).fluency trials.fluency(itrial)];
                trialtriggers(itrial).contrib = [trialtriggers(itrial).contrib trials.contrib(itrial)];
                trialtriggers(itrial).kind = [trialtriggers(itrial).kind trials.kind(itrial)];
                trialtriggers(itrial).ntrial = [trialtriggers(itrial).ntrial itrial];
                trialtriggers(itrial).nbloc = [trialtriggers(itrial).nbloc blocknumb];
                
            end
            Screen('FrameRect', expWindow, frameColor, whichIsReached, penWidthPixels);
        end
          
        Screen('Flip', expWindow);
        WaitSecs(0.5);
        
        fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
        fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
        marker = marker + 1;
        trialtriggers(itrial).time = [trialtriggers(itrial).time (GetSecs-Tstart)];
        trialtriggers(itrial).stim = [trialtriggers(itrial).stim 14]; %'end square feed back'
        trialtriggers(itrial).num = [trialtriggers(itrial).num marker];
        trialtriggers(itrial).blocReward = [trialtriggers(itrial).blocReward trials.blocReward(itrial)];
        trialtriggers(itrial).fluency = [trialtriggers(itrial).fluency trials.fluency(itrial)];
        trialtriggers(itrial).contrib = [trialtriggers(itrial).contrib trials.contrib(itrial)];
        trialtriggers(itrial).kind = [trialtriggers(itrial).kind trials.kind(itrial)];
        trialtriggers(itrial).ntrial = [trialtriggers(itrial).ntrial itrial];
        trialtriggers(itrial).nbloc = [trialtriggers(itrial).nbloc blocknumb];
        
        ContribX = (mean(data(itrial).Right) + mean(data(itrial).Left)) / (mean(data(itrial).Right) + mean(data(itrial).Left) + mean(data(itrial).Up) + mean(data(itrial).Down));
        ContribY = (mean(data(itrial).Up) + mean(data(itrial).Down)) / (mean(data(itrial).Right) + mean(data(itrial).Left) + mean(data(itrial).Up) + mean(data(itrial).Down));
        
        Contrib(itrial).Xaxe = [Contrib(itrial).Xaxe ContribX];
        Contrib(itrial).Yaxe = [Contrib(itrial).Yaxe ContribY];
        
       % REWARD CONDITIONS, GAINS FEEDBACK 
       
              
       if results.Success(itrial) == 1 && trials.blocReward(itrial) == 1 % trial is succeed and gains are equally shared 50%
            Reward1 = 0.5;
            Reward2 = 0.5;
                 
        elseif results.Success(itrial) == 1 && trials.blocReward(itrial) == 2 % trial is succeed and gains are linked to real motor contribution (deserved gain)
          
            
            if Sujet1 == 0 && trials.contrib(itrial) == 1 %equal contribution, P1 Controls X
                Reward1 = Contrib(itrial).Xaxe ;
                Reward2 = Contrib(itrial).Yaxe;           
            elseif Sujet1 == 0 && trials.contrib(itrial) == 2 %sujet 1 controls Xaxis and Xdistance is low
                Reward1 = Contrib(itrial).Xaxe ;
                Reward2 = Contrib(itrial).Yaxe;
            elseif Sujet1 == 0 && trials.contrib(itrial) == 3 %sujet 1 controls Xaxis and Xdistance is high (Y axis is small)
                Reward1 = Contrib(itrial).Xaxe ;
                Reward2 = Contrib(itrial).Yaxe;
            elseif Sujet1 == 1 && trials.contrib(itrial) == 1 %equal contribution, p1 contols Y
                Reward1 = Contrib(itrial).Yaxe;
                Reward2 = Contrib(itrial).Xaxe;               
            elseif Sujet1 == 1 && trials.contrib(itrial) == 2 %sujet 2 controls Xaxis and Xdistance is low
                Reward1 = Contrib(itrial).Yaxe;
                Reward2 = Contrib(itrial).Xaxe;   
            elseif Sujet1  == 1 && trials.contrib(itrial) == 3 %sujet 2 controls Xaxis and Xdistance is high (Y axis is small)
                Reward1 = Contrib(itrial).Yaxe;
                Reward2 = Contrib(itrial).Xaxe; 
            end
              
        elseif results.Success(itrial) == 1 && trials.blocReward(itrial) == 3 % trial is succeed and gains are randomly attributed (unfair)
            % randomReward2(itrial) = 1 - what.randomReward1(itrial)
            Reward1 = trials.randomReward1(itrial);
            Reward2 = 1 - trials.randomReward1(itrial);
        
        elseif results.Success(itrial) == 0
            Reward1 = 0;
            Reward2 = 0;
        
       end
        
        fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
        fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
        marker = marker + 1;
        trialtriggers(itrial).time = [trialtriggers(itrial).time (GetSecs-Tstart)];
        trialtriggers(itrial).stim = [trialtriggers(itrial).stim 15]; %'beginning money feedback for trial'
        trialtriggers(itrial).num = [trialtriggers(itrial).num marker];
        trialtriggers(itrial).blocReward = [trialtriggers(itrial).blocReward trials.blocReward(itrial)];
        trialtriggers(itrial).fluency = [trialtriggers(itrial).fluency trials.fluency(itrial)];
        trialtriggers(itrial).contrib = [trialtriggers(itrial).contrib trials.contrib(itrial)];
        trialtriggers(itrial).kind = [trialtriggers(itrial).kind trials.kind(itrial)];
        trialtriggers(itrial).ntrial = [trialtriggers(itrial).ntrial itrial];
        trialtriggers(itrial).nbloc = [trialtriggers(itrial).nbloc blocknumb];
       
        Screen('DrawLine', expWindow, white, Info.xC, 0, Info.xC, Info.rect(4),2);
        Screen('TextSize', expWindow, 30);   
        DrawFormattedText(expWindow, ['Player1 gagne :' '\n \n' num2str(Reward1) ' point'], 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);
        DrawFormattedText(expWindow, ['Player2 gagne :' '\n \n' num2str(Reward2) ' point'], 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]);
        Screen('Flip', expWindow);
        WaitSecs(6);
        
        fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
        fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
        marker = marker + 1;
        trialtriggers(itrial).time = [trialtriggers(itrial).time (GetSecs-Tstart)];
        trialtriggers(itrial).stim = [trialtriggers(itrial).stim 16]; %'end money feedback for trial'
        trialtriggers(itrial).num = [trialtriggers(itrial).num marker];
        trialtriggers(itrial).blocReward = [trialtriggers(itrial).blocReward trials.blocReward(itrial)];
        trialtriggers(itrial).fluency = [trialtriggers(itrial).fluency trials.fluency(itrial)];
        trialtriggers(itrial).contrib = [trialtriggers(itrial).contrib trials.contrib(itrial)];
        trialtriggers(itrial).kind = [trialtriggers(itrial).kind trials.kind(itrial)];
        trialtriggers(itrial).ntrial = [trialtriggers(itrial).ntrial itrial];
        trialtriggers(itrial).nbloc = [trialtriggers(itrial).nbloc blocknumb];
        
        Cagnotte1 = Cagnotte1 + Reward1;
        Cagnotte2 = Cagnotte2 + Reward2;
        Reward1block =  Reward1block + Reward1 ;
        Reward2block = Reward2block + Reward2 ;
       
%         Screen('TextSize', expWindow, 30);   
%         DrawFormattedText(expWindow, ['Vous avez gagne :' '\n \n' num2str(results.Gain(itrial)) ' points'], 'center', 'center', white);
%         Screen('Flip', expWindow);
%         WaitSecs(1.5);
%              
       % Evaluation of feeling of control   
       
        fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
        fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
        marker = marker + 1;
        trialtriggers(itrial).time = [trialtriggers(itrial).time (GetSecs-Tstart)];
        trialtriggers(itrial).stim = [trialtriggers(itrial).stim 17]; %'start questions'
        trialtriggers(itrial).num = [trialtriggers(itrial).num marker];
        trialtriggers(itrial).blocReward = [trialtriggers(itrial).blocReward trials.blocReward(itrial)];
        trialtriggers(itrial).fluency = [trialtriggers(itrial).fluency trials.fluency(itrial)];
        trialtriggers(itrial).contrib = [trialtriggers(itrial).contrib trials.contrib(itrial)];
        trialtriggers(itrial).kind = [trialtriggers(itrial).kind trials.kind(itrial)];
        trialtriggers(itrial).ntrial = [trialtriggers(itrial).ntrial itrial];
        trialtriggers(itrial).nbloc = [trialtriggers(itrial).nbloc blocknumb];
        
        Q_1 = 'A quel point penses tu\n \ncontroler le mouvement du point';
        rep_min1 = 'Pas du tout';
        rep_max1 = 'Completement';
        place = 40;
        if trials.question2(itrial) == 1
%             Q_2 = 'Quel est ton sentiment de\n \ncontrole sur l''essai';
%             rep_min2 = 'Controle\n \nindependant';
%             rep_max2 = 'Controle\n \npartage';
%             place = 40;
            Q_2 = 'A quel point pensez vous\n \ncontroler ensemble le mouvement du point ';
            rep_min2 = 'Pas du tout';
            rep_max2 = 'Completement';
            place = 60;
        elseif trials.question2(itrial) == 2
            Q_2 = 'A quel point pensez vous\n \ncontroler ensemble le mouvement du point ';
            rep_min2 = 'Pas du tout';
            rep_max2 = 'Completement';
            place = 60;
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
        
        fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
        fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
        marker = marker + 1;
        trialtriggers(itrial).time = [trialtriggers(itrial).time (GetSecs-Tstart)];
        trialtriggers(itrial).stim = [trialtriggers(itrial).stim 18]; %'end questions'
        trialtriggers(itrial).num = [trialtriggers(itrial).num marker];
        trialtriggers(itrial).blocReward = [trialtriggers(itrial).blocReward trials.blocReward(itrial)];
        trialtriggers(itrial).fluency = [trialtriggers(itrial).fluency trials.fluency(itrial)];
        trialtriggers(itrial).contrib = [trialtriggers(itrial).contrib trials.contrib(itrial)];
        trialtriggers(itrial).kind = [trialtriggers(itrial).kind trials.kind(itrial)];
        trialtriggers(itrial).ntrial = [trialtriggers(itrial).ntrial itrial];
        trialtriggers(itrial).nbloc = [trialtriggers(itrial).nbloc blocknumb];
        
        save(OutputFileTrial, 'condition', 'which', 'sub', 'gender', 'date', 'trials', 'results', 'data', 'Contrib', 'trialtriggers', 'bloctriggers' );
 
        %%%%% break and feedback
        
        if   itrial == 32 | itrial == 64 | itrial == 96 | itrial == 128 | itrial == 160 | itrial == 192  % | itrial == 224 | itrial == 256 
            
            % sum of bloc variables
            results.blocGain = sum(results.Gain);
            Reward1block = Reward1block*0.16;
            Reward2block = Reward2block*0.16;
            
            
            % sum of bloc variables
            results.blocGain = sum(results.Gain);
            Reward1block = Reward1block*0.16;
            Reward2block = Reward2block*0.16;
            PressSpace = 0;
            PressSpaceS1 = 0;
            PressSpaceS2 = 0;
            
        fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
        fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
        marker = marker + 1;
        bloctriggers(itrial).time = [bloctriggers(itrial).time (GetSecs-Tstart)];
        bloctriggers(itrial).stim = [bloctriggers(itrial).stim 7]; %'start break'
        bloctriggers(itrial).num = [bloctriggers(itrial).num marker];
        bloctriggers(itrial).blocReward = [bloctriggers(itrial).blocReward trials.blocReward(itrial)];
        bloctriggers(itrial).fluency = [bloctriggers(itrial).fluency trials.fluency(itrial)];
        bloctriggers(itrial).contrib = [bloctriggers(itrial).contrib trials.contrib(itrial)];
        bloctriggers(itrial).kind = [bloctriggers(itrial).kind trials.kind(itrial)];
        bloctriggers(itrial).ntrial = [bloctriggers(itrial).ntrial itrial];
        bloctriggers(itrial).nbloc = [bloctriggers(itrial).nbloc blocknumb];
            
            Screen('TextSize', expWindow, 30);
            DrawFormattedText(expWindow, ['Vous  avez le droit a une pause\n \nAppuyer sur espace pour vos stats au block ' num2str(blocknumb) '/6'], 'center', 'center', white);            
            Screen('Flip', expWindow);
            passKey(Key.space);
            
        while PressSpace == 0
            
            [keyIsDown1Sujet1,secs1Sujet1, keyCode1Sujet1] = PsychHID('KbCheck', keyboardIndices(1,1));
            [keyIsDown1Sujet2,secs1Sujet2, keyCode1Sujet2] = PsychHID('KbCheck', keyboardIndices(1,2));

            if keyCode1Sujet1(Key.escape) || keyCode1Sujet2(Key.escape)
                sca;
                ShowCursor;
                clear sound
            end
            
            
            Screen('DrawLine', expWindow, white, Info.xC, 0, Info.xC, Info.rect(4),2);
            Screen('TextSize', expWindow, 30);   
            DrawFormattedText(expWindow, ['Player1 a gagne :' '\n \n' num2str(Reward1block) ' euros'], 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);
            DrawFormattedText(expWindow, ['Player2 a gagne :' '\n \n' num2str(Reward2block) ' euros'], 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]);
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
        
        fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
        fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
        marker = marker + 1;
        bloctriggers(itrial).time = [bloctriggers(itrial).time (GetSecs-Tstart)];
        bloctriggers(itrial).stim = [bloctriggers(itrial).stim 8]; %'end break'
        bloctriggers(itrial).num = [bloctriggers(itrial).num marker];
        bloctriggers(itrial).blocReward = [bloctriggers(itrial).blocReward trials.blocReward(itrial)];
        bloctriggers(itrial).fluency = [bloctriggers(itrial).fluency trials.fluency(itrial)];
        bloctriggers(itrial).contrib = [bloctriggers(itrial).contrib trials.contrib(itrial)];
        bloctriggers(itrial).kind = [bloctriggers(itrial).kind trials.kind(itrial)];
        bloctriggers(itrial).ntrial = [bloctriggers(itrial).ntrial itrial];
        bloctriggers(itrial).nbloc = [bloctriggers(itrial).nbloc blocknumb];
     

            %% RESET & UPDATE BLOCK DATA AFTER BLOCK FEED BACK
            
            missTrials = 0;
            succeedTrials = 0;
            errTrials = 0;
            blocknumb = blocknumb + 1;
            Reward1block =  0;
            Reward2block = 0;
            
        end 
            
        
            
%             Screen('TextSize', expWindow, 30);
%             DrawFormattedText(expWindow, ['Vous  avez le droit a une pause\n \nAppuyer sur espace pour vos stats au block ' num2str(blocknumb) '/6'], 'center', 'center', white);            
%             Screen('Flip', expWindow);
%             passKey(Key.space);
%             
%             Screen('DrawLine', expWindow, white, Info.xC, 0, Info.xC, Info.rect(4),2);
%             Screen('TextSize', expWindow, 30);   
%             DrawFormattedText(expWindow, ['Player1 a gagne :' '\n \n' num2str(Reward1block) ' euros'], 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);
%             DrawFormattedText(expWindow, ['Player2 a gagne :' '\n \n' num2str(Reward2block) ' euros'], 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]);
%             Screen('Flip', expWindow);
%             passKey(Key.space);
            
%             if trials.effectiveControl(itrial+1) == 0  
%                 Screen('TextSize', expWindow, 30);  
%                 DrawFormattedText(expWindow, 'PLAYER 1 : Placez votre main droite sur\n \nles touches GAUCHE et DROITE', 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);            
%                 DrawFormattedText(expWindow, 'PLAYER 2 : Placez votre main droite sur\n \nles touches HAUT et BAS', 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]); 
%                 Screen('Flip', expWindow);
%                 WaitSecs(5);
%             elseif trials.effectiveControl(itrial+1) == 1
%                 Screen('TextSize', expWindow, 30);  
%                 DrawFormattedText(expWindow, 'PLAYER 1 : Placez votre main droite sur\n \nles touches HAUT et BAS', 'center', 'center', white, [], [], [], [], [], [Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);            
%                 DrawFormattedText(expWindow, 'PLAYER 2 : Placez votre main droite sur\n \nles touches GAUCHE et DROITE', 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]); 
%                 Screen('Flip', expWindow);
%                 WaitSecs(5);
%             else
%                 Screen('Flip', expWindow);
%                 WaitSecs(1);
%             end
            
            
%             DrawFormattedText(expWindow, ['Vous  avez le droit a une pause\n \nAppuyer sur espace pour vos stats au block ' num2str(blocknumb) '/8'], 'center', 'center', white);            
%             Screen('Flip', expWindow);
%             passKey(Key.space);
%             DrawFormattedText(expWindow, ['Vous gagnez ' num2str(succeedTrials) ' points pour ce block '], 'center', 'center');            
%             Screen('Flip', expWindow);
%             passKey(Key.space);
            
            % set and reset block variables after feedback
%             HiLeSquare = 0;
%             HiRiSquare = 0;
%             LoLeSquare = 0;
%             LoRiSquare = 0;
%             missTrials = 0;
%             succeedTrials = 0;
%             errTrials = 0;
%             blocknumb = blocknumb + 1;
%             Reward1block =  0;
%             Reward2block = 0;
        
        %end   
        
    end
    
    Cagnotte1 = Cagnotte1*0.16;
    Cagnotte2 = Cagnotte2*0.16;
    sharedCagnotte = (Cagnotte1 + Cagnotte2)/2
    results.TotalGain = sum(results.Gain);
       
    fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
    fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
    marker = marker + 1;
    bloctriggers(itrial).time = [bloctriggers(itrial).time (GetSecs-Tstart)];
    bloctriggers(itrial).stim = [bloctriggers(itrial).stim 19]; %'start final Feedback'
    bloctriggers(itrial).num = [bloctriggers(itrial).num marker];
    bloctriggers(itrial).blocReward = [bloctriggers(itrial).blocReward trials.blocReward(itrial)];
    bloctriggers(itrial).fluency = [bloctriggers(itrial).fluency trials.fluency(itrial)];
    bloctriggers(itrial).contrib = [bloctriggers(itrial).contrib trials.contrib(itrial)];
    bloctriggers(itrial).kind = [bloctriggers(itrial).kind trials.kind(itrial)];
    bloctriggers(itrial).ntrial = [bloctriggers(itrial).ntrial itrial];
    bloctriggers(itrial).nbloc = [bloctriggers(itrial).nbloc blocknumb];
    
    Screen('DrawLine', expWindow, white, Info.xC, 0, Info.xC, Info.rect(4),2);
    Screen('TextSize', expWindow, 30);   
    DrawFormattedText(expWindow, ['Merci de votre participation \n \n Player1 a gagne :' '\n \n' num2str(sharedCagnotte) ' euros'], 'center', 'center', white, [], [], [], [], [],[Info.rect(1) Info.rect(2) Info.xC, Info.rect(4)]);
    DrawFormattedText(expWindow, ['Merci de votre participation \n \n Player2 a gagne :' '\n \n' num2str(sharedCagnotte) ' euros'], 'center', 'center', white, [], [], [], [], [], [Info.xC Info.rect(2) Info.rect(3), Info.rect(4)]);
    Screen('Flip', expWindow);
    passKey(Key.space);
    
        
    Screen('Close', expWindow); 
    ShowCursor;
    clear sound
    
    fprintf(s1,['mh',0011]) % DECIMAL 3, BIT 7 --> comment7
    fprintf(s1,['mh',0010]) % decimal 2, bit 8 --> comment8
    marker = marker + 1;
    bloctriggers(itrial).time = [bloctriggers(itrial).time (GetSecs-Tstart)];
    bloctriggers(itrial).stim = [bloctriggers(itrial).stim 20]; %'end experiment'
    bloctriggers(itrial).num = [bloctriggers(itrial).num marker];
    bloctriggers(itrial).blocReward = [bloctriggers(itrial).blocReward trials.blocReward(itrial)];
    bloctriggers(itrial).fluency = [bloctriggers(itrial).fluency trials.fluency(itrial)];
    bloctriggers(itrial).contrib = [bloctriggers(itrial).contrib trials.contrib(itrial)];
    bloctriggers(itrial).kind = [bloctriggers(itrial).kind trials.kind(itrial)];
    bloctriggers(itrial).ntrial = [bloctriggers(itrial).ntrial itrial];
    bloctriggers(itrial).nbloc = [bloctriggers(itrial).nbloc blocknumb];
    
    save(OutputFileMainWe, 'condition', 'which', 'sub', 'gender', 'date', 'trials', 'results', 'data', 'Contrib', 'trialtriggers', 'bloctriggers');
    
 
    %% close serial port
    
    fclose(s1);
    
catch WhatsTheError
    Screen('CloseAll')
    rethrow(WhatsTheError)
end

    
    
     