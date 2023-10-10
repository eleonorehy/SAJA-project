%test for scales
%2 questions asked (order randomized), 5 point scale for response

% set response keys/buttons
KbName('UnifyKeyNames');    % Use same key codes across operating systems for better portability
keypass = KbName('SPACE');
keyquit = KbName('ESCAPE');
leftkey = KbName('LeftArrow'); % Left Alt i.e 65 sur Linux
rightkey = KbName('RightArrow'); % Right Alt i.e 93 ou 109 sur Linux % In fact 93 does not work -> 109 works
uparrow = KbName('UpArrow');
downarrow = KbName('DownArrow');
Key.one = KbName('A'); Key.two = KbName('Z'); Key.three = KbName('E');
Key.four = KbName('R'); Key.five = KbName('T'); Key.six = KbName('Y');
Key.seven = KbName('U');Key.eight = KbName('I');Key.nine = KbName('O');


%% PsychToolBox parameters
% Preferences
Screen('Preference', 'SkipSyncTests', 2); % 2 to skip tests, as we don't need milisecond precision, 0 otherwise
Screen('Preference', 'DefaultFontName', 'helvetica');
Screen('Preference', 'DefaultFontSize', 60);
Screen('Preference', 'DefaultFontStyle', 0); % 0=normal,1=bold,2=italic,4=underline,8=outline,32=condense,64=extend,1+2=bold and italic.
Screen('Preference', 'DefaultTextYPositionIsBaseline', 1); % Permet d'aligner le texte sur une ligne, mÃªme si des lettres hautes (h) ou basses (p) existent

% Colors definition
white = [255 255 255];
grey = white/2;
black = [0 0 0];
green= [0 255 0];

% Start PsychToolBox
screens=Screen('Screens');
screenNumber=max(screens); % Main screen
[win,winRect] = Screen('OpenWindow',screenNumber,black); % Open a window with a 'background' color
[xc, yc] = RectCenterd(winRect); % Get coordinates of screen center

% generator reset
% rand('state',sum(100*clock));  % should NOT be necessary with OCTAVE, but still...

    
%% timing parameters
fixationtime=0.500;
stimulitime=2.500;
sidetime=0.500;
feedbacktime=0.500;
endingtime=2.500;
refreshtime=0.100;

% Size 
penWidthPixels = 6; % size of the framed square
baseTilt = [0 0 4 20]; % size of tilt in self report scales (end of session)

space = 25;
size_line=5; %*2


%% questions (order counterbalanced)
Q_A = 'Estimez vos gains gagnés sur cette session \n \n par rapport à l autre joueur';
Q_B = 'Estimez vos gains gagnés sur cette session \n \n par rapport à l ensemble des joueurs ayant participé';

suj=1;

if rem(suj,2)==0 %% for even trial numbers.
    Q_1= Q_A;
    Q_2= Q_B;
else
    Q_1 = Q_B;
    Q_2 = Q_A;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RUN %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ready to start            
scaleNumber = 1:9;
scaleSpace=0.4:0.15:1.6;
    
Screen('TextSize', win, 25);
DrawFormattedText(win, Q_1, 'center',yc/3, white); 
DrawFormattedText(win, Q_2, 'center',4*yc/3, grey); 

% Q1
Screen('TextSize', win, 20);
Screen('DrawLine', win, white, xc*0.4, 2*yc/3, xc*1.6, 2*yc/3,4);
for scale1=1:9
    DrawFormattedText(win, num2str(scaleNumber(scale1)), xc*scaleSpace(scale1),2*yc/3+2*space, white);
    Screen('DrawLine', win, white, xc*scaleSpace(scale1), 2*yc/3-size_line, xc*scaleSpace(scale1), 2*yc/3+size_line,4);
end

% Q2
Screen('TextSize', win, 20);    
Screen('DrawLine', win, grey, xc*0.4, 5*yc/3, xc*1.6, 5*yc/3,4); 
for scale2=1:9
    DrawFormattedText(win, num2str(scaleNumber(scale2)), xc*scaleSpace(scale2),5*yc/3+2*space, grey);
    Screen('DrawLine', win, grey, xc*scaleSpace(scale2), 5*yc/3-size_line, xc*scaleSpace(scale2), 5*yc/3+size_line,4);
end
    
Screen('Flip', win);

[keyIsDown, secs, keyCode1] = KbCheck;
while keyCode1 == 0
    [keyIsDown, secs, keyCode1] = KbCheck;
end
if keyCode1(keyquit)
    sca;
elseif keyCode1(Key.one)
    answer_Q1 = 1;
elseif keyCode1(Key.two)
    answer_Q1 = 2;        
elseif keyCode1(Key.three)
    answer_Q1 = 3;        
elseif keyCode1(Key.four)
    answer_Q1 = 4;        
elseif keyCode1(Key.five)
    answer_Q1 = 5;        
elseif keyCode1(Key.six)
    answer_Q1 = 6;        
elseif keyCode1(Key.seven)
    answer_Q1 = 7;        
elseif keyCode1(Key.eight)
    answer_Q1 = 8;        
elseif keyCode1(Key.nine)
    answer_Q1 = 9;
elseif keyCode1(Key.ten)
    answer_Q1 = 10;  
end

WaitSecs(sidetime);
    
Screen('TextSize', win, 25);
DrawFormattedText(win, Q_1, 'center',yc/3, grey); %bf: yc/2
DrawFormattedText(win, Q_2, 'center',4*yc/3, white); %bf 3*yc/2

 % Q1
Screen('TextSize', win, 20);
Screen('DrawLine', win, grey, xc*0.4, 2*yc/3, xc*1.6, 2*yc/3,4); %horizontal
for scale1=1:9
    DrawFormattedText(win, num2str(scaleNumber(scale1)), xc*scaleSpace(scale1),2*yc/3+2*space, grey);
    Screen('DrawLine', win, grey, xc*scaleSpace(scale1), 2*yc/3-size_line, xc*scaleSpace(scale1), 2*yc/3+size_line,4); 
end

% Q2
Screen('TextSize', win, 20);    
Screen('DrawLine', win, white, xc*0.4, 5*yc/3, xc*1.6, 5*yc/3,4); %horizontal
for scale2=1:9
    DrawFormattedText(win, num2str(scaleNumber(scale2)), xc*scaleSpace(scale2),5*yc/3+2*space, white);
    Screen('DrawLine', win, white, xc*scaleSpace(scale2), 5*yc/3-size_line, xc*scaleSpace(scale2), 5*yc/3+size_line,4);
end

Screen('Flip', win);

[keyIsDown, secs, keyCode2] = KbCheck;
while keyCode2 == 0
    [keyIsDown, secs, keyCode2] = KbCheck;
end

if keyCode2(keyquit)
    sca;
elseif keyCode2(Key.one)
    answer_Q2 = 1;
elseif keyCode2(Key.two)
    answer_Q2 = 2;
elseif keyCode2(Key.three)
    answer_Q2 = 3;
elseif keyCode2(Key.four)
    answer_Q2 = 4;
elseif keyCode2(Key.five)
    answer_Q2 = 5;
elseif keyCode2(Key.six)
    answer_Q2 = 6;
elseif keyCode2(Key.seven)
    answer_Q2 = 7;
elseif keyCode2(Key.eight)
    answer_Q2 = 8;
elseif keyCode2(Key.nine)
    answer_Q2 = 9;
end

WaitSecs(sidetime);

% finish
Screen('Flip', win);
DrawFormattedText(win, 'Experience finie! Merci pour votre participation','center', yc, white);
%Screen('DrawTexture', win, image_End, [], rectEndpic-1*rectDecalageY);
Screen('Flip', win);
WaitSecs(endingtime); %KbStrokeWait;
Screen('CloseAll');
ListenChar(0);
ShowCursor;
sca;