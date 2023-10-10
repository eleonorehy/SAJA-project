clearvars
close all
home

% full sample

participantsGT = ['CP'; 'LE'; 'UB'] 
DataFolder = '';
OutputData = [DataFolder 'GT_pilote.mat'];
team = 1;
subject = 1;
root = '/Users/agencyteam/Desktop/Izel IJN/WP2a original/JOINT/data GT1'
output = [root 'rawdata' subject '.csv']



for ipar = 1:length(participantsGT)
    part = participantsGT(ipar, :); 
    part2Open = ['WP2pilote' part '.mat'] % naming behavioural data
    load(part2Open)

    
%%%%%%%%%%%%%%%% ANALYSES COMPORTEMENTALES %%%%%%%%%%%%%%%%%%%%%

    NumberOfTrials = 288;
    ntrials = 288;


    results.TimeR = results.Time; % remaining time
    results.TimeR(results.TimeR<0)=0;
    
    ResultSuccess = results.Success';
    ResultsTR = 7 - results.TimeR; % response time
    ResultsTR = ResultsTR';
    ResultsQ1_player1 = results.Answer_Q1S1';
    ResultsQ2_player1 = results.Answer_Q2S1';
    ResultsQ1_player2 = results.Answer_Q1S2';
    ResultsQ2_player2 = results.Answer_Q2S2';
    ResultsQ1Q2_player1 = [ResultsQ1_player1, ResultsQ2_player1];
    ResultsQ1Q2_player2 = [ResultsQ1_player2, ResultsQ2_player2];
    
%     corrplot(ResultsQ1Q2)
%     [R_Q1_Q2, P_Q1_Q2] = corrcoef(ResultsQ1, ResultsQ2) 

% figures of ball trajectories for all trials per pair     
    figure;
    for itrial = 1:NumberOfTrials
      if ResultSuccess(itrial) == 1 && trials.fluency(itrial) == 1 %&& trials.position(itrial) == 1
          subplot(1, 2, 1);
          hold on;
          plot(data(itrial).Xaxe, data(itrial).Yaxe)
          hold off;
          title(['High Fluency']);
          %title(['High Fluency' part]); % for all participants
      elseif ResultSuccess(itrial) == 1 && trials.fluency(itrial) == 2 %&& trials.position(itrial) == 1
          subplot(1, 2, 2);
          hold on ;
          plot(data(itrial).Xaxe, data(itrial).Yaxe)
          hold off;
          title(['Low Fluency']);
          % title(['Low Fluency' part]);
      end
    end
    
    % CREATION OF A MATRICE OF REAL MOTOR CONTRIBUTION FOR EACH PLAYER
    
    contribPlayer = [];
    
    
    for itrial=1:NumberOfTrials
        
        if trials.effectiveControl(itrial) == 0
            contribPlayer(itrial).P1 = Contrib(itrial).Xaxe; %player1 controls Xaxis --> note contribution on Xaxis for P1
            contribPlayer(itrial).P2 = Contrib(itrial).Yaxe; %player2 controls Yaxis --> note contribution on Yaxis for P2
        elseif trials.effectiveControl(itrial) == 1 
            contribPlayer(itrial).P1 = Contrib(itrial).Yaxe;
            contribPlayer(itrial).P2 = Contrib(itrial).Xaxe;
        end 
    end
    
    DecisionConflict = [];
    
    for itrial=1:NumberOfTrials
        
        if results.Answer_ChoiceS1(itrial) == results.Answer_ChoiceS2(itrial)
            DecisionConflict(itrial) = 0;
        elseif results.Answer_ChoiceS1(itrial) ~= results.Answer_ChoiceS2(itrial)
            DecisionConflict(itrial) = 1;
        end 
    end
    
    Gains = [];
    GainsDif = [];
    
    for itrial=1:NumberOfTrials
                
            Gains(itrial).P1 = results.CagnotteP1(itrial); %player1 gains
            Gains(itrial).P2 = results.CagnotteP2(itrial); %player2 gains
            
            if Gains(itrial).P1 == Gains(itrial).P2 
                GainsDif(itrial).P1 = 0;
                GainsDif(itrial).P2 = 0;
            elseif Gains(itrial).P1 > Gains(itrial).P2 
                GainsDif(itrial).P1 = 1;
                GainsDif(itrial).P2 = -1;
            elseif Gains(itrial).P1 < Gains(itrial).P2 
                GainsDif(itrial).P1 = -1;
                GainsDif(itrial).P2 = 1;
            end 
    
     end
    
    
    ContribPlayer = [contribPlayer.P1; contribPlayer.P2]'; 
    gains = [Gains.P1; Gains.P2]';
    gainsDif = [GainsDif.P1; GainsDif.P2]';
%     Pivo = [pivo.P1; pivo.P2]';
%     RewardValue = [rewardValue.P1; rewardValue.P2]';
    MeancontribP1 = mean(ContribPlayer(:,1));
    MeancontribP2 = mean(ContribPlayer(:, 2));
    Answer_ChoiceS1 = [results.Answer_ChoiceS1]';
    Answer_ChoiceS2 = [results.Answer_ChoiceS2]';
    DecisionConflict = [DecisionConflict]';
    s = repmat(subject, [288, 1]);
    t = repmat(team, [288, 1]);
    nbtrials = [1:288]';
    player = 1;
    
    p = repmat(player, [288, 1]);
    rawdata_P1 = [s, t, p, nbtrials, ResultSuccess, trials.fluency, trials.matrix, ContribPlayer(:, 1), Answer_ChoiceS1, DecisionConflict, gains(:, 1), gainsDif(:, 1), ResultsQ1_player1, ResultsQ2_player1, ResultsTR];
%     csvwrite('rawdata1.dat', rawdata_P1);
    %save(output, 'rawdata1.dat')
    
    subject = subject + 1;
    player = player + 1;
    s = repmat(subject, [288, 1]);
    p = repmat(player, [288, 1]);
    rawdata_P2 = [s, t, p, nbtrials, ResultSuccess, trials.fluency, trials.matrix, ContribPlayer(:, 2), Answer_ChoiceS2, DecisionConflict, gains(:, 2), gainsDif(:, 2), ResultsQ1_player2, ResultsQ2_player2, ResultsTR];
%    csvwrite('rawdata2.dat', rawdata_P2);
    %save(output, 'rawdata2.dat')
    
    rawdata_P1P2 = [rawdata_P1; rawdata_P2];
    
    if ipar == 1
    nlines1 = 1
    nlines2 = 576 % number of trials = 288 * 2 (2players)--> 576
    elseif ipar > 1
    nlines1 = 577*(ipar - 1) ; % first written line of following subjects --> 576 + 1
    nlines2 = (nlines1 - 1) + 576;
    end
% Q1,Q2,RT    
    Rawdata_P1P2(nlines1:nlines2, :) = rawdata_P1P2;
    
    subject = subject + 1;
    team = team +1;
    
end

csvwrite('rawdata_WP2a1_bis.dat', Rawdata_P1P2);
%     % VERIFICATION OF OPERATIONNALISATION OF PIVOTALITY (small x or y axis)
%     
%     NumPivo_normal = 0;
%     SumPivo_normalX = 0;
%     SumPivo_normalY = 0;
%     NumPivo_lowX = 0;
%     SumPivo_lowX = 0;
%     SumPivo_highY = 0;
%     NumPivo_lowY = 0;
%     SumPivo_lowY = 0;
%     SumPivo_highX = 0;
%     
%     for itrial = 1:NumberOfTrials
%         if trials.contrib(itrial) == 1 && trials.kind(itrial) == 1 && ResultSuccess(itrial) == 1
%             NumPivo_normal = NumPivo_normal + 1;
%             SumPivo_normalX = SumPivo_normalX + Contrib(itrial).Xaxe;
%             SumPivo_normalY = SumPivo_normalY + Contrib(itrial).Yaxe;
%         elseif trials.contrib(itrial) == 2 && trials.kind(itrial) == 1 && ResultSuccess(itrial) == 1
%             NumPivo_lowX = NumPivo_lowX + 1;
%             SumPivo_lowX = SumPivo_lowX + Contrib(itrial).Xaxe;
%             SumPivo_highY = SumPivo_highY + Contrib(itrial).Yaxe;  
%         elseif trials.contrib(itrial) == 3  && trials.kind(itrial) == 1 && ResultSuccess(itrial) == 1
%             NumPivo_lowY = NumPivo_lowY + 1;
%             SumPivo_lowY = SumPivo_lowY + Contrib(itrial).Yaxe;
%             SumPivo_highX = SumPivo_highX + Contrib(itrial).Xaxe;  
%         end 
%     end
%     
%     MeanPivo_normalX = SumPivo_normalX / NumPivo_normal;
%     MeanPivo_lowX = SumPivo_lowX / NumPivo_lowX; % mean of motor contribution on Xaxis (whoever the player is) when Xaxis is small so it must be < 0,5
%     MeanPivo_lowY = SumPivo_lowY / NumPivo_lowY; % mean of motor contrib on Yaxis when yaxis is small so it must be <0,5
%     
