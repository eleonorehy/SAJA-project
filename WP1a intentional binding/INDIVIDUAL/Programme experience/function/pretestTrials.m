function trials = pretestTrials(aloneOrTwo)
X0 = fullfact([2,2,2]);
X = repmat(X0, [1,1]);
p = randperm(size(X,1));

factor.fluency = X1(p,1);
factor.axis = X1(p,2);
factor.beginer = X1(p,3);

for fac=1:length(p)
    if factor.fluency(fac)==1
        trials.turb = 1;
    else
        trials.tub = 2;
    end
    
    if factor.axis(fac) == 1
        trials.theAxe = X;
    else
        trials.theAxe = y;
    end
    
    if factor.beginer == 1
        trials.player = player1;
    else
        trials.player = player2;
    end
    
end

if aloneOrTwo == false
    trials.number = 1;
else 
    trials.number = 2;
end
