function what = WP1b_trials

NumberOfBloc = 6;

NumberOfTrialsPerBlock = 32;

what.axisControl = NaN(192,1);

PASDENOM = [1 33 65 97 129 161 193] % 225 257 289];

p1 = [];

X0 = fullfact([2,3,4,1]); % matrice compl?te : bruit / contribution motrice HIGH on x-y or normal / reward partag?e fair ou al?atoire / position du gain / type d'essai
X1 = fullfact([1,1,4,3]);
X1 = X1(5:12, :); % matrice catch & train trials
%X1 = repmat(X1, [4, 1]); 
X1 = [X0; X1]; % basic matrix with all types of trials
X = repmat(X1,[6,1])

%X = repmat(X,[2,1]) ; % basic matrix is repeated twice

for ibloc=1:NumberOfBloc

    p(ibloc).mesgain = randperm(size(X(PASDENOM(ibloc):1:PASDENOM(ibloc+1)-1,:),1));
    p1 = [p1 p(ibloc).mesgain+(32*(ibloc-1))];
    if rem(ibloc,2) == 0
        what.axisControl(PASDENOM(ibloc)) = 0;
    else
        what.axisControl(PASDENOM(ibloc)) = 1;
    end
    
end

x1 = repmat([2:5]', [48,1]);
p2 = randperm(size(x1,1));
what.gains = x1(p2);

x2 = repmat([-1 1]', [96,1]); %repmat([-1 1]', [96,1]);
p3 = randperm(size(x2,1));
what.signe = x2(p3);

x3 = [ones(1,32) zeros(1,32)];
x4 = repmat(x3,[1,3]);
what.effectiveControl = x4;

x5 = repmat([1 2]', [96,1]);
p4 = randperm(size(x5,1));
what.question2 = x5(p4);

x6 = repmat([0 1]', [16,1]);
p5 = randperm(size(x6,1));
p6 = x6(p5);
%p6 = repmat(p5, [1, 6]);
%what.randomReward1 = x6(p5);
what.randomReward1 = repmat(p6, [6, 1]); % little matrix of 32 random rewards (0 or 1) that is repeated 6 times (6 blocks)
what.randomReward2 = 1 - what.randomReward1;

what.fluency = X(p1,1); % high or low fluency
what.contrib = X(p1, 2); % high or low motor contrib on x or y or normal
%what.lowAx = X(p1,3); % which axis with low motor contrib
%what.reward = X(p1,3); % shared or random or deserved (function of motor contribution) REWARD
what.position = X(p1,3); % position of the target to reach
what.kind = X(p1,4);  % Type of trial : catch or train or regular


% BLOCKS OF REWARDS

B0 = repmat([1:3]', [2,1]); %B0 = repmat([1:3]', [3,1])
B1 = randperm(size(B0, 1));
B2 = B0(B1);

nblocs = 6 ; % to suppress after 3 blocs pilote

for ibloc = 1:nblocs
    
    blocs(ibloc).type = []
    B3 = repmat(B2(ibloc), [32, 1])
    blocs(ibloc).type = [blocs(ibloc).type B3]
       
end

b1 = blocs(1).type; 
b2 = blocs(2).type; 
b3 = blocs(3).type; 
b4 = blocs(4).type; 
b5 = blocs(5).type; 
b6 = blocs(6).type; 
% b7 = blocs(7).type; 
% b8 = blocs(8).type; 
% b9 = blocs(9).type; 

% 
blocstype = [b1; b2; b3; b4; b5; b6]; %b7; b8] %; b9];
what.blocReward = blocstype;


end


