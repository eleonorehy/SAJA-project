function blocs = WP1a_blocs

NumberOfBloc = 12; % for good counterbalancing between all conditions

NumberOfTrialsPerBloc = 24; %for good counterbalancing between 4 sizes of squares * 4 positions of gains * 4 combinations of noise * 2 types of noise *1,5 noise 



%b1 = [];

% % creation of Blocks

B0 = repmat([1:3]', [4,1]);
B1 = randperm(size(B0, 1));
B2 = B0(B1);

nblocs = 12;

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
b9 = blocs(9).type; 
b10 = blocs(10).type; 
b11 = blocs(11).type; 
b12 = blocs(12).type;
% 
blocstype = [b1; b2; b3; b4; b5; b6; b7; b8; b9; b10; b11; b12]

% B0 = repmat([1:3]', [4,1]);
% B1 = randperm(size(B0, 1));
% B2 = B0(B1);
% 
% nblocs = 12;
% 
% for ibloc = 1:nblocs
%     
%     B4(ibloc) = []
%     B3 = repmat(B2(ibloc), [24, 1])
%     B4(ibloc) = [B4(ibloc) B3]
%        
% end







% x1 = repmat([2:5]', [72,1]); % repete 72 fois la serie de gains de 2 ? 4 en colonne --> 288 trials
% p2 = randperm(size(x1,1)); % associe les valeurs de gains ? des essais al?atoires
% what.gains = x1(p2);
% 
% x2 = repmat([-1 1]', [144,1]); % r?p?te 144 fois la valence (positive vs negative) du bruit
% p3 = randperm(size(x2,1)); % associe ces valences ? des essais aleatoires
% what.signe = x2(p3);
% 
% 
% x3 = [ones(1,12) zeros(1,12)]; % which axis with low / high noise
% x4 = repmat(x3,[1,12]);
% what.effectiveControl = x4;
% 
% what.kind = X(p1, 3) % regular, train, catch
% what.fluency = X(p1, 2); % high or low noise
% what.position = X(p1, 1); % which square to reach

end


