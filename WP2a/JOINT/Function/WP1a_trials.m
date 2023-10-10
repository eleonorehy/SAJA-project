function what = WP1a_trials

NumberOfBloc = 8;

what.axisControl = NaN(128,1);

PASDENOM = [1 17 33 49 65 81 97 113 129];

p1 = [];

X0 = fullfact([2,2,4]);
X = repmat(X0,[8,1]);

for ibloc=1:NumberOfBloc

    p(ibloc).mesgain = randperm(size(X(PASDENOM(ibloc):1:PASDENOM(ibloc+1)-1,:),1));
    p1 = [p1 p(ibloc).mesgain+(16*(ibloc-1))];
    if rem(ibloc,2) == 0
        what.axisControl(PASDENOM(ibloc)) = 0;
    else
        what.axisControl(PASDENOM(ibloc)) = 1;
    end
    
end

x1 = repmat([2:5]', [32,1]);
p2 = randperm(size(x1,1));

x2 = repmat([-1 1]', [64,1]);
p3 = randperm(size(x2,1));

x3 = [ones(1,16) zeros(1,16)];
x4 = repmat(x3,[1,4]);

what.effectiveControl = x4;
what.signe = x2(p3);
what.fluency = X(p1,1);
what.question2 = X(p1,2);
what.position = X(p1,3);
what.gains = x1(p2);
end


