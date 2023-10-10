%test for scales
%2 questions asked (order randomized), 5 point scale for response

% add toolboxes to path
addpath('C:\Users\Emmanuelle\Dropbox\CODE_STAGE\Observation_project\Code\img');
addpath('C:\Users\Emmanuelle\Dropbox\CODE_STAGE\Observation_project\Code\AVATAR');
addpath('C:\Users\Emmanuelle\Dropbox\CODE_STAGE\Observation_project\Code\Toolboxes\Rand');
addpath('C:\Users\Emmanuelle\Dropbox\CODE_STAGE\Observation_project\Code\Toolboxes\IO');
addpath('C:\Users\Emmanuelle\Dropbox\CODE_STAGE\Observation_project\Code\Toolboxes\Stimuli\Visual');
addpath('C:\Users\Emmanuelle\Dropbox\CODE_STAGE\Observation_project\Code\Toolboxes\Psychtoolbox');

% set file saving parameters
filepath = fileparts(mfilename('fullpath'));
datapath = [filepath,filesep,'..',filesep,'Data'];

% hide cursor and stop spilling key presses into MATLAB windows
HideCursor;
FlushEvents;
ListenChar(); % 2enable listening, but need to CTRL+C when script abort with error (to reenable keyboard input)
% Number of frames to wait when specifying good timing
%waitframes = 1;

% set response keys/buttons
KbName('UnifyKeyNames');    % Use same key codes across operating systems for better portability
keypass = KbName('SPACE');
keyquit = KbName('ESCAPE');
leftkey = KbName('LeftArrow'); % Left Alt i.e 65 sur Linux
rightkey = KbName('RightArrow'); % Right Alt i.e 93 ou 109 sur Linux % In fact 93 does not work -> 109 works
uparrow = KbName('UpArrow');
downarrow = KbName('DownArrow');


%% PsychToolBox parameters
% Preferences
Screen('Preference', 'SkipSyncTests', 2); % 2 to skip tests, as we don't need milisecond precision, 0 otherwise
Screen('Preference', 'DefaultFontName', 'helvetica');
Screen('Preference', 'DefaultFontSize', 60);
Screen('Preference', 'DefaultFontStyle', 0); % 0=normal,1=bold,2=italic,4=underline,8=outline,32=condense,64=extend,1+2=bold and italic.
Screen('Preference', 'DefaultTextYPositionIsBaseline', 1); % Permet d'aligner le texte sur une ligne, même si des lettres hautes (h) ou basses (p) existent

% Colors definition
white = [255 255 255];
grey = white/2;
black = [0 0 0];
red= [255 0 0];
green= [0 255 0];

% Start PsychToolBox
screens=Screen('Screens');
screenNumber=max(screens); % Main screen
[win,winRect] = Screen('OpenWindow',screenNumber,black); % Open a window with a 'background' color
[xc, yc] = RectCenterd(winRect); % Get coordinates of screen center

% generator reset
rand('state',sum(100*clock));  % should NOT be necessary with OCTAVE, but still...

    
%% timing parameters
fixationtime=0.500;
stimulitime=2.500;
sidetime=0.500;
feedbacktime=0.500;
endingtime=2.500;
refreshtime=0.050;

% Size 
penWidthPixels = 6; % size of the framed square
baseTilt = [0 0 4 20]; % size of tilt in self report scales (end of session)

space = 25;
size_line=5; %*2

%selfPos = 0.25 + (0.25+0.25)*rand;
tilt1.XposSelf = xc; %winRect(3)*selfPos;
tilt1.YposSelf = 2*yc/3;%winRect(4)*0.5; 

tilt2.XposSelf = xc; %winRect(3)*selfPos;
tilt2.YposSelf = 5*yc/3;%winRect(4)*0.5; 

pixelsPerPressedTilt= xc-(3*xc/4);

%% questions (order counterbalanced)
Q_A = 'Evaluer votre sentiment de control sur la tache';
Q_B = 'Evaluer le control que vous avez sur la tache';

% randomized order of questions ?(1,2 or 2,1)
%     questionsAll = [{[Q_A Q_B]},{[Q_B Q_A]}];   
%     order_questions = questionsAll{1+rem(suj,2)}; 

%additional
suj=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RUN %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ready to start
DrawFormattedText(win,'PRET','center','center',red);
Screen('Flip',win);
WaitSecs(sidetime);            

exitQuestion1 =0; 
while exitQuestion1 == 0
    
    Screen('TextSize', win, 25);
    DrawFormattedText(win, Q_1, 'center',yc/3, white); %bf: yc/2
    DrawFormattedText(win, Q_2, 'center',4*yc/3, grey); %bf 3*yc/2
    
    %scale 1 for Q1
    %text
    Screen('TextSize', win, 20);
    DrawFormattedText(win, '3',xc/2-5*space,2*yc/3+2*space,white); %winRect(3)*0.5
    DrawFormattedText(win, '4',3*xc/4-space,2*yc/3+2*space,white); %xc/2 or winRect(3)*0.25
    DrawFormattedText(win, '5',xc-space,2*yc/3+2*space,white); %winRect(3)*0.5
    DrawFormattedText(win, '6',5*xc/4-space,2*yc/3+2*space,white); %3xc/2 or winRect(3)*0.75
    DrawFormattedText(win, '7',3*xc/2-space,2*yc/3+2*space,white); %winRect(3)*0.5
    %lines drawn
    Screen('DrawLine', win, white, xc/2, 2*yc/3, 3*xc/2, 2*yc/3,4); %horizontal
    Screen('DrawLine', win, white, xc/2, 2*yc/3-size_line, xc/2, 2*yc/3+size_line,4); %1st bar:
    Screen('DrawLine', win, white, 3*xc/4, 2*yc/3-size_line, 3*xc/4, 2*yc/3+size_line,4); %2nd bar:
    Screen('DrawLine', win, white, xc, 2*yc/3-size_line, xc, 2*yc/3+size_line,4); %3rd bar:
    Screen('DrawLine', win, white, 5*xc/4, 2*yc/3-size_line, 5*xc/4, 2*yc/3+size_line,4); %4th bar:
    Screen('DrawLine', win, white, 3*xc/2, 2*yc/3-size_line, 3*xc/2, 2*yc/3+size_line,4); %5th bar :
    
    %text scale 1 for Q2
    Screen('TextSize', win, 20);
    DrawFormattedText(win, 'beaucoup moins',xc/2-5*space,5*yc/3+2*space,grey); %winRect(3)*0.5
    DrawFormattedText(win, 'moins',3*xc/4-space,5*yc/3+2*space,grey); %xc/2 or winRect(3)*0.25
    DrawFormattedText(win, 'autant',xc-space,5*yc/3+2*space,grey); %winRect(3)*0.5
    DrawFormattedText(win, 'plus',5*xc/4-space,5*yc/3+2*space,grey); %3xc/2 or winRect(3)*0.75
    DrawFormattedText(win, 'beaucoup plus',3*xc/2-space,5*yc/3+2*space,grey); %winRect(3)*0.5
      %lines drawn
    Screen('DrawLine', win, grey, xc/2, 5*yc/3, 3*xc/2, 5*yc/3,4); %horizontal
    Screen('DrawLine', win, grey, xc/2, 5*yc/3-size_line, xc/2, 5*yc/3+size_line,4); %1st bar:
    Screen('DrawLine', win, grey, 3*xc/4, 5*yc/3-size_line, 3*xc/4, 5*yc/3+size_line,4); %2nd bar:
    Screen('DrawLine', win, grey, xc, 5*yc/3-size_line, xc, 5*yc/3+size_line,4); %3rd bar:
    Screen('DrawLine', win, grey, 5*xc/4, 5*yc/3-size_line, 5*xc/4, 5*yc/3+size_line,4); %4th bar:
    Screen('DrawLine', win, grey, 3*xc/2, 5*yc/3-size_line, 3*xc/2, 5*yc/3+size_line,4); %5th bar :
    
  [keyIsDown, secs, keyCode1] = KbCheck;

    if keyCode1(keyquit)
        sca;
    elseif keyCode1(keypass)
        exitQuestion1 = 1;
        if tilt1.XposSelf == xc/2
            answer_Q1 = -2;
        elseif tilt1.XposSelf == 3*xc/4
            answer_Q1 = -1;
        elseif tilt1.XposSelf == xc
            answer_Q1 = 0;
        elseif tilt1.XposSelf == 5*xc/4
            answer_Q1 = 1;
        elseif tilt1.XposSelf == 3*xc/2
            answer_Q1 = 2;
        end
        break;
    elseif keyCode1(leftkey)
        tilt1.XposSelf = tilt1.XposSelf - pixelsPerPressedTilt;
    elseif keyCode1(rightkey)
        tilt1.XposSelf = tilt1.XposSelf + pixelsPerPressedTilt;
    end

    if tilt1.XposSelf < xc/2%winRect(3)*0.25
        tilt1.XposSelf = xc/2; %winRect(3)*0.25;
    elseif tilt1.XposSelf > 3*xc/2 %winRect(3)*0.75
        tilt1.XposSelf = 3*xc/2; %winRect(3)*0.75; 
    end

    centeredTiltSelf1 = CenterRectOnPointd(baseTilt, tilt1.XposSelf, tilt1.YposSelf);
    Screen('FillRect', win, red, centeredTiltSelf1);

    Screen('Flip', win);
    WaitSecs(refreshtime);   
end
WaitSecs(sidetime);

exitQuestion2 =0;
while exitQuestion2 == 0
    
    Screen('TextSize', win, 25);
    DrawFormattedText(win, Q_1, 'center',yc/3, grey); %bf: yc/2
    DrawFormattedText(win, Q_2, 'center',4*yc/3, white); %bf 3*yc/2
    
    %scale 1 for Q1
    %text
    Screen('TextSize', win, 20);
    DrawFormattedText(win, 'beaucoup moins',xc/2-5*space,2*yc/3+2*space,grey); %winRect(3)*0.5
    DrawFormattedText(win, 'moins',3*xc/4-space,2*yc/3+2*space,grey); %xc/2 or winRect(3)*0.25
    DrawFormattedText(win, 'autant',xc-space,2*yc/3+2*space,grey); %winRect(3)*0.5
    DrawFormattedText(win, 'plus',5*xc/4-space,2*yc/3+2*space,grey); %3xc/2 or winRect(3)*0.75
    DrawFormattedText(win, 'beaucoup plus',3*xc/2-space,2*yc/3+2*space,grey); %winRect(3)*0.5
    %lines drawn
    Screen('DrawLine', win, grey, xc/2, 2*yc/3, 3*xc/2, 2*yc/3,4); %horizontal
    Screen('DrawLine', win, grey, xc/2, 2*yc/3-size_line, xc/2, 2*yc/3+size_line,4); %1st bar:
    Screen('DrawLine', win, grey, 3*xc/4, 2*yc/3-size_line, 3*xc/4, 2*yc/3+size_line,4); %2nd bar:
    Screen('DrawLine', win, grey, xc, 2*yc/3-size_line, xc, 2*yc/3+size_line,4); %3rd bar:
    Screen('DrawLine', win, grey, 5*xc/4, 2*yc/3-size_line, 5*xc/4, 2*yc/3+size_line,4); %4th bar:
    Screen('DrawLine', win, grey, 3*xc/2, 2*yc/3-size_line, 3*xc/2, 2*yc/3+size_line,4); %5th bar :
    
    %text scale 1 for Q2
    Screen('TextSize', win, 20);
    DrawFormattedText(win, 'beaucoup moins',xc/2-5*space,5*yc/3+2*space,white); %winRect(3)*0.5
    DrawFormattedText(win, 'moins',3*xc/4-space,5*yc/3+2*space,white); %xc/2 or winRect(3)*0.25
    DrawFormattedText(win, 'autant',xc-space,5*yc/3+2*space,white); %winRect(3)*0.5
    DrawFormattedText(win, 'plus',5*xc/4-space,5*yc/3+2*space,white); %3xc/2 or winRect(3)*0.75
    DrawFormattedText(win, 'beaucoup plus',3*xc/2-space,5*yc/3+2*space,white); %winRect(3)*0.5
      %lines drawn
    Screen('DrawLine', win, white, xc/2, 5*yc/3, 3*xc/2, 5*yc/3,4); %horizontal
    Screen('DrawLine', win, white, xc/2, 5*yc/3-size_line, xc/2, 5*yc/3+size_line,4); %1st bar:
    Screen('DrawLine', win, white, 3*xc/4, 5*yc/3-size_line, 3*xc/4, 5*yc/3+size_line,4); %2nd bar:
    Screen('DrawLine', win, white, xc, 5*yc/3-size_line, xc, 5*yc/3+size_line,4); %3rd bar:
    Screen('DrawLine', win, white, 5*xc/4, 5*yc/3-size_line, 5*xc/4, 5*yc/3+size_line,4); %4th bar:
    Screen('DrawLine', win, white, 3*xc/2, 5*yc/3-size_line, 3*xc/2, 5*yc/3+size_line,4); %5th bar :
    
    [keyIsDown, secs, keyCode2] = KbCheck;
  
    if keyCode2(keyquit)
        sca;
    elseif keyCode2(keypass)
        exitQuestion2 = 1;
        if tilt2.XposSelf == xc/2
            answer_Q2 = -2;
        elseif tilt2.XposSelf == 3*xc/4
            answer_Q2 = -1;
        elseif tilt2.XposSelf == xc
            answer_Q2 = 0;
        elseif tilt2.XposSelf == 5*xc/4
            answer_Q2 = 1;
        elseif tilt2.XposSelf == 3*xc/2
            answer_Q2 = 2;
        end
        break;
    elseif keyCode2(leftkey)
        tilt2.XposSelf = tilt2.XposSelf - pixelsPerPressedTilt;
    elseif keyCode2(rightkey)
        tilt2.XposSelf = tilt2.XposSelf + pixelsPerPressedTilt;
    end

    if tilt2.XposSelf < xc/2%winRect(3)*0.25
        tilt2.XposSelf = xc/2; %winRect(3)*0.25;
    elseif tilt2.XposSelf > 3*xc/2 %winRect(3)*0.75
        tilt2.XposSelf = 3*xc/2; %winRect(3)*0.75; 
    end

    centeredTiltSelf2 = CenterRectOnPointd(baseTilt, tilt2.XposSelf, tilt2.YposSelf);
    Screen('FillRect', win, red, centeredTiltSelf2);

    Screen('Flip', win);
    WaitSecs(refreshtime);
end

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


