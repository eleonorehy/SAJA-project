function what = WP2a_trials_copy

format short g

NumberOfBloc = 8;

Ntrialblock = 40;

ntrials = NumberOfBloc * Ntrialblock;

what.axisControl = NaN(320,1);

%PASDENOM = [1 37 73 109 145 181 217 253 289];
PASDENOM = [1]

a = 1

for d = 1:NumberOfBloc
    a = a+40;
    PASDENOM(d+1) = a;
end

p1 = [];

X0 = fullfact([3,3,2,2,4]); % 3 motor noises * 3 decision matrices * 2 kinds of deviation noises (only relevant for the code) * 2 types of questions * 4 delays

mat0 = repmat(X0,[((1/4)*NumberOfBloc),1]);
%fluency =  mat(:, 1);
%matrix = mat(:, 2);
%noise = mat(:, 3);
%question2 = mat(:, 4);
%delays = mat(:, 5);
catcht = ones(36*NumberOfBloc,1);
mat0(:, 6) = catcht;

%We need a new matrix for catch trials. No matter what we will keep the number of this to 10% of the trials

mat1 = zeros(4*NumberOfBloc,6);
mat1(:,1) = randi(3, (4*NumberOfBloc), 1);
mat1(:,2) = randi(3, (4*NumberOfBloc), 1);
mat1(:,3) = randi(2,(4*NumberOfBloc),1);
mat1(:,4) = randi(2,(4*NumberOfBloc),1);
mat1(:,5) = randi(4,(4*NumberOfBloc),1);

mat = [mat0;mat1];
fluency =  mat(:, 1);
matrix = mat(:, 2);
noise = mat(:, 3);
question2 = mat(:, 4);
delays = mat(:,5);
catcht = mat(:,6);

X = table(fluency, matrix, noise, question2, delays, catcht)