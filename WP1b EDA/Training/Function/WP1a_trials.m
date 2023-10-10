function what = WP1a_trials

NumberOfBloc = 8; % for good counterbalancing between all conditions

NumberOfTrialsPerBloc = 24; %for good counterbalancing between 4 sizes of squares * 4 positions of gains * 4 combinations of noise * 2 types of noise *1,5 noise 

what.axisControl = NaN(192,1);

%PASDENOM = [1 25 49 73 97 121 145 169 193]; only for breaks
%PASDENOM = [1 65 129 193]; % for full counterbalancing

PASDENOM = [1 25 49 73 97 121 145 169 193];
%PASDENOM = [1 129 257 385];

p1 = [];

bloc = [];

X0 = fullfact([4,2,1]); % matrice complete non repetee pour combiner le niveau de bruit, la position du gain
X1 = fullfact([1,1,3]); % matrice des essais train & catch
X1 = X1(2:3,:); % matrice catch & train amput?e des essais valides 1
X2 = [X0; repmat(X1, [2,1])]; % Matrice de base pour les 3 types d'essais
X2 = repmat(X2,[2,1]); 
X = repmat(X2,[8,1]) % repete 9 fois la matrice x0 (24 ESSAIS) sur les m?mes colonnes

for ibloc=1:NumberOfBloc

    p(ibloc).mesgain = randperm(size(X(PASDENOM(ibloc):1:PASDENOM(ibloc+1)-1,:),1));
    p1 = [p1 p(ibloc).mesgain+(24*(ibloc-1))];
    if rem(ibloc,2) == 0
        what.axisControl(PASDENOM(ibloc)) = 0;
    else
        what.axisControl(PASDENOM(ibloc)) = 1;
    end
    
end

x1 = repmat([2:5]', [48,1]); % repete 54 fois la serie de gains de 2 ? 4 en colonne --> 216 trials
p2 = randperm(size(x1,1)); % associe les valeurs de gains ? des essais al?atoires
what.gains = x1(p2);

x2 = repmat([-1 1]', [96,1]); % r?p?te 144 fois la valence (positive vs negative) du bruit
p3 = randperm(size(x2,1)); % associe ces valences ? des essais aleatoires
what.signe = x2(p3);

x3 = [ones(1,12) zeros(1,12)]; % which axis with low / high noise
x4 = repmat(x3,[1,8]);
what.effectiveControl = x4;

what.kind = X(p1, 3) % regular, train, catch
what.fluency = X(p1, 2); % high or low noise
what.position = X(p1, 1); % which square to reach

% % creation of Blocks type

B0 = repmat([1:2]', [4,1]); %B0 = repmat([1:3]', [3,1])
B1 = randperm(size(B0, 1));
B2 = B0(B1);

nblocs = 8 ; % to suppress after 3 blocs pilote

for ibloc = 1:nblocs
    
    blocs(ibloc).type = []
    B3 = repmat(B2(ibloc), [24, 1])
    blocs(ibloc).type = [blocs(ibloc).type B3]
       
end


b1 = blocs(1).type; 
b2 = blocs(2).type; 
b3 = blocs(3).type; 
b4 = blocs(4).type; 
b5 = blocs(5).type; 
b6 = blocs(6).type; 
b7 = blocs(7).type; 
b8 = blocs(8).type; 
% b9 = blocs(9).type; 

% 
blocstype = [b1; b2; b3; b4; b5; b6; b7; b8] %; b9];
what.bloctype = blocstype;

end


