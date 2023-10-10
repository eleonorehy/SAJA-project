function what = WP1a_trials

format short g

NumberOfBloc = 6;

Ntrialblock = 32;

ntrials = NumberOfBloc * Ntrialblock

what.axisControl = NaN(192,1);

PASDENOM = [1 33 65 97 129 161 193];

p1 = [];

X0 = fullfact([3,2,2]); % 2 motor noises * 2 decision matrices * 2 kinds of deviation noises (only relevant for the code)
% to split full matrix into 2 coordination - competition matrices
Xcoop = X0(1:6, :);
Xcomp = X0(7:12, :);
matcoop = repmat(Xcoop,[16,1]); % 4*48 = 192
matcomp = repmat(Xcomp,[16,1]); % 4*48 = 192

% gain value / matrices 
% 
% symmetrical gains (2/3 of the matrix) --> players earn the same thing if
% the target(s) is/are reached

%onegain1 = [repmat([1.1:1.1]', [3, 1]); repmat([2.2:2.2]', [3, 1]); repmat([3.3:3.3]', [3, 1])];
%onegain1 = [{'1.1'}',{'2.2'}',{'3.3'}']';
%onegain2 = repmat({'0.0'}', [3, 1]);
%onegain = [onegain1, onegain2];
%onegain = repmat(onegain, [72, 1]);
nullgain = repmat({'0.0'}', [3, 1]);

% COOPERATION  MATRIX

symgain1 = [{'1.1'}', {'2.2'}', {'3.3'}']'; 
symgain2 = [{'1.1'}', {'2.2'}', {'3.3'}']';
symgain = [symgain1, symgain2];
gains1 = repmat(symgain1, [32,1]);
gains2 = repmat(symgain2, [32,1]);
nullgains = repmat(nullgain, [32, 1]);

gainDegree = matcoop(:, 1);
fluency = matcoop(:, 2);
matrix =  matcoop(:, 3);

Xcoop = table(gainDegree, fluency, matrix, gains1, gains2, nullgains);
randXcoop = Xcoop(randperm(size(Xcoop, 1)), :);

% COMPETITION MATRIX

asymgain1 = [{'1.0'}', {'2.1'}', {'3.2'}']'; % advantage for player 1 at left
asymgain2 = [{'0.1'}', {'1.2'}', {'2.3'}']'; % advantage for player 2 at right
asymgain = [asymgain1, asymgain2];
gains1 = repmat(asymgain1, [32,1]);
gains2 = repmat(asymgain2, [32,1]);

gainDegree = matcomp(:, 1);
fluency = matcomp(:, 2);
matrix =  matcomp(:, 3);

Xcomp = table(gainDegree, fluency, matrix, gains1, gains2, nullgains);
randXcomp = Xcomp(randperm(size(Xcomp, 1)), :);

% gains1 = [symgain1; asymgain1]; % 6 different values
% gains1 = repmat(gains1, [32, 1]);
% gains2 = [symgain2; asymgain2];
% gains2 = repmat(gains2, [32, 1]);

% FULL MATRIX

X = [randXcoop; randXcomp]
randX = [randXcoop; randXcomp];


% randomization of the full matrix X

for ibloc=1:NumberOfBloc

    p(ibloc).mesgain = randperm(size(X(PASDENOM(ibloc):1:PASDENOM(ibloc+1)-1,:),1));
    p1 = [p1 p(ibloc).mesgain+(32*(ibloc-1))];
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
position1 = repmat(position1, [16,1]); % 3*4*16 --> 192 trials

%position of gain 2 (matrix 2 & matrix 3) % decisional noise
position2 = [2;3;4;1;3;4;1;2;4;1;2;3];
position2 = repmat(position2, [16,1]); % 12*16 --> 192 trials

% position of null gains 
position3 = [3;2;2;3;1;1;2;1;1;2;1;1]; % position of gain 0.0
position3 = repmat(position3, [16,1]);

position4 = [4;4;3;4;4;3;4;4;2;3;3;2]; % position of gain 0.0
position4 = repmat(position4, [16,1]);


%full matrix of positions
position = [position1, position2, position3, position4];
randposition = position(randperm(size(position, 1)),:)

% randX
% x1 = repmat([2:5]', [72,1]);
% p2 = randperm(size(x1,1));

% direction of dot deviation
x2 = repmat([-1 1]', [96,1]);
p3 = randperm(size(x2,1));

% changing axis control every block of trials (each block) between both players
x3 = [ones(1, 32) zeros(1, 32)];
x4 = repmat(x3,[1, 3]);

% creation of parameters matrices for the main task (functions)
what.effectiveControl = x4;
what.signe = x2(p3);
what.fluency = [randX.fluency];
what.matrix = [randX.matrix];
what.gains1 = [randX.gains1];
what.values1 = str2double([randX.gains1]);
what.gains2 = [randX.gains2];
what.values2 = str2double([randX.gains2]);
what.gainDegree = [randX.gainDegree];

what.position1 = randposition(:, 1);
what.position2 = randposition(:, 2);
what.position3 = randposition(:, 3);
what.position4 = randposition(:, 4);
% what.gains = x1(p2);

end


