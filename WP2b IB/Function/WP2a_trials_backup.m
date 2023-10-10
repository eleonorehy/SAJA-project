function what = WP2a_trials

format short g

NumberOfBloc = 9;

Ntrialblock = 36;

ntrials = NumberOfBloc * Ntrialblock;

what.axisControl = NaN(288,1);

PASDENOM = [1]

a = 1

for d = 1:NumberOfBloc
    a = a+36;
    PASDENOM(d+1) = a;
end

%t1 = [];

%Y0 = fullfact([2,2,4]);
%Y = repmat(Y0,[18,1]);

%for ibloc=1:NumberOfBloc

%    p(ibloc).mesgain = randperm(size(Y(PASDENOM(ibloc):1:PASDENOM(ibloc+1)-1,:),1));
%    t1 = [t1 p(ibloc).mesgain+(16*(ibloc-1))];

%end

p1 = [];

X0 = fullfact([3,3,2,2,4]); % 3 motor noises * 3 decision matrices * 2 kinds of deviation noises (only relevant for the code) * 2 types of questions * 4 delays

mat = repmat(X0,[8,1]); %gives 288 trials

fluency =  mat(:, 1);
matrix = mat(:, 2);
noise = mat(:, 3);
question2 = mat(:, 4);

catcht = ones(ntrials,1); %first a matrix of all ones

%the loop that will replace 1/8 of ones with twos
for i = 1:ntrials/8
    catcht(i,1) = 2
end

%adding the column for catch trials. This (with 288 trials) makes the first full trials of all conditions catch trials. Remaining repetitions are valid trials.
%it will not work for other numbers of trials

mat(:,5) = catcht


% gain value / matrices 
% 
% symmetrical gains (2/3 of the matrix) --> players earn the same thing if
% the target(s) is/are reached

%onegain1 = [repmat([1.1:1.1]', [3, 1]); repmat([2.2:2.2]', [3, 1]); repmat([3.3:3.3]', [3, 1])];
onegain1 = [{'1.1'}',{'2.2'}',{'3.3'}']';
onegain2 = repmat({'0.0'}', [3, 1]);
onegain = [onegain1, onegain2];
%onegain = repmat(onegain, [72, 1]);

% 300 trials with this condition --> 12 blocks of 25  trials
% onegainAsym1 = [{'1.0'}', {'2.1'}', {'3.2'}', {'0.0'}', {'0.0'}', {'0.0'}']';
% onegainAsym2 = [{'0.0'}', {'0.0'}', {'0.0'}', {'0.1'}', {'1.2'}', {'2.3'}']';
% onegainAsym = [onegainAsym1, onegainAsym2];

symgain1 = [{'1.1'}', {'2.2'}', {'3.3'}']'; 
symgain2 = [{'1.1'}', {'2.2'}', {'3.3'}']';
symgain = [symgain1, symgain2];

asymgain1 = [{'1.0'}', {'2.1'}', {'3.2'}']'; % advantage for player 1 at left
asymgain2 = [{'0.1'}', {'1.2'}', {'2.3'}']'; % advantage for player 2 at right
asymgain = [asymgain1, asymgain2];

gains1 = [onegain1; symgain1; asymgain1];
gains1 = repmat(gains1, [32, 1]);
gains2 = [onegain2; symgain2; asymgain2];
gains2 = repmat(gains2, [32, 1]);

% %onegain1 = [repmat([1.1:1.1]', [3, 1]); repmat([2.2:2.2]', [3, 1]); repmat([3.3:3.3]', [3, 1])];
% onegain1 = [(1.1:1.1),(2.2:2.2),(3.3:3.3)]';
% onegain2 = repmat((0.0:0.0), [3, 1]);
% onegain = [onegain1, onegain2];
% %onegain = repmat(onegain, [72, 1]);
% 
% symgain1 = [{'1.1'}', {'2.2'}', {'3.3'}']'; 
% symgain2 = [{'1.1'}', {'2.2'}', {'3.3'}']';
% symgain = [symgain1, symgain2];
% 
% asymgain1 = [{'1.0'}', {'2.1'}', {'3.2'}']'; % advantage for player 1
% asymgain2 = [{'0.1'}', {'1.2'}', {'2.3'}']'; % advantage for player 2
% asymgain = [asymgain1, asymgain2];
% 
% gains = [onegain; symgain; asymgain];
% gains = repmat(gains, [24, 1]);
               
% FULL MATRIX

X = table(fluency, matrix, noise, question2, gains1, gains2); % table format in the basic order
randX = X(randperm(size(X, 1)), :);
fluency = [randX.fluency];

% randomization of the full matrix X

for ibloc=1:NumberOfBloc

    p(ibloc).mesgain = randperm(size(X(PASDENOM(ibloc):1:PASDENOM(ibloc+1)-1,:),1));
    p1 = [p1 p(ibloc).mesgain+(36*(ibloc-1))];
    if rem(ibloc,2) == 0
        what.axisControl(PASDENOM(ibloc)) = 0;
    else
        what.axisControl(PASDENOM(ibloc)) = 1;
    end
    
end

% Matrix of gains positions (combinations of first and second gain) --> 12
% combinations

% position of gain 1 (matrix 1, mtrix 2, matrix 3)
position1 = [repmat([1:1]', [3, 1]); repmat([2:2]', [3, 1]); repmat([3:3]', [3, 1]); repmat([4:4]', [3, 1])];
position1 = repmat(position1, [24,1]); % 3*4*24 --> 288 trials
               
%position of gain 2 (matrix 2 & matrix 3) % decisional noise
position2 = [2;3;4;1;3;4;1;2;4;1;2;3];
position2 = repmat(position2, [24,1]); % 12*24 --> 288 trials
               
%full matrix of positions
position = [position1, position2];
randposition = position(randperm(size(position, 1)),:);
               
% randX
% x1 = repmat([2:5]', [72,1]);
% p2 = randperm(size(x1,1));

% direction of dot deviation
x2 = repmat([-1 1]', [144,1]);
p3 = randperm(size(x2,1));

% changing axis control every 24 trials (each block) between both players
x3 = [ones(1, 36) zeros(1, 36)];
x4 = repmat(x3,[1, 4]);

% creation of parameters matrices for the main task (functions)
what.effectiveControl = x4;
what.signe = x2(p3);
            
%what.fluency = [X(p1,1)];
what.fluency = [randX.fluency];
            
%what.matrix = [X(p1,2)];
what.matrix = [randX.matrix];
            
%what.gains1 = [X(p1,3)];
what.noise = [randX.noise];

what.gains1 = [randX.gains1];
what.values1 = str2double([randX.gains1]);
%what.gains2 = [X(p1,4)];
what.gains2 = [randX.gains2];
what.values2 = str2double([randX.gains2]);

what.position1 = randposition(:, 1);
what.position2 = randposition(:, 2);
% what.gains = x1(p2);
                  
%A = X(p1,2);
%what.question2 = table2array(A);
%what.question2 = Y(t1,2);
what.question2 = [randX.question2];
            
timing = repmat([100, 300, 500, 700]', [12, 1]);
Timing = randperm(size(timing, 1));
what.randomDelay =timing(Timing)*10^-3;
            
            
end


