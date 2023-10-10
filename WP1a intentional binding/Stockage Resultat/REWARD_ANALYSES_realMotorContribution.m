clearvars
close all
home
% participantsReward = ['DR'; 'ST'; 'CE'; 'FS'; 'AB'; 'MB'; 'MF'; 'CC';'LM'; 'CM'; 'BM2'; 'FA'; 'NM'; 'AK'; 'DB'; 'NB'; 'CB'; 'RS'; 'SR2'; 'IB'; 'BD2'; 'LH' ] full sample IN RIGHT ORDER
participantsReward = ['DR'; 'ST'; 'CE'; 'FS'; 'AB'; 'MB'; 'MF'; 'CC'; 'LM'; 'CM'; 'BM'; 'FA'; 'NM'; 'AK'; 'DB'; 'NB'; 'CB'; 'RS'; 'SR'; 'IB'; 'BD'; 'LH'] % TL & CO & EB removed
DataFolder = '';
OutputData = [DataFolder 'Reward_physio.mat'];



for ipar = 1:length(participantsReward)
    part = participantsReward(ipar, :);
    part2Open = ['Binding' part '.mat'] % naming behavioural data
    partOpen = [part '.mat'] % naming physio data
    load(partOpen)
    dataPhy = data; % avoiding physio 'data' to be erased by behav 'data' (same name)
    load(part2Open)
    
%%%%%%%%%%%%%%%% ANALYSES COMPORTEMENTALES %%%%%%%%%%%%%%%%%%%%%

    NumberOfTrials = 96;
    ntrials = 96;


    results.TimeR = results.Time; % remaining time
    results.TimeR(results.TimeR<0)=0;
    
    ResultSuccess = results.Success';
    ResultsTR = 8 - results.TimeR; % response time
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
      if ResultSuccess(itrial) == 1 && trials.kind(itrial) == 1 && trials.fluency(itrial) == 1 %&& trials.position(itrial) == 1
          subplot(1, 2, 1);
          hold on;
          plot(data(itrial).Xaxe, data(itrial).Yaxe)
          hold off;
          title(['High Fluency']);
          %title(['High Fluency' part]); % for all participants
      elseif ResultSuccess(itrial) == 1 && trials.kind(itrial) == 1  && trials.fluency(itrial) == 2 %&& trials.position(itrial) == 1
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
    
    ContribPlayer = [contribPlayer.P1; contribPlayer.P2]'; 
    MeancontribP1 = mean(ContribPlayer(:,1));
    MeancontribP2 = mean(ContribPlayer(:, 2));
    
    
    % VERIFICATION OF OPERATIONNALISATION OF PIVOTALITY (small x or y axis)
    
    NumPivo_normal = 0;
    SumPivo_normalX = 0;
    SumPivo_normalY = 0;
    NumPivo_lowX = 0;
    SumPivo_lowX = 0;
    SumPivo_highY = 0;
    NumPivo_lowY = 0;
    SumPivo_lowY = 0;
    SumPivo_highX = 0;
    
    for itrial = 1:NumberOfTrials
        if trials.contrib(itrial) == 1 && trials.kind(itrial) == 1 && ResultSuccess(itrial) == 1
            NumPivo_normal = NumPivo_normal + 1;
            SumPivo_normalX = SumPivo_normalX + Contrib(itrial).Xaxe;
            SumPivo_normalY = SumPivo_normalY + Contrib(itrial).Yaxe;
        elseif trials.contrib(itrial) == 2 && trials.kind(itrial) == 1 && ResultSuccess(itrial) == 1
            NumPivo_lowX = NumPivo_lowX + 1;
            SumPivo_lowX = SumPivo_lowX + Contrib(itrial).Xaxe;
            SumPivo_highY = SumPivo_highY + Contrib(itrial).Yaxe;  
        elseif trials.contrib(itrial) == 3  && trials.kind(itrial) == 1 && ResultSuccess(itrial) == 1
            NumPivo_lowY = NumPivo_lowY + 1;
            SumPivo_lowY = SumPivo_lowY + Contrib(itrial).Yaxe;
            SumPivo_highX = SumPivo_highX + Contrib(itrial).Xaxe;  
        end 
    end
    
    MeanPivo_normalX = SumPivo_normalX / NumPivo_normal;
    MeanPivo_lowX = SumPivo_lowX / NumPivo_lowX; % mean of motor contribution on Xaxis (whoever the player is) when Xaxis is small so it must be < 0,5
    MeanPivo_lowY = SumPivo_lowY / NumPivo_lowY; % mean of motor contrib on Yaxis when yaxis is small so it must be <0,5
    
    %%%%%% MAIN FACTORS ANALYSES %%%%%%%%%
    
   % operationnalized pivotality -> perceived /represented pivotality
   % according to the visualization of the target's location
    NumOfTrials_EqualContrib = 0;
    SumPerf_EqualContrib = 0;
    SumQ1P1_EqualContrib = 0;
    SumQ2P1_EqualContrib = 0;
    SumQ1P2_EqualContrib = 0;
    SumQ2P2_EqualContrib = 0;
    SumTR_EqualContrib = 0;
    
    NumOfTrials_LowXContrib = 0;
    SumPerf_LowXContrib = 0;
    SumQ1P1_LowXContrib = 0;
    SumQ2P1_LowXContrib = 0;
    SumQ1P2_LowXContrib = 0;
    SumQ2P2_LowXContrib = 0;
    SumTR_LowXContrib = 0;
    
    NumOfTrials_LowYContrib = 0;
    SumPerf_LowYContrib = 0;
    SumQ1P1_LowYContrib = 0;
    SumQ2P1_LowYContrib = 0;
    SumQ1P2_LowYContrib = 0;
    SumQ2P2_LowYContrib = 0;
    SumTR_LowYContrib = 0;
   
   for itrial=1:NumberOfTrials
       
       if trials.contrib(itrial) == 1  & trials.kind(itrial) == 1 & trials.effectiveControl(itrial) == 0 % x and y are equivalent
           
           NumOfTrials_EqualContrib = NumOfTrials_EqualContrib + 1;

            if ResultSuccess(itrial) == 1 
                SumPerf_EqualContrib = SumPerf_EqualContrib + 1;
                SumQ1P1_EqualContrib = SumQ1P1_EqualContrib + ResultsQ1_player1(itrial);
                SumQ2P1_EqualContrib = SumQ2P1_EqualContrib + ResultsQ2_player1(itrial);
                SumQ1P2_EqualContrib = SumQ1P2_EqualContrib + ResultsQ1_player2(itrial);
                SumQ2P2_EqualContrib = SumQ2P2_EqualContrib + ResultsQ2_player2(itrial);
                SumTR_EqualContrib = SumTR_EqualContrib + ResultsTR(itrial);
            end
            
        elseif trials.contrib(itrial) == 2 & trials.kind(itrial) == 1 % low x and high y 
            
           NumOfTrials_LowXContrib = NumOfTrials_LowXContrib + 1;

            if ResultSuccess(itrial) == 1 
                SumPerf_LowXContrib = SumPerf_LowXContrib + 1;
                SumQ1P1_LowXContrib = SumQ1P1_LowXContrib + ResultsQ1_player1(itrial);
                SumQ2P1_LowXContrib = SumQ2P1_LowXContrib + ResultsQ2_player1(itrial);
                SumQ1P2_LowXContrib = SumQ1P2_LowXContrib + ResultsQ1_player2(itrial);
                SumQ2P2_LowXContrib = SumQ2P2_LowXContrib + ResultsQ2_player2(itrial);
                SumTR_LowXContrib = SumTR_LowXContrib + ResultsTR(itrial);
            end 
            
        elseif trials.contrib(itrial) == 3 & trials.kind(itrial) == 1 % low y and tall x
            
           NumOfTrials_LowYContrib = NumOfTrials_LowYContrib + 1;

            if ResultSuccess(itrial) == 1 
                SumPerf_LowYContrib = SumPerf_LowYContrib + 1;
                SumQ1P1_LowYContrib = SumQ1P1_LowYContrib + ResultsQ1_player1(itrial);
                SumQ2P1_LowYContrib = SumQ2P1_LowYContrib + ResultsQ2_player1(itrial);
                SumQ1P2_LowYContrib = SumQ1P2_LowYContrib + ResultsQ1_player2(itrial);
                SumQ2P2_LowYContrib = SumQ2P2_LowYContrib + ResultsQ2_player2(itrial);
                
                SumTR_LowYContrib = SumTR_LowYContrib + ResultsTR(itrial);
            end
           
       end 
   end 
   
    MeanQ1P1_EqualContrib = SumQ1P1_EqualContrib / SumPerf_EqualContrib; 
    MeanQ2P1_EqualContrib = SumQ2P1_EqualContrib / SumPerf_EqualContrib;
    MeanQ1P2_EqualContrib = SumQ1P2_EqualContrib / SumPerf_EqualContrib ;
    MeanQ2P2_EqualContrib = SumQ2P2_EqualContrib / SumPerf_EqualContrib;
    MeanPerf_EqualContrib = SumPerf_EqualContrib / NumOfTrials_EqualContrib;
    MeanTR_EqualContrib = SumTR_EqualContrib / SumPerf_EqualContrib;
    
    MeanQ1P1_LowXContrib = SumQ1P1_LowXContrib / SumPerf_LowXContrib ;
    MeanQ2P1_LowXContrib = SumQ2P1_LowXContrib / SumPerf_LowXContrib;
    MeanQ1P2_LowXContrib = SumQ1P2_LowXContrib / SumPerf_LowXContrib ;
    MeanQ2P2_LowXContrib = SumQ2P2_LowXContrib / SumPerf_LowXContrib;
    MeanPerf_LowXContrib = SumPerf_LowXContrib / NumOfTrials_LowXContrib;
    MeanTR_LowXContrib = SumTR_LowXContrib / SumPerf_LowXContrib;
    
    MeanQ1P1_LowYContrib = SumQ1P1_LowYContrib / SumPerf_LowYContrib ;
    MeanQ2P1_LowYContrib = SumQ2P1_LowYContrib / SumPerf_LowYContrib;
    MeanQ1P2_LowYContrib = SumQ1P2_LowYContrib / SumPerf_LowYContrib ;
    MeanQ2P2_LowYContrib = SumQ2P2_LowYContrib / SumPerf_LowYContrib;
    MeanPerf_LowYContrib = SumPerf_LowYContrib / NumOfTrials_LowYContrib;
    MeanTR_LowYContrib = SumTR_LowYContrib / SumPerf_LowYContrib;
    
   perceived_pivo_data1 = [MeanQ1P1_EqualContrib; MeanQ1P1_LowXContrib;  MeanQ1P1_LowYContrib; MeanQ2P1_EqualContrib; MeanQ2P1_LowXContrib; MeanQ2P1_LowYContrib];
   perceived_pivo_data2 = [MeanQ1P2_EqualContrib;  MeanQ1P2_LowXContrib; MeanQ1P2_LowYContrib; MeanQ2P2_EqualContrib; MeanQ2P2_LowXContrib; MeanQ2P2_LowYContrib ];
   
   Perceived_pivo_data1(ipar, :) = [perceived_pivo_data1]';
   Perceived_pivo_data2(ipar, :) = [perceived_pivo_data2]';
   
  
   % real pivotality : Real motor contribution --> experienced pivotality
   
       NumOfTrials_P1HighContrib = 0;
       SumQ1P1_HighContrib = 0;
       SumQ2P1_HighContrib = 0;
       NumOfTrials_P1LowContrib = 0;
       SumQ1P1_LowContrib = 0;
       SumQ2P1_LowContrib = 0;
       NumOfTrials_P1SameContrib = 0;
       SumQ1P1_SameContrib = 0;
       SumQ2P1_SameContrib = 0;
       NumOfTrials_P2HighContrib = 0;
       SumQ1P2_HighContrib = 0;
       SumQ2P2_HighContrib = 0;
       NumOfTrials_P2LowContrib = 0;
       SumQ1P2_LowContrib = 0;
       SumQ2P2_LowContrib = 0;
       NumOfTrials_P2SameContrib = 0;
       SumQ1P2_SameContrib = 0;
       SumQ2P2_SameContrib = 0;
   
   for itrial=1:NumberOfTrials
       
       if contribPlayer(itrial).P1 >= 0.55  & trials.kind(itrial) == 1 & ResultSuccess(itrial) == 1 % Player1 contributed to more than 60% to the succeed trial = High contrib
       
            NumOfTrials_P1HighContrib = NumOfTrials_P1HighContrib + 1;
            SumQ1P1_HighContrib = SumQ1P1_HighContrib + ResultsQ1_player1(itrial);
            SumQ2P1_HighContrib = SumQ2P1_HighContrib + ResultsQ2_player1(itrial);
             
       elseif contribPlayer(itrial).P1 < 0.45  &  trials.kind(itrial) == 1 & ResultSuccess(itrial) == 1 %   Player1 contributed to less than 40% to the succeed trial = low contrib
       
            NumOfTrials_P1LowContrib = NumOfTrials_P1LowContrib + 1;
            SumQ1P1_LowContrib = SumQ1P1_LowContrib + ResultsQ1_player1(itrial);
            SumQ2P1_LowContrib = SumQ2P1_LowContrib + ResultsQ2_player1(itrial);
       
       elseif contribPlayer(itrial).P1 >= 0.45 & contribPlayer(itrial).P1 <= 0.55 & ResultSuccess(itrial) == 1 % equal contrib
            
            NumOfTrials_P1SameContrib = NumOfTrials_P1SameContrib + 1;
            SumQ1P1_SameContrib = SumQ1P1_SameContrib + ResultsQ1_player1(itrial);
            SumQ2P1_SameContrib = SumQ2P1_SameContrib + ResultsQ2_player1(itrial); 
       end 
       
       if contribPlayer(itrial).P2 >= 0.55 & trials.kind(itrial) == 1 & ResultSuccess(itrial) == 1 % Player2 contributed to more than 60% to the succeed trial = High contrib
       
            NumOfTrials_P2HighContrib = NumOfTrials_P2HighContrib + 1;
            SumQ1P2_HighContrib = SumQ1P2_HighContrib + ResultsQ1_player2(itrial);
            SumQ2P2_HighContrib = SumQ2P2_HighContrib + ResultsQ2_player2(itrial);
             
       elseif contribPlayer(itrial).P2 < 0.45  &  trials.kind(itrial) == 1 & ResultSuccess(itrial) == 1 %   player2 contributed to less than 40% to the succeed trial = low contrib
       
            NumOfTrials_P2LowContrib = NumOfTrials_P2LowContrib + 1;
            SumQ1P2_LowContrib = SumQ1P2_LowContrib + ResultsQ1_player2(itrial);
            SumQ2P2_LowContrib = SumQ2P2_LowContrib + ResultsQ2_player2(itrial);
       
       elseif contribPlayer(itrial).P2 >= 0.45 & contribPlayer(itrial).P2 <= 0.55 & ResultSuccess(itrial) == 1 % equal contrib
            
            NumOfTrials_P2SameContrib = NumOfTrials_P2SameContrib + 1;
            SumQ1P2_SameContrib = SumQ1P2_SameContrib + ResultsQ1_player2(itrial);
            SumQ2P2_SameContrib = SumQ2P2_SameContrib + ResultsQ2_player2(itrial); 
       end    
       
   end    
   
   MeanQ1P1_HighContrib = SumQ1P1_HighContrib / NumOfTrials_P1HighContrib; 
   MeanQ2P1_HighContrib = SumQ2P1_HighContrib / NumOfTrials_P1HighContrib;
   MeanQ1P1_LowContrib = SumQ1P1_LowContrib / NumOfTrials_P1LowContrib; 
   MeanQ2P1_LowContrib = SumQ2P1_LowContrib / NumOfTrials_P1LowContrib;
   MeanQ1P1_SameContrib = SumQ1P1_SameContrib / NumOfTrials_P1SameContrib; 
   MeanQ2P1_SameContrib = SumQ2P1_SameContrib / NumOfTrials_P1SameContrib;
   
   MeanQ1P2_HighContrib = SumQ1P2_HighContrib / NumOfTrials_P2HighContrib; 
   MeanQ2P2_HighContrib = SumQ2P2_HighContrib / NumOfTrials_P2HighContrib;
   MeanQ1P2_LowContrib = SumQ1P2_LowContrib / NumOfTrials_P2LowContrib; 
   MeanQ2P2_LowContrib = SumQ2P2_LowContrib / NumOfTrials_P2LowContrib;
   MeanQ1P2_SameContrib = SumQ1P2_SameContrib / NumOfTrials_P2SameContrib; 
   MeanQ2P2_SameContrib = SumQ2P2_SameContrib / NumOfTrials_P2SameContrib;
       
    pivotality_data1 = [MeanQ1P1_HighContrib; MeanQ1P1_LowContrib; MeanQ1P1_SameContrib;  MeanQ2P1_HighContrib; MeanQ2P1_LowContrib; MeanQ2P1_SameContrib]; 
    pivotality_data2 = [MeanQ1P2_HighContrib; MeanQ1P2_LowContrib; MeanQ1P2_SameContrib;  MeanQ2P2_HighContrib; MeanQ2P2_LowContrib; MeanQ2P2_SameContrib]; 
    
    Pivotality_data1(ipar, :) =  [pivotality_data1]';
    Pivotality_data2(ipar, :) =  [pivotality_data2]';
    %Pivotality_data(ipar, :) = [Pivotality_data1(ipar, :); Pivotality_data2(ipar, :)];
    
   % fluency
   
    NumOfTrials_Easy = 0;
    SumQ1P1_Easy = 0;
    SumQ2P1_Easy = 0;
    SumQ1P2_Easy = 0;
    SumQ2P2_Easy = 0;
    SumPerf_Easy = 0;
    SumTR_Easy = 0;
    
    NumOfTrials_Hard = 0;
    SumQ1P1_Hard = 0;
    SumQ2P1_Hard = 0;
    SumQ1P2_Hard = 0;
    SumQ2P2_Hard = 0;
    SumPerf_Hard = 0;
    SumTR_Hard = 0;    
    
    NumOfTrials_B1 = 0; % for block1
    SumQ1P1_B1 = 0;
    SumQ2P1_B1 = 0;
    SumQ1P2_B1 = 0;
    SumQ2P2_B1 = 0;
    SumPerf_B1 = 0;
    SumTR_B1 = 0;
    
    NumOfTrials_B2 = 0; % for block2...
    SumQ1P1_B2 = 0;
    SumQ2P1_B2 = 0;
    SumQ1P2_B2 = 0;
    SumQ2P2_B2 = 0;
    SumPerf_B2 = 0;
    SumTR_B2 = 0;
    
    NumOfTrials_B3 = 0;
    SumQ1P1_B3 = 0;
    SumQ2P1_B3 = 0;
    SumQ1P2_B3 = 0;
    SumQ2P2_B3 = 0;
    SumPerf_B3 = 0;
    SumTR_B3 = 0;
    
    NumOfTrials_B4 = 0;
    SumQ1P1_B4 = 0;
    SumQ2P1_B4 = 0;
    SumQ1P2_B4 = 0;
    SumQ2P2_B4 = 0;
    SumPerf_B4 = 0;
    SumTR_B4 = 0;
    
    NumOfTrials_B5 = 0;
    SumQ1P1_B5 = 0;
    SumQ2P1_B5 = 0;
    SumQ1P2_B5 = 0;
    SumQ2P2_B5 = 0;
    SumPerf_B5 = 0;
    SumTR_B5 = 0;
    
    NumOfTrials_B6 = 0;
    SumQ1P1_B6 = 0;
    SumQ2P1_B6 = 0;
    SumQ1P2_B6 = 0;
    SumQ2P2_B6 = 0;
    SumPerf_B6 = 0;
    SumTR_B6 = 0;

   
    
    
     for itrial=1:NumberOfTrials

        if trials.fluency(itrial) ==  1 & trials.kind(itrial) == 1 % condition  high fluency(easy) and regular trials (kind ==1)

            NumOfTrials_Easy = NumOfTrials_Easy + 1;

            if ResultSuccess(itrial) == 1 
                SumPerf_Easy = SumPerf_Easy + 1;
                SumQ1P1_Easy = SumQ1P1_Easy + ResultsQ1_player1(itrial);
                SumQ2P1_Easy = SumQ2P1_Easy + ResultsQ2_player1(itrial);
                SumQ1P2_Easy = SumQ1P2_Easy + ResultsQ1_player2(itrial);
                SumQ2P2_Easy = SumQ2P2_Easy + ResultsQ2_player2(itrial);
                SumTR_Easy = SumTR_Easy + ResultsTR(itrial);
            end

        elseif trials.fluency(itrial) ==  2 & trials.kind(itrial) == 1 % condition low fluency(hard)
            
            NumOfTrials_Hard = NumOfTrials_Hard + 1;

            if ResultSuccess(itrial) == 1 
                SumPerf_Hard = SumPerf_Hard + 1;
                SumQ1P1_Hard = SumQ1P1_Hard + ResultsQ1_player1(itrial);
                SumQ2P1_Hard = SumQ2P1_Hard + ResultsQ2_player1(itrial);
                SumQ1P2_Hard = SumQ1P2_Hard + ResultsQ1_player2(itrial);
                SumQ2P2_Hard = SumQ2P2_Hard + ResultsQ2_player2(itrial);
                SumTR_Hard = SumTR_Hard + ResultsTR(itrial);
            end
        end
        
        if trialtriggers(itrial).nbloc ==  1 & trials.kind(itrial) == 1 % bloc1 && regular trial
            
            NumOfTrials_B1 = NumOfTrials_B1 + 1;

            if ResultSuccess(itrial) == 1 
                SumPerf_B1 = SumPerf_B1 + 1;
                SumQ1P1_B1 = SumQ1P1_B1 + ResultsQ1_player1(itrial);
                SumQ2P1_B1 = SumQ2P1_B1 + ResultsQ2_player1(itrial);
                SumQ1P2_B1 = SumQ1P2_B1 + ResultsQ1_player2(itrial);
                SumQ2P2_B1 = SumQ2P2_B1 + ResultsQ2_player2(itrial);
                SumTR_B1 = SumTR_B1 + ResultsTR(itrial);
            end
            
        elseif trialtriggers(itrial).nbloc ==  2 & trials.kind(itrial) == 1 % bloc2
            
            NumOfTrials_B2 = NumOfTrials_B2 + 1;

            if ResultSuccess(itrial) == 1 
                SumPerf_B2 = SumPerf_B2 + 1;
                SumQ1P1_B2 = SumQ1P1_B2 + ResultsQ1_player1(itrial);
                SumQ2P1_B2 = SumQ2P1_B2 + ResultsQ2_player1(itrial);
                SumQ1P2_B2 = SumQ1P2_B2 + ResultsQ1_player2(itrial);
                SumQ2P2_B2 = SumQ2P2_B2 + ResultsQ2_player2(itrial);
                SumTR_B2 = SumTR_B2 + ResultsTR(itrial);
            end 
            
        elseif trialtriggers(itrial).nbloc ==  3 & trials.kind(itrial) == 1 % bloc3
            
            NumOfTrials_B3 = NumOfTrials_B3 + 1;

            if ResultSuccess(itrial) == 1 
                SumPerf_B3 = SumPerf_B3 + 1;
                SumQ1P1_B3 = SumQ1P1_B3 + ResultsQ1_player1(itrial);
                SumQ2P1_B3 = SumQ2P1_B3 + ResultsQ2_player1(itrial);
                SumQ1P2_B3 = SumQ1P2_B3 + ResultsQ1_player2(itrial);
                SumQ2P2_B3 = SumQ2P2_B3 + ResultsQ2_player2(itrial);
                SumTR_B3 = SumTR_B3 + ResultsTR(itrial);
            end
            
        elseif trialtriggers(itrial).nbloc ==  4 & trials.kind(itrial) == 1 % bloc1
          
            NumOfTrials_B4 = NumOfTrials_B4 + 1;

            if ResultSuccess(itrial) == 1 
                SumPerf_B4 = SumPerf_B4 + 1;
                SumQ1P1_B4 = SumQ1P1_B4 + ResultsQ1_player1(itrial);
                SumQ2P1_B4 = SumQ2P1_B4 + ResultsQ2_player1(itrial);
                SumQ1P2_B4 = SumQ1P2_B4 + ResultsQ1_player2(itrial);
                SumQ2P2_B4 = SumQ2P2_B4 + ResultsQ2_player2(itrial);
                SumTR_B4 = SumTR_B4 + ResultsTR(itrial);
            end
            
       elseif trialtriggers(itrial).nbloc ==  5 & trials.kind(itrial) == 1 % bloc1
            
            NumOfTrials_B5 = NumOfTrials_B5 + 1;

            if ResultSuccess(itrial) == 1 
                SumPerf_B5 = SumPerf_B5 + 1;
                SumQ1P1_B5 = SumQ1P1_B5 + ResultsQ1_player1(itrial);
                SumQ2P1_B5 = SumQ2P1_B5 + ResultsQ2_player1(itrial);
                SumQ1P2_B5 = SumQ1P2_B5 + ResultsQ1_player2(itrial);
                SumQ2P2_B5 = SumQ2P2_B5 + ResultsQ2_player2(itrial);
                SumTR_B5 = SumTR_B5 + ResultsTR(itrial);
            end    
            
       elseif trialtriggers(itrial).nbloc ==  6 & trials.kind(itrial) == 1 % bloc1
            
            NumOfTrials_B6 = NumOfTrials_B6 + 1;

            if ResultSuccess(itrial) == 1 
                SumPerf_B6 = SumPerf_B6 + 1;
                SumQ1P1_B6 = SumQ1P1_B6 + ResultsQ1_player1(itrial);
                SumQ2P1_B6 = SumQ2P1_B6 + ResultsQ2_player1(itrial);
                SumQ1P2_B6 = SumQ1P2_B6 + ResultsQ1_player2(itrial);
                SumQ2P2_B6 = SumQ2P2_B6 + ResultsQ2_player2(itrial);
                SumTR_B6 = SumTR_B6 + ResultsTR(itrial);
            end
            
                
        end
        
        
     end 

    NumOfTrials_Easy 
    
    SumPerf_Easy 
    SumTR_Easy 
    MeanQ1P1_Easy = SumQ1P1_Easy / SumPerf_Easy 
    MeanQ2P1_Easy = SumQ2P1_Easy / SumPerf_Easy
    MeanQ1P2_Easy = SumQ1P2_Easy / SumPerf_Easy 
    MeanQ2P2_Easy = SumQ2P2_Easy / SumPerf_Easy
    MeanPerf_Easy = SumPerf_Easy / NumOfTrials_Easy
    MeanTR_Easy = SumTR_Easy / SumPerf_Easy
    
    NumOfTrials_Hard 
     
    SumPerf_Hard 
    SumTR_Hard 
    MeanQ1P1_Hard = SumQ1P1_Hard / SumPerf_Hard 
    MeanQ2P1_Hard = SumQ2P1_Hard / SumPerf_Hard
    MeanQ1P2_Hard = SumQ1P2_Hard / SumPerf_Hard 
    MeanQ2P2_Hard = SumQ2P2_Hard / SumPerf_Hard
    MeanPerf_Hard = SumPerf_Hard / NumOfTrials_Hard
    MeanTR_Hard = SumTR_Hard / SumPerf_Hard
    
    NumOfTrials_B1 
      
    SumPerf_B1 
    SumTR_B1 
    MeanQ1P1_B1 = SumQ1P1_B1 / SumPerf_B1 
    MeanQ2P1_B1 = SumQ2P1_B1 / SumPerf_B1
    MeanQ1P2_B1 = SumQ1P2_B1 / SumPerf_B1 
    MeanQ2P2_B1 = SumQ2P2_B1 / SumPerf_B1
    MeanPerf_B1 = SumPerf_B1 / NumOfTrials_B1
    MeanTR_B1 = SumTR_B1 / SumPerf_B1
    
    NumOfTrials_B2 
    
    SumPerf_B2 
    SumTR_B2 
    MeanQ1P1_B2 = SumQ1P1_B2 / SumPerf_B2 
    MeanQ2P1_B2 = SumQ2P1_B2 / SumPerf_B2
    MeanQ1P2_B2 = SumQ1P2_B2 / SumPerf_B2 
    MeanQ2P2_B2 = SumQ2P2_B2 / SumPerf_B2
    MeanPerf_B2 = SumPerf_B2 / NumOfTrials_B2
    MeanTR_B2 = SumTR_B2 / SumPerf_B2
    
    NumOfTrials_B3 
        
    SumPerf_B3 
    SumTR_B3 
    MeanQ1P1_B3 = SumQ1P1_B3 / SumPerf_B3 
    MeanQ2P1_B3 = SumQ2P1_B3 / SumPerf_B3
    MeanQ1P2_B3 = SumQ1P2_B3 / SumPerf_B3 
    MeanQ2P2_B3 = SumQ2P2_B3 / SumPerf_B3
    MeanPerf_B3 = SumPerf_B3 / NumOfTrials_B3
    MeanTR_B3 = SumTR_B3 / SumPerf_B3
    
    NumOfTrials_B4 
    
    SumPerf_B4 
    SumTR_B4 
    MeanQ1P1_B4 = SumQ1P1_B4 / SumPerf_B4 
    MeanQ2P1_B4 = SumQ2P1_B4 / SumPerf_B4
    MeanQ1P2_B4 = SumQ1P2_B4 / SumPerf_B4 
    MeanQ2P2_B4 = SumQ2P2_B4 / SumPerf_B4
    MeanPerf_B4 = SumPerf_B4 / NumOfTrials_B4
    MeanTR_B4 = SumTR_B4 / SumPerf_B4
    
    NumOfTrials_B5 
        
    SumPerf_B5 
    SumTR_B5 
    MeanQ1P1_B5 = SumQ1P1_B5 / SumPerf_B5 
    MeanQ2P1_B5 = SumQ2P1_B5 / SumPerf_B5
    MeanQ1P2_B5 = SumQ1P2_B5 / SumPerf_B5 
    MeanQ2P2_B5 = SumQ2P2_B5 / SumPerf_B5
    MeanPerf_B5 = SumPerf_B5 / NumOfTrials_B5
    MeanTR_B5 = SumTR_B5 / SumPerf_B5
    
    NumOfTrials_B6 
     
    SumPerf_B6 
    SumTR_B6 
    MeanQ1P1_B6 = SumQ1P1_B6 / SumPerf_B6 
    MeanQ2P1_B6 = SumQ2P1_B6 / SumPerf_B6
    MeanQ1P2_B6 = SumQ1P2_B6 / SumPerf_B6 
    MeanQ2P2_B6 = SumQ2P2_B6 / SumPerf_B6
    MeanPerf_B6 = SumPerf_B6 / NumOfTrials_B6
    MeanTR_B6 = SumTR_B6 / SumPerf_B6
       
%     DifQ1P1_ALL(ipar, :) = MeanQ1P1_Easy - MeanQ1P1_Hard;
%     DifQ1P2_ALL(ipar, :) = MeanQ1P2_Easy - MeanQ1P2_Hard;
%     DifQ2P1_ALL(ipar, :) = MeanQ2P1_Easy - MeanQ2P1_Hard;
%     DifQ2P12_ALL(ipar, :) = MeanQ2P2_Easy - MeanQ2P2_Hard;
%     DifPerf_ALL(ipar, :) = MeanPerf_Easy - MeanPerf_Hard;
    
    fluency_data1 = [MeanQ1P1_Easy; MeanQ1P1_Hard; MeanQ2P1_Easy; MeanQ2P1_Hard];
    fluency_data2 = [MeanQ1P2_Easy; MeanQ1P2_Hard; MeanQ2P2_Easy; MeanQ2P2_Hard];
    Fluency_data1(ipar, :) = [fluency_data1]';
    Fluency_data2(ipar, :) = [fluency_data2]';
    
    % behavioural data that are common to both players (RTs, perf, gains...)
   
    preliminary_behav_data(ipar, :) = [MeanPerf_Easy; MeanPerf_Hard; MeanTR_Easy; MeanTR_Hard; MeancontribP1; MeancontribP2; MeanPerf_EqualContrib; MeanPerf_LowXContrib; MeanPerf_LowYContrib; MeanTR_EqualContrib; MeanTR_LowXContrib; MeanTR_LowYContrib]'
   
    
    % REWARDS
    
    NumOfTrials_RewardShared = 0;
    SumQ1P1_RewardShared = 0;
    SumQ2P1_RewardShared = 0;
    SumQ1P2_RewardShared = 0;
    SumQ2P2_RewardShared = 0;
    
    NumOfTrials_RewardContriPos_P1 = 0; % is equal to number of negative reward based on motor contribution for player 2
    SumQ1P1_RewardContriPos = 0;
    SumQ2P1_RewardContriPos = 0;
    SumQ1P2_RewardContriNeg = 0;
    SumQ2P2_RewardContriNeg = 0;
    
    NumOfTrials_RewardContriPos_P2 = 0; % is equal to number of negative reward based on motor contribution for player 1
    SumQ1P2_RewardContriPos = 0;
    SumQ2P2_RewardContriPos = 0;
    SumQ1P1_RewardContriNeg = 0;
    SumQ2P1_RewardContriNeg = 0;
    
    NumOfTrials_RewardRandomPos_P1 = 0; % is equal to number of negative reward based on motor contribution for player 2
    SumQ1P1_RewardRandomPos = 0;
    SumQ2P1_RewardRandomPos = 0;
    SumQ1P2_RewardRandomNeg = 0;
    SumQ2P2_RewardRandomNeg = 0;
    
    NumOfTrials_RewardRandomPos_P2 = 0; % is equal to number of negative reward based on motor contribution for player 1
    SumQ1P2_RewardRandomPos = 0;
    SumQ2P2_RewardRandomPos = 0;
    SumQ1P1_RewardRandomNeg = 0;
    SumQ2P1_RewardRandomNeg = 0;
    
    
    for itrial=1:NumberOfTrials
       
       if trials.blocReward(itrial) == 1  & trials.kind(itrial) == 1 & ResultSuccess(itrial) == 1 %shared reward
            NumOfTrials_RewardShared = NumOfTrials_RewardShared + 1;
            SumQ1P1_RewardShared = SumQ1P1_RewardShared + ResultsQ1_player1(itrial);
            SumQ2P1_RewardShared = SumQ2P1_RewardShared + ResultsQ2_player1(itrial);
            SumQ1P2_RewardShared = SumQ1P2_RewardShared + ResultsQ1_player2(itrial);
            SumQ2P2_RewardShared = SumQ2P2_RewardShared + ResultsQ2_player2(itrial);
            
       elseif trials.blocReward(itrial) == 2  & trials.kind(itrial) == 1 & ResultSuccess(itrial) == 1 %reward based on motor contrib
           if contribPlayer(itrial).P1 >= 0.55 & contribPlayer(itrial).P2 <= 0.45 % highest reward for P1 --> positive for P1 negative for P2
                NumOfTrials_RewardContriPos_P1 = NumOfTrials_RewardContriPos_P1 + 1; 
                SumQ1P1_RewardContriPos = SumQ1P1_RewardContriPos + ResultsQ1_player1(itrial);
                SumQ2P1_RewardContriPos = SumQ2P1_RewardContriPos + ResultsQ2_player1(itrial);
                SumQ1P2_RewardContriNeg = SumQ1P2_RewardContriNeg + ResultsQ1_player2(itrial);
                SumQ2P2_RewardContriNeg = SumQ2P2_RewardContriNeg + ResultsQ2_player2(itrial);
           elseif  contribPlayer(itrial).P1 <= 0.45 & contribPlayer(itrial).P2 >= 0.55 % lowest reward for P2 --> negative for P1 and positive for P2   
                NumOfTrials_RewardContriPos_P2 = NumOfTrials_RewardContriPos_P2 + 1; 
                SumQ1P2_RewardContriPos = SumQ1P2_RewardContriPos + ResultsQ1_player2(itrial);
                SumQ2P2_RewardContriPos = SumQ2P2_RewardContriPos + ResultsQ2_player2(itrial);
                SumQ1P1_RewardContriNeg = SumQ1P1_RewardContriNeg + ResultsQ1_player1(itrial);
                SumQ2P1_RewardContriNeg = SumQ2P1_RewardContriNeg + ResultsQ2_player1(itrial);
           end
           
       elseif trials.blocReward(itrial) == 3  & trials.kind(itrial) == 1 & ResultSuccess(itrial) == 1 %random reward
           if trials.randomReward1(itrial) == 1 % positive random reward for P1 and negative random reawrd for P2
                NumOfTrials_RewardRandomPos_P1 = NumOfTrials_RewardRandomPos_P1 + 1;
                SumQ1P1_RewardRandomPos = SumQ1P1_RewardRandomPos + ResultsQ1_player1(itrial);
                SumQ2P1_RewardRandomPos = SumQ2P1_RewardRandomPos + ResultsQ2_player1(itrial);
                SumQ1P2_RewardRandomNeg = SumQ1P2_RewardRandomNeg + ResultsQ1_player2(itrial);
                SumQ2P2_RewardRandomNeg = SumQ2P2_RewardRandomNeg + ResultsQ2_player2(itrial);
           elseif trials.randomReward1(itrial) == 0 % negative random reward for P1 and positive random reward for p2 
                NumOfTrials_RewardRandomPos_P2 = NumOfTrials_RewardRandomPos_P2 + 1;
                SumQ1P2_RewardRandomPos = SumQ1P2_RewardRandomPos + ResultsQ1_player2(itrial);
                SumQ2P2_RewardRandomPos = SumQ2P2_RewardRandomPos + ResultsQ2_player2(itrial);
                SumQ1P1_RewardRandomNeg = SumQ1P1_RewardRandomNeg + ResultsQ1_player1(itrial);
                SumQ2P1_RewardRandomNeg = SumQ2P1_RewardRandomNeg + ResultsQ2_player1(itrial);
                
           end
  
       end 
    end 
    
    %NumOfTrials_RewardShared = NumOfTrials_RewardShared + 1;
    MeanQ1P1_RewardShared = SumQ1P1_RewardShared / NumOfTrials_RewardShared;
    MeanQ2P1_RewardShared = SumQ2P1_RewardShared / NumOfTrials_RewardShared;
    MeanQ1P2_RewardShared = SumQ1P2_RewardShared / NumOfTrials_RewardShared;
    MeanQ2P2_RewardShared = SumQ2P2_RewardShared / NumOfTrials_RewardShared;
    
    %NumOfTrials_RewardContriPos_P1 = NumOfTrials_RewardContriPos_P1 + 1; 
    MeanQ1P1_RewardContriPos = SumQ1P1_RewardContriPos / NumOfTrials_RewardContriPos_P1;
    MeanQ2P1_RewardContriPos = SumQ2P1_RewardContriPos / NumOfTrials_RewardContriPos_P1;
    MeanQ1P2_RewardContriNeg = SumQ1P2_RewardContriNeg / NumOfTrials_RewardContriPos_P1;
    MeanQ2P2_RewardContriNeg = SumQ2P2_RewardContriNeg / NumOfTrials_RewardContriPos_P1;
    
    %NumOfTrials_RewardContriPos_P2 = NumOfTrials_RewardContriPos_P2 + 1; 
    MeanQ1P2_RewardContriPos = SumQ1P2_RewardContriPos / NumOfTrials_RewardContriPos_P2;
    MeanQ2P2_RewardContriPos = SumQ2P2_RewardContriPos / NumOfTrials_RewardContriPos_P2;
    MeanQ1P1_RewardContriNeg = SumQ1P1_RewardContriNeg / NumOfTrials_RewardContriPos_P2;
    MeanQ2P1_RewardContriNeg = SumQ2P1_RewardContriNeg / NumOfTrials_RewardContriPos_P2;
    
    %NumOfTrials_RewardRandomPos_P1 = NumOfTrials_RewardRandomPos_P1 + 1;
    MeanQ1P1_RewardRandomPos = SumQ1P1_RewardRandomPos / NumOfTrials_RewardRandomPos_P1;
    MeanQ2P1_RewardRandomPos = SumQ2P1_RewardRandomPos / NumOfTrials_RewardRandomPos_P1;
    MeanQ1P2_RewardRandomNeg = SumQ1P2_RewardRandomNeg / NumOfTrials_RewardRandomPos_P1;
    MeanQ2P2_RewardRandomNeg = SumQ2P2_RewardRandomNeg / NumOfTrials_RewardRandomPos_P1;
    
    %NumOfTrials_RewardRandomPos_P2 = NumOfTrials_RewardRandomPos_P2 + 1;
    MeanQ1P2_RewardRandomPos = SumQ1P2_RewardRandomPos / NumOfTrials_RewardRandomPos_P2;
    MeanQ2P2_RewardRandomPos = SumQ2P2_RewardRandomPos / NumOfTrials_RewardRandomPos_P2;
    MeanQ1P1_RewardRandomNeg = SumQ1P1_RewardRandomNeg / NumOfTrials_RewardRandomPos_P2;
    MeanQ2P1_RewardRandomNeg = SumQ2P1_RewardRandomNeg / NumOfTrials_RewardRandomPos_P2;
    
    


reward_data1 = [MeanQ1P1_RewardShared; MeanQ2P1_RewardShared;  MeanQ1P1_RewardContriPos; MeanQ1P1_RewardContriNeg; MeanQ2P1_RewardContriPos; MeanQ2P1_RewardContriNeg; MeanQ1P1_RewardRandomPos; MeanQ1P1_RewardRandomNeg; MeanQ2P1_RewardRandomPos; MeanQ2P1_RewardRandomNeg]
reward_data2 =  [MeanQ1P2_RewardShared; MeanQ2P2_RewardShared;  MeanQ1P2_RewardContriPos; MeanQ1P2_RewardContriNeg; MeanQ2P2_RewardContriPos; MeanQ2P2_RewardContriNeg; MeanQ1P2_RewardRandomPos; MeanQ1P2_RewardRandomNeg; MeanQ2P2_RewardRandomPos; MeanQ2P2_RewardRandomNeg]
Reward_data1(ipar, :) = [reward_data1]';
Reward_data2(ipar, :) = [reward_data2]';

Main_effects_behav1(ipar, :) =  [fluency_data1; pivotality_data1; perceived_pivo_data1; reward_data1]'; 
Main_effects_behav2(ipar, :) = [fluency_data2; pivotality_data2; perceived_pivo_data2; reward_data2]'; 

% MeanQ1_blocs = [MeanQ1_B1; MeanQ1_B2; MeanQ1_B3; MeanQ1_B4; MeanQ1_B5; MeanQ1_B6; MeanQ1_B7; MeanQ1_B8];
% MeanQ2_blocs = [MeanQ2_B1; MeanQ2_B2; MeanQ2_B3; MeanQ2_B4; MeanQ2_B5; MeanQ2_B6; MeanQ2_B7; MeanQ2_B8];
% MeanPerf_blocs = [MeanPerf_B1; MeanPerf_B2; MeanPerf_B3; MeanPerf_B4; MeanPerf_B5; MeanPerf_B6; MeanPerf_B7; MeanPerf_B8];
 
   

%Data_global = [SumQ1_Easy;SumQ2_Easy;SumPerf_Easy;SumTR_Easy;MeanQ1_Easy;MeanQ2_Easy;MeanPerf_Easy;MeanTR_Easy;SumQ1_Hard;SumQ2_Hard;SumPerf_Hard;SumTR_Hard;MeanQ1_Hard;MeanQ2_Hard;MeanPerf_Hard;MeanTR_Hard]

% Data_B1_B2 = [SumQ1_B1;SumQ2_B1;SumPerf_B1;SumTR_B1;MeanQ1_B1;MeanQ2_B1;MeanPerf_B1;MeanTR_B1;SumQ1_B2;SumQ2_B2;SumPerf_B2;SumTR_B2;MeanQ1_B2;MeanQ2_B2;MeanPerf_B2;MeanTR_B2]
% Data_B3_B4 = [SumQ1_B3;SumQ2_B3;SumPerf_B3;SumTR_B3;MeanQ1_B3;MeanQ2_B3;MeanPerf_B3;MeanTR_B3;SumQ1_B4;SumQ2_B4;SumPerf_B4;SumTR_B4;MeanQ1_B4;MeanQ2_B4;MeanPerf_B4;MeanTR_B4]
% Data_B5_B6 = [SumQ1_B5;SumQ2_B5;SumPerf_B5;SumTR_B5;MeanQ1_B5;MeanQ2_B5;MeanPerf_B5;MeanTR_B5;SumQ1_B6;SumQ2_B6;SumPerf_B6;SumTR_B6;MeanQ1_B6;MeanQ2_B6;MeanPerf_B6;MeanTR_B6]
% Data_B7_B8 = [SumQ1_B7;SumQ2_B7;SumPerf_B7;SumTR_B7;MeanQ1_B7;MeanQ2_B7;MeanPerf_B7;MeanTR_B7;SumQ1_B8;SumQ2_B8;SumPerf_B8;SumTR_B8;MeanQ1_B8;MeanQ2_B8;MeanPerf_B8;MeanTR_B8]

%   Data_4targets_size1 = [SumQ1_Easy;SumQ2_Easy;SumPerf_Easy;SumTR_Easy;MeanQ1_Easy; MeanQ2_Easy; MeanPerf_Easy;MeanTR_Easy;SumQ1_Hard;SumQ2_Hard;SumPerf_Hard;SumTR_Hard;MeanQ1_Hard;MeanQ2_Hard;MeanPerf_Hard;MeanTR_Hard]
%   Data_4targets_size2 = [SumQ1_Easy;SumQ2_Easy;SumPerf_Easy;SumTR_Easy;MeanQ1_Easy; MeanQ2_Easy; MeanPerf_Easy;MeanTR_Easy;SumQ1_Hard;SumQ2_Hard;SumPerf_Hard;SumTR_Hard;MeanQ1_Hard;MeanQ2_Hard;MeanPerf_Hard;MeanTR_Hard]
%   
%   Data_all(ipar, :) = [Data_global;Data_B1_B2; Data_B3_B4;Data_B5_B6;Data_B7_B8; MeanQ1_blocs; MeanQ2_blocs; MeanPerf_blocs; R_Q1_Q2(1,2); P_Q1_Q2(1,2)]
%   Data_all(ipar, :) = Data_all(ipar, :)'

%% DOUBLE INTERACTIONS & TRIPLE INTERACTIONS

NumOfTrials_Easy_HighContrib_P1 = 0;
SumQ1P1_Easy_HighContrib = 0;
SumQ2P1_Easy_HighContrib = 0;
SumQ1P2_Easy_LowContrib = 0;
SumQ2P2_Easy_LowContrib = 0;

    NumOfTrials_Easy_HighContrib_RewardShared_P1 = 0;
    SumQ1P1_Easy_HighContrib_RewardShared = 0;
    SumQ2P1_Easy_HighContrib_RewardShared = 0;
    SumQ1P2_Easy_LowContrib_RewardShared = 0;
    SumQ2P2_Easy_LowContrib_RewardShared = 0; 

    NumOfTrials_Easy_HighContrib_RewardContriPos_P1 = 0;
    SumQ1P1_Easy_HighContrib_RewardContriPos = 0;
    SumQ2P1_Easy_HighContrib_RewardContriPos = 0;
    SumQ1P2_Easy_LowContrib_RewardContriNeg = 0;
    SumQ2P2_Easy_LowContrib_RewardContriNeg = 0;
    
    NumOfTrials_Easy_HighContrib_RewardRandom_P1 = 0;
    SumQ1P1_Easy_HighContrib_RewardRandom = 0;
    SumQ2P1_Easy_HighContrib_RewardRandom= 0;
    SumQ1P2_Easy_LowContrib_RewardRandom = 0;
    SumQ2P2_Easy_LowContrib_RewardRandom = 0;

    NumOfTrials_Easy_HighContrib_RewardRandomNeg_P1 = 0;
    SumQ1P1_Easy_HighContrib_RewardRandomNeg = 0;
    SumQ2P1_Easy_HighContrib_RewardRandomNeg = 0;
    SumQ1P2_Easy_LowContrib_RewardRandomPos = 0;
    SumQ2P2_Easy_LowContrib_RewardRandomPos = 0;

    NumOfTrials_Easy_HighContrib_RewardRandomPos_P1 = 0;
    SumQ1P1_Easy_HighContrib_RewardRandomPos = 0;
    SumQ2P1_Easy_HighContrib_RewardRandomPos = 0;
    SumQ1P2_Easy_LowContrib_RewardRandomNeg = 0;
    SumQ2P2_Easy_LowContrib_RewardRandomNeg = 0;

NumOfTrials_Easy_HighContrib_P2 = 0;
SumQ1P2_Easy_HighContrib = 0;
SumQ2P2_Easy_HighContrib = 0;
SumQ1P1_Easy_LowContrib = 0;
SumQ2P1_Easy_LowContrib = 0;


    NumOfTrials_Easy_HighContrib_RewardShared_P2 = 0;
    SumQ1P2_Easy_HighContrib_RewardShared = 0;
    SumQ2P2_Easy_HighContrib_RewardShared = 0;
    SumQ1P1_Easy_LowContrib_RewardShared = 0;
    SumQ2P1_Easy_LowContrib_RewardShared = 0;                    
                
    NumOfTrials_Easy_HighContrib_RewardContriPos_P2 = 0;
    SumQ1P2_Easy_HighContrib_RewardContriPos = 0;
    SumQ2P2_Easy_HighContrib_RewardContriPos = 0;
    SumQ1P1_Easy_LowContrib_RewardContriNeg = 0;
    SumQ2P1_Easy_LowContrib_RewardContriNeg = 0;
    
    NumOfTrials_Easy_HighContrib_RewardRandom_P2 = 0;
    SumQ1P2_Easy_HighContrib_RewardRandom = 0;
    SumQ2P2_Easy_HighContrib_RewardRandom = 0;
    SumQ1P1_Easy_LowContrib_RewardRandom = 0;
    SumQ2P1_Easy_LowContrib_RewardRandom = 0;
                
    NumOfTrials_Easy_HighContrib_RewardRandomNeg_P2 = 0;
    SumQ1P2_Easy_HighContrib_RewardRandomNeg = 0;
    SumQ2P2_Easy_HighContrib_RewardRandomNeg = 0;
    SumQ1P1_Easy_LowContrib_RewardRandomPos = 0;
    SumQ2P1_Easy_LowContrib_RewardRandomPos = 0;
                
    NumOfTrials_Easy_HighContrib_RewardRandomPos_P2 = 0;
    SumQ1P2_Easy_HighContrib_RewardRandomPos = 0;
    SumQ2P2_Easy_HighContrib_RewardRandomPos = 0;
    SumQ1P1_Easy_LowContrib_RewardRandomNeg = 0;
    SumQ2P1_Easy_LowContrib_RewardRandomNeg = 0;
    
NumOfTrials_Easy_SameContrib_P2 = 0;
SumQ1P2_Easy_SameContrib = 0;
SumQ2P2_Easy_SameContrib = 0;
SumQ1P1_Easy_SameContrib = 0;
SumQ2P1_Easy_SameContrib = 0;

    NumOfTrials_Easy_SameContrib_RewardShared_P1 = 0;
    SumQ1P1_Easy_SameContrib_RewardShared = 0;
    SumQ2P1_Easy_SameContrib_RewardShared = 0;
    SumQ1P2_Easy_SameContrib_RewardShared = 0;
    SumQ2P2_Easy_SameContrib_RewardShared = 0;                    
                
    NumOfTrials_Easy_SameContrib_RewardContri_P1 = 0;
    SumQ1P1_Easy_SameContrib_RewardContri = 0;
    SumQ2P1_Easy_SameContrib_RewardContri = 0;
    SumQ1P2_Easy_SameContrib_RewardContri = 0;
    SumQ2P2_Easy_SameContrib_RewardContri = 0;
    
    NumOfTrials_Easy_SameContrib_RewardRandom_P1 = 0;
    SumQ1P1_Easy_SameContrib_RewardRandom = 0;
    SumQ2P1_Easy_SameContrib_RewardRandom = 0;
    SumQ1P2_Easy_SameContrib_RewardRandom = 0;
    SumQ2P2_Easy_SameContrib_RewardRandom = 0;

    NumOfTrials_Easy_SameContrib_RewardRandomNeg_P1 = 0;
    SumQ1P1_Easy_SameContrib_RewardRandomNeg = 0;
    SumQ2P1_Easy_SameContrib_RewardRandomNeg = 0;
    SumQ1P2_Easy_SameContrib_RewardRandomPos = 0;
    SumQ2P2_Easy_SameContrib_RewardRandomPos = 0;

    NumOfTrials_Easy_SameContrib_RewardRandomPos_P1 = 0;
    SumQ1P1_Easy_SameContrib_RewardRandomPos = 0;
    SumQ2P1_Easy_SameContrib_RewardRandomPos = 0;
    SumQ1P2_Easy_SameContrib_RewardRandomNeg = 0;
    SumQ2P2_Easy_SameContrib_RewardRandomNeg = 0;
    
NumOfTrials_Hard_HighContrib_P1 = 0;
SumQ1P1_Hard_HighContrib = 0;
SumQ2P1_Hard_HighContrib = 0;
SumQ1P2_Hard_LowContrib = 0;
SumQ2P2_Hard_LowContrib = 0;
                
    NumOfTrials_Hard_HighContrib_RewardShared_P1 = 0;
    SumQ1P1_Hard_HighContrib_RewardShared = 0;
    SumQ2P1_Hard_HighContrib_RewardShared = 0;
    SumQ1P2_Hard_LowContrib_RewardShared = 0;
    SumQ2P2_Hard_LowContrib_RewardShared = 0;                    
                
    NumOfTrials_Hard_HighContrib_RewardContri_P1 = 0;
    SumQ1P1_Hard_HighContrib_RewardContriPos = 0;
    SumQ2P1_Hard_HighContrib_RewardContriPos = 0;
    SumQ1P2_Hard_LowContrib_RewardContriNeg = 0;
    SumQ2P2_Hard_LowContrib_RewardContriNeg = 0;
    
    NumOfTrials_Hard_HighContrib_RewardRandom_P1 = 0;
    SumQ1P1_Hard_HighContrib_RewardRandom = 0;
    SumQ2P1_Hard_HighContrib_RewardRandom = 0;
    SumQ1P2_Hard_LowContrib_RewardRandom = 0;
    SumQ2P2_Hard_LowContrib_RewardRandom = 0;
                
    NumOfTrials_Hard_HighContrib_RewardRandomNeg_P1 = 0;
    SumQ1P1_Hard_HighContrib_RewardRandomNeg = 0;
    SumQ2P1_Hard_HighContrib_RewardRandomNeg = 0;
    SumQ1P2_Hard_LowContrib_RewardRandomPos = 0;
    SumQ2P2_Hard_LowContrib_RewardRandomPos = 0;
                
    NumOfTrials_Hard_HighContrib_RewardRandomPos_P1 = 0;
    SumQ1P1_Hard_HighContrib_RewardRandomPos = 0;
    SumQ2P1_Hard_HighContrib_RewardRandomPos = 0;
    SumQ1P2_Hard_LowContrib_RewardRandomNeg = 0;
    SumQ2P2_Hard_LowContrib_RewardRandomNeg = 0;             
                
                
NumOfTrials_Hard_HighContrib_P2 = 0;
SumQ1P2_Hard_HighContrib = 0;
SumQ2P2_Hard_HighContrib = 0;
SumQ1P1_Hard_LowContrib = 0;
SumQ2P1_Hard_LowContrib = 0;
                
    NumOfTrials_Hard_HighContrib_RewardShared_P2 = 0;
    SumQ1P2_Hard_HighContrib_RewardShared = 0;
    SumQ2P2_Hard_HighContrib_RewardShared = 0;
    SumQ1P1_Hard_LowContrib_RewardShared = 0;
    SumQ2P1_Hard_LowContrib_RewardShared = 0;                    
                
    NumOfTrials_Hard_HighContrib_RewardContriPos_P2 = 0;
    SumQ1P2_Hard_HighContrib_RewardContriPos = 0;
    SumQ2P2_Hard_HighContrib_RewardContriPos = 0;
    SumQ1P1_Hard_LowContrib_RewardContriNeg = 0;
    SumQ2P1_Hard_LowContrib_RewardContriNeg = 0;
    
    NumOfTrials_Hard_HighContrib_RewardRandom_P2 = 0;
    SumQ1P2_Hard_HighContrib_RewardRandom = 0;
    SumQ2P2_Hard_HighContrib_RewardRandom = 0;
    SumQ1P1_Hard_LowContrib_RewardRandom = 0;
    SumQ2P1_Hard_LowContrib_RewardRandom = 0;

    NumOfTrials_Hard_HighContrib_RewardRandomNeg_P2 = 0;
    SumQ1P2_Hard_HighContrib_RewardRandomNeg = 0;
    SumQ2P2_Hard_HighContrib_RewardRandomNeg = 0;
    SumQ1P1_Hard_LowContrib_RewardRandomPos = 0;
    SumQ2P1_Hard_LowContrib_RewardRandomPos = 0;
                
    NumOfTrials_Hard_HighContrib_RewardRandomPos_P2 = 0;
    SumQ1P2_Hard_HighContrib_RewardRandomPos = 0;
    SumQ2P2_Hard_HighContrib_RewardRandomPos = 0;
    SumQ1P1_Hard_LowContrib_RewardRandomNeg = 0;
    SumQ2P1_Hard_LowContrib_RewardRandomNeg = 0;
                
                
NumOfTrials_Hard_SameContrib_P2 = 0;
SumQ1P2_Hard_SameContrib = 0;
SumQ2P2_Hard_SameContrib = 0;
SumQ1P1_Hard_SameContrib = 0;
SumQ2P1_Hard_SameContrib = 0;
                
                
    NumOfTrials_Hard_SameContrib_RewardShared_P1 = 0;
    SumQ1P1_Hard_SameContrib_RewardShared = 0;
    SumQ2P1_Hard_SameContrib_RewardShared = 0;
    SumQ1P2_Hard_SameContrib_RewardShared = 0;
    SumQ2P2_Hard_SameContrib_RewardShared = 0;                    

    NumOfTrials_Hard_SameContrib_RewardContriPos_P1 = 0;
    SumQ1P1_Hard_SameContrib_RewardContri = 0;
    SumQ2P1_Hard_SameContrib_RewardContri = 0;
    SumQ1P2_Hard_SameContrib_RewardContri = 0;
    SumQ2P2_Hard_SameContrib_RewardContri = 0;
    
    NumOfTrials_Hard_SameContrib_RewardRandom_P1 = 0;
    SumQ1P1_Hard_SameContrib_RewardRandom = 0;
    SumQ2P1_Hard_SameContrib_RewardRandom = 0;
    SumQ1P2_Hard_SameContrib_RewardRandom = 0;
    SumQ2P2_Hard_SameContrib_RewardRandom = 0;
    
    NumOfTrials_Hard_SameContrib_RewardRandomNeg_P1 = 0;
    SumQ1P1_Hard_SameContrib_RewardRandomNeg = 0;
    SumQ2P1_Hard_SameContrib_RewardRandomNeg = 0;
    SumQ1P2_Hard_SameContrib_RewardRandomPos = 0;
    SumQ2P2_Hard_SameContrib_RewardRandomPos = 0;

    NumOfTrials_Hard_SameContrib_RewardRandomPos_P1 = 0;
    SumQ1P1_Hard_SameContrib_RewardRandomPos = 0;
    SumQ2P1_Hard_SameContrib_RewardRandomPos = 0;
    SumQ1P2_Hard_SameContrib_RewardRandomNeg = 0;
    SumQ2P2_Hard_SameContrib_RewardRandomNeg = 0;           

NumOfTrials_Easy_RewardShared_P1 = 0;
SumQ1P1_Easy_RewardShared = 0;
SumQ2P1_Easy_RewardShared = 0;
SumQ1P2_Easy_RewardShared = 0;
SumQ2P2_Easy_RewardShared = 0;

NumOfTrials_Easy_RewardContriPos_P1 = 0;
SumQ1P1_Easy_RewardContriPos = 0;
SumQ2P1_Easy_RewardContriPos = 0;
SumQ1P2_Easy_RewardContriNeg = 0;
SumQ2P2_Easy_RewardContriNeg = 0;    

NumOfTrials_Easy_RewardContriPos_P2 = 0;
SumQ1P2_Easy_RewardContriPos = 0;
SumQ2P2_Easy_RewardContriPos = 0;
SumQ1P1_Easy_RewardContriNeg = 0;
SumQ2P1_Easy_RewardContriNeg = 0;

NumOfTrials_Easy_RewardRandomPos_P1 = 0;
SumQ1P1_Easy_RewardRandomPos = 0;
SumQ2P1_Easy_RewardRandomPos = 0;
SumQ1P2_Easy_RewardRandomNeg = 0;
SumQ2P2_Easy_RewardRandomNeg = 0;

NumOfTrials_Easy_RewardRandomPos_P2 = 0;
SumQ1P2_Easy_RewardRandomPos = 0;
SumQ2P2_Easy_RewardRandomPos = 0;
SumQ1P1_Easy_RewardRandomNeg = 0;
SumQ2P1_Easy_RewardRandomNeg = 0;


NumOfTrials_Hard_RewardShared_P1 = 0;
SumQ1P1_Hard_RewardShared = 0;
SumQ2P1_Hard_RewardShared = 0;
SumQ1P2_Hard_RewardShared = 0;
SumQ2P2_Hard_RewardShared = 0;

NumOfTrials_Hard_RewardContriPos_P1 = 0;
SumQ1P1_Hard_RewardContriPos = 0;
SumQ2P1_Hard_RewardContriPos = 0;
SumQ1P2_Hard_RewardContriNeg = 0;
SumQ2P2_Hard_RewardContriNeg = 0;    

NumOfTrials_Hard_RewardContriPos_P2 = 0;
SumQ1P2_Hard_RewardContriPos = 0;
SumQ2P2_Hard_RewardContriPos = 0;
SumQ1P1_Hard_RewardContriNeg = 0;
SumQ2P1_Hard_RewardContriNeg = 0;

NumOfTrials_Hard_RewardRandomPos_P1 = 0;
SumQ1P1_Hard_RewardRandomPos = 0;
SumQ2P1_Hard_RewardRandomPos = 0;
SumQ1P2_Hard_RewardRandomNeg = 0;
SumQ2P2_Hard_RewardRandomNeg = 0;

NumOfTrials_Hard_RewardRandomPos_P2 = 0;
SumQ1P2_Hard_RewardRandomPos = 0;
SumQ2P2_Hard_RewardRandomPos = 0;
SumQ1P1_Hard_RewardRandomNeg = 0;
SumQ2P1_Hard_RewardRandomNeg = 0;             


NumOfTrials_HighContrib_RewardShared_P1 = 0;
SumQ1P1_HighContrib_RewardShared = 0;
SumQ2P1_HighContrib_RewardShared = 0;
SumQ1P2_LowContrib_RewardShared = 0;
SumQ2P2_LowContrib_RewardShared = 0;

NumOfTrials_HighContrib_RewardContriPos_P1 = 0;
SumQ1P1_HighContrib_RewardContriPos = 0;
SumQ2P1_HighContrib_RewardContriPos = 0;
SumQ1P2_LowContrib_RewardContriNeg = 0;
SumQ2P2_LowContrib_RewardContriNeg = 0;

NumOfTrials_HighContrib_RewardRandomNeg_P1 = 0;
SumQ1P1_HighContrib_RewardRandomNeg = 0;
SumQ2P1_HighContrib_RewardRandomNeg = 0;
SumQ1P2_LowContrib_RewardRandomPos = 0;
SumQ2P2_LowContrib_RewardRandomPos = 0;

NumOfTrials_HighContrib_RewardRandomPos_P1 = 0;
SumQ1P1_HighContrib_RewardRandomPos = 0;
SumQ2P1_HighContrib_RewardRandomPos = 0;
SumQ1P2_LowContrib_RewardRandomNeg = 0;
SumQ2P2_LowContrib_RewardRandomNeg = 0;


NumOfTrials_HighContrib_RewardShared_P2 = 0;
SumQ1P2_HighContrib_RewardShared = 0;
SumQ2P2_HighContrib_RewardShared = 0;
SumQ1P1_LowContrib_RewardShared = 0;
SumQ2P1_LowContrib_RewardShared = 0;

NumOfTrials_HighContrib_RewardContriPos_P2 = 0;
SumQ1P2_HighContrib_RewardContriPos = 0;
SumQ2P2_HighContrib_RewardContriPos = 0;
SumQ1P1_LowContrib_RewardContriNeg = 0;
SumQ2P1_LowContrib_RewardContriNeg = 0;

NumOfTrials_HighContrib_RewardRandomNeg_P2 = 0;
SumQ1P2_HighContrib_RewardRandomNeg = 0;
SumQ2P2_HighContrib_RewardRandomNeg = 0;
SumQ1P1_LowContrib_RewardRandomPos = 0;
SumQ2P1_LowContrib_RewardRandomPos = 0;

NumOfTrials_HighContrib_RewardRandomPos_P2 = 0;
SumQ1P2_HighContrib_RewardRandomPos = 0;
SumQ2P2_HighContrib_RewardRandomPos = 0;
SumQ1P1_LowContrib_RewardRandomNeg = 0;
SumQ2P1_LowContrib_RewardRandomNeg = 0;
            
               
                


% fluency * pivotality

for itrial=1:NumberOfTrials
    
    if ResultSuccess(itrial) == 1 & trials.kind(itrial) == 1 % condition  high fluency(easy) and regular trials (kind ==1)

            if  trials.fluency(itrial) ==  1 & contribPlayer(itrial).P1 >= 0.55 % High fluency and high contrib for player1 (low contrib for player2)
                NumOfTrials_Easy_HighContrib_P1 = NumOfTrials_Easy_HighContrib_P1 + 1;
                SumQ1P1_Easy_HighContrib = SumQ1P1_Easy_HighContrib + ResultsQ1_player1(itrial);
                SumQ2P1_Easy_HighContrib = SumQ2P1_Easy_HighContrib + ResultsQ2_player1(itrial);
                SumQ1P2_Easy_LowContrib = SumQ1P2_Easy_LowContrib + ResultsQ1_player2(itrial);
                SumQ2P2_Easy_LowContrib = SumQ2P2_Easy_LowContrib + ResultsQ2_player2(itrial);
                
                % TRIPLE INTERCATIONS
                if trials.blocReward(itrial) == 1 %shared reward
                    NumOfTrials_Easy_HighContrib_RewardShared_P1 = NumOfTrials_Easy_HighContrib_RewardShared_P1 + 1;
                    SumQ1P1_Easy_HighContrib_RewardShared = SumQ1P1_Easy_HighContrib_RewardShared + ResultsQ1_player1(itrial);
                    SumQ2P1_Easy_HighContrib_RewardShared = SumQ2P1_Easy_HighContrib_RewardShared + ResultsQ2_player1(itrial);
                    SumQ1P2_Easy_LowContrib_RewardShared = SumQ1P2_Easy_LowContrib_RewardShared + ResultsQ1_player2(itrial);
                    SumQ2P2_Easy_LowContrib_RewardShared = SumQ2P2_Easy_LowContrib_RewardShared + ResultsQ2_player2(itrial);                    
                elseif trials.blocReward(itrial) == 2 %fair reward
                    NumOfTrials_Easy_HighContrib_RewardContriPos_P1 = NumOfTrials_Easy_HighContrib_RewardContriPos_P1 + 1;
                    SumQ1P1_Easy_HighContrib_RewardContriPos = SumQ1P1_Easy_HighContrib_RewardContriPos + ResultsQ1_player1(itrial);
                    SumQ2P1_Easy_HighContrib_RewardContriPos = SumQ2P1_Easy_HighContrib_RewardContriPos + ResultsQ2_player1(itrial);
                    SumQ1P2_Easy_LowContrib_RewardContriNeg = SumQ1P2_Easy_LowContrib_RewardContriNeg + ResultsQ1_player2(itrial);
                    SumQ2P2_Easy_LowContrib_RewardContriNeg = SumQ2P2_Easy_LowContrib_RewardContriNeg + ResultsQ2_player2(itrial);
                elseif trials.blocReward(itrial) == 3 %random reward
                    NumOfTrials_Easy_HighContrib_RewardRandom_P1 = NumOfTrials_Easy_HighContrib_RewardRandom_P1 + 1;
                    SumQ1P1_Easy_HighContrib_RewardRandom = SumQ1P1_Easy_HighContrib_RewardRandom + ResultsQ1_player1(itrial);
                    SumQ2P1_Easy_HighContrib_RewardRandom = SumQ2P1_Easy_HighContrib_RewardRandom + ResultsQ2_player1(itrial);
                    SumQ1P2_Easy_LowContrib_RewardRandom = SumQ1P2_Easy_LowContrib_RewardRandom + ResultsQ1_player2(itrial);
                    SumQ2P2_Easy_LowContrib_RewardRandom = SumQ2P2_Easy_LowContrib_RewardRandom + ResultsQ2_player2(itrial);
                    if trials.randomReward1(itrial) == 0 % random reward that is incongruent with players' contributions
                        NumOfTrials_Easy_HighContrib_RewardRandomNeg_P1 = NumOfTrials_Easy_HighContrib_RewardRandomNeg_P1 + 1;
                        SumQ1P1_Easy_HighContrib_RewardRandomNeg = SumQ1P1_Easy_HighContrib_RewardRandomNeg + ResultsQ1_player1(itrial);
                        SumQ2P1_Easy_HighContrib_RewardRandomNeg = SumQ2P1_Easy_HighContrib_RewardRandomNeg + ResultsQ2_player1(itrial);
                        SumQ1P2_Easy_LowContrib_RewardRandomPos = SumQ1P2_Easy_LowContrib_RewardRandomPos + ResultsQ1_player2(itrial);
                        SumQ2P2_Easy_LowContrib_RewardRandomPos = SumQ2P2_Easy_LowContrib_RewardRandomPos + ResultsQ2_player2(itrial);
                    elseif trials.randomReward1(itrial) == 1 % random reward that is congruent with players' contributions
                        NumOfTrials_Easy_HighContrib_RewardRandomPos_P1 = NumOfTrials_Easy_HighContrib_RewardRandomPos_P1 + 1;
                        SumQ1P1_Easy_HighContrib_RewardRandomPos = SumQ1P1_Easy_HighContrib_RewardRandomPos + ResultsQ1_player1(itrial);
                        SumQ2P1_Easy_HighContrib_RewardRandomPos = SumQ2P1_Easy_HighContrib_RewardRandomPos + ResultsQ2_player1(itrial);
                        SumQ1P2_Easy_LowContrib_RewardRandomNeg = SumQ1P2_Easy_LowContrib_RewardRandomNeg + ResultsQ1_player2(itrial);
                        SumQ2P2_Easy_LowContrib_RewardRandomNeg = SumQ2P2_Easy_LowContrib_RewardRandomNeg + ResultsQ2_player2(itrial);
                    end 
                end 
                
            elseif trials.fluency(itrial) ==  1 & contribPlayer(itrial).P2 >= 0.55 % high fluency and low contrib for player1 (high contrib for player2) 
                NumOfTrials_Easy_HighContrib_P2 = NumOfTrials_Easy_HighContrib_P2 + 1;
                SumQ1P2_Easy_HighContrib = SumQ1P2_Easy_HighContrib + ResultsQ1_player2(itrial);
                SumQ2P2_Easy_HighContrib = SumQ2P2_Easy_HighContrib + ResultsQ2_player2(itrial);
                SumQ1P1_Easy_LowContrib = SumQ1P1_Easy_LowContrib + ResultsQ1_player1(itrial);
                SumQ2P1_Easy_LowContrib = SumQ2P1_Easy_LowContrib + ResultsQ2_player1(itrial);
                if trials.blocReward(itrial) == 1 %shared reward
                    NumOfTrials_Easy_HighContrib_RewardShared_P2 = NumOfTrials_Easy_HighContrib_RewardShared_P2 + 1;
                    SumQ1P2_Easy_HighContrib_RewardShared = SumQ1P2_Easy_HighContrib_RewardShared + ResultsQ1_player2(itrial);
                    SumQ2P2_Easy_HighContrib_RewardShared = SumQ2P2_Easy_HighContrib_RewardShared + ResultsQ2_player2(itrial);
                    SumQ1P1_Easy_LowContrib_RewardShared = SumQ1P1_Easy_LowContrib_RewardShared + ResultsQ1_player1(itrial);
                    SumQ2P1_Easy_LowContrib_RewardShared = SumQ2P1_Easy_LowContrib_RewardShared + ResultsQ2_player1(itrial);                    
                elseif trials.blocReward(itrial) == 2 %fair reward
                    NumOfTrials_Easy_HighContrib_RewardContriPos_P2 = NumOfTrials_Easy_HighContrib_RewardContriPos_P2 + 1;
                    SumQ1P2_Easy_HighContrib_RewardContriPos = SumQ1P2_Easy_HighContrib_RewardContriPos + ResultsQ1_player2(itrial);
                    SumQ2P2_Easy_HighContrib_RewardContriPos = SumQ2P2_Easy_HighContrib_RewardContriPos + ResultsQ2_player2(itrial);
                    SumQ1P1_Easy_LowContrib_RewardContriNeg = SumQ1P1_Easy_LowContrib_RewardContriNeg + ResultsQ1_player1(itrial);
                    SumQ2P1_Easy_LowContrib_RewardContriNeg = SumQ2P1_Easy_LowContrib_RewardContriNeg + ResultsQ2_player1(itrial);
                elseif trials.blocReward(itrial) == 3 % random reward
                    NumOfTrials_Easy_HighContrib_RewardRandom_P2 = NumOfTrials_Easy_HighContrib_RewardRandom_P2 + 1;
                    SumQ1P2_Easy_HighContrib_RewardRandom = SumQ1P2_Easy_HighContrib_RewardRandom + ResultsQ1_player2(itrial);
                    SumQ2P2_Easy_HighContrib_RewardRandom = SumQ2P2_Easy_HighContrib_RewardRandom + ResultsQ2_player2(itrial);
                    SumQ1P1_Easy_LowContrib_RewardRandom = SumQ1P1_Easy_LowContrib_RewardRandom + ResultsQ1_player1(itrial);
                    SumQ2P1_Easy_LowContrib_RewardRandom = SumQ2P1_Easy_LowContrib_RewardRandom + ResultsQ2_player1(itrial);
                    if  trials.randomReward1(itrial) == 0 % random reward that is incongruent with players' contributions
                        NumOfTrials_Easy_HighContrib_RewardRandomPos_P2 = NumOfTrials_Easy_HighContrib_RewardRandomPos_P2 + 1;
                        SumQ1P2_Easy_HighContrib_RewardRandomPos = SumQ1P2_Easy_HighContrib_RewardRandomPos + ResultsQ1_player2(itrial);
                        SumQ2P2_Easy_HighContrib_RewardRandomPos = SumQ2P2_Easy_HighContrib_RewardRandomPos + ResultsQ2_player2(itrial);
                        SumQ1P1_Easy_LowContrib_RewardRandomNeg = SumQ1P1_Easy_LowContrib_RewardRandomNeg + ResultsQ1_player1(itrial);
                        SumQ2P1_Easy_LowContrib_RewardRandomNeg = SumQ2P1_Easy_LowContrib_RewardRandomNeg + ResultsQ2_player1(itrial);
                    elseif trials.randomReward1(itrial) == 1 % random reward that is congruent with players' contributions
                        NumOfTrials_Easy_HighContrib_RewardRandomNeg_P2 = NumOfTrials_Easy_HighContrib_RewardRandomNeg_P2 + 1;
                        SumQ1P2_Easy_HighContrib_RewardRandomNeg = SumQ1P2_Easy_HighContrib_RewardRandomNeg + ResultsQ1_player2(itrial);
                        SumQ2P2_Easy_HighContrib_RewardRandomNeg = SumQ2P2_Easy_HighContrib_RewardRandomNeg + ResultsQ2_player2(itrial);
                        SumQ1P1_Easy_LowContrib_RewardRandomPos = SumQ1P1_Easy_LowContrib_RewardRandomPos + ResultsQ1_player1(itrial);
                        SumQ2P1_Easy_LowContrib_RewardRandomPos = SumQ2P1_Easy_LowContrib_RewardRandomPos + ResultsQ2_player1(itrial);
                    end 
                end
            elseif trials.fluency(itrial) == 1 & contribPlayer(itrial).P1 < 0.55 & contribPlayer(itrial).P1 >= 0.45 % high fluency & equivalent contribution for both players
                NumOfTrials_Easy_SameContrib_P2 = NumOfTrials_Easy_SameContrib_P2 + 1;
                SumQ1P2_Easy_SameContrib = SumQ1P2_Easy_SameContrib + ResultsQ1_player2(itrial);
                SumQ2P2_Easy_SameContrib = SumQ2P2_Easy_SameContrib + ResultsQ2_player2(itrial);
                SumQ1P1_Easy_SameContrib = SumQ1P1_Easy_SameContrib + ResultsQ1_player1(itrial);
                SumQ2P1_Easy_SameContrib = SumQ2P1_Easy_SameContrib + ResultsQ2_player1(itrial);
                if trials.blocReward(itrial) == 1 %shared reward
                    NumOfTrials_Easy_SameContrib_RewardShared_P1 = NumOfTrials_Easy_SameContrib_RewardShared_P1 + 1;
                    SumQ1P1_Easy_SameContrib_RewardShared = SumQ1P1_Easy_SameContrib_RewardShared + ResultsQ1_player1(itrial);
                    SumQ2P1_Easy_SameContrib_RewardShared = SumQ2P1_Easy_SameContrib_RewardShared + ResultsQ2_player1(itrial);
                    SumQ1P2_Easy_SameContrib_RewardShared = SumQ1P2_Easy_SameContrib_RewardShared + ResultsQ1_player2(itrial);
                    SumQ2P2_Easy_SameContrib_RewardShared = SumQ2P2_Easy_SameContrib_RewardShared + ResultsQ2_player2(itrial);                    
                elseif trials.blocReward(itrial) == 2 %fair reward
                    NumOfTrials_Easy_SameContrib_RewardContri_P1 = NumOfTrials_Easy_SameContrib_RewardContri_P1 + 1;
                    SumQ1P1_Easy_SameContrib_RewardContri = SumQ1P1_Easy_SameContrib_RewardContri + ResultsQ1_player1(itrial);
                    SumQ2P1_Easy_SameContrib_RewardContri = SumQ2P1_Easy_SameContrib_RewardContri + ResultsQ2_player1(itrial);
                    SumQ1P2_Easy_SameContrib_RewardContri = SumQ1P2_Easy_SameContrib_RewardContri + ResultsQ1_player2(itrial);
                    SumQ2P2_Easy_SameContrib_RewardContri = SumQ2P2_Easy_SameContrib_RewardContri + ResultsQ2_player2(itrial);
                elseif trials.blocReward(itrial) == 3 
                    NumOfTrials_Easy_SameContrib_RewardRandom_P1 = NumOfTrials_Easy_SameContrib_RewardRandom_P1 + 1;
                    SumQ1P1_Easy_SameContrib_RewardRandom = SumQ1P1_Easy_SameContrib_RewardRandom + ResultsQ1_player1(itrial);
                    SumQ2P1_Easy_SameContrib_RewardRandom = SumQ2P1_Easy_SameContrib_RewardRandom + ResultsQ2_player1(itrial);
                    SumQ1P2_Easy_SameContrib_RewardRandom = SumQ1P2_Easy_SameContrib_RewardRandom + ResultsQ1_player2(itrial);
                    SumQ2P2_Easy_SameContrib_RewardRandom = SumQ2P2_Easy_SameContrib_RewardRandom + ResultsQ2_player2(itrial);
                    if trials.randomReward1(itrial) == 0 % random reward 
                        NumOfTrials_Easy_SameContrib_RewardRandomNeg_P1 = NumOfTrials_Easy_SameContrib_RewardRandomNeg_P1 + 1;
                        SumQ1P1_Easy_SameContrib_RewardRandomNeg = SumQ1P1_Easy_SameContrib_RewardRandomNeg + ResultsQ1_player1(itrial);
                        SumQ2P1_Easy_SameContrib_RewardRandomNeg = SumQ2P1_Easy_SameContrib_RewardRandomNeg + ResultsQ2_player1(itrial);
                        SumQ1P2_Easy_SameContrib_RewardRandomPos = SumQ1P2_Easy_SameContrib_RewardRandomPos + ResultsQ1_player2(itrial);
                        SumQ2P2_Easy_SameContrib_RewardRandomPos = SumQ2P2_Easy_SameContrib_RewardRandomPos + ResultsQ2_player2(itrial);
                    elseif trials.randomReward1(itrial) == 1 % random reward 
                        NumOfTrials_Easy_SameContrib_RewardRandomPos_P1 = NumOfTrials_Easy_SameContrib_RewardRandomPos_P1 + 1;
                        SumQ1P1_Easy_SameContrib_RewardRandomPos = SumQ1P1_Easy_SameContrib_RewardRandomPos + ResultsQ1_player1(itrial);
                        SumQ2P1_Easy_SameContrib_RewardRandomPos = SumQ2P1_Easy_SameContrib_RewardRandomPos + ResultsQ2_player1(itrial);
                        SumQ1P2_Easy_SameContrib_RewardRandomNeg = SumQ1P2_Easy_SameContrib_RewardRandomNeg + ResultsQ1_player2(itrial);
                        SumQ2P2_Easy_SameContrib_RewardRandomNeg = SumQ2P2_Easy_SameContrib_RewardRandomNeg + ResultsQ2_player2(itrial);
                    end 
                end
                
                
            elseif  trials.fluency(itrial) ==  2 & contribPlayer(itrial).P1 >= 0.55 % Low fluency and high contrib for player1 (low contrib for player2)
                NumOfTrials_Hard_HighContrib_P1 = NumOfTrials_Hard_HighContrib_P1 + 1;
                SumQ1P1_Hard_HighContrib = SumQ1P1_Hard_HighContrib + ResultsQ1_player1(itrial);
                SumQ2P1_Hard_HighContrib = SumQ2P1_Hard_HighContrib + ResultsQ2_player1(itrial);
                SumQ1P2_Hard_LowContrib = SumQ1P2_Hard_LowContrib + ResultsQ1_player2(itrial);
                SumQ2P2_Hard_LowContrib = SumQ2P2_Hard_LowContrib + ResultsQ2_player2(itrial);
                if trials.blocReward(itrial) == 1 %shared reward
                    NumOfTrials_Hard_HighContrib_RewardShared_P1 = NumOfTrials_Hard_HighContrib_RewardShared_P1 + 1;
                    SumQ1P1_Hard_HighContrib_RewardShared = SumQ1P1_Hard_HighContrib_RewardShared + ResultsQ1_player1(itrial);
                    SumQ2P1_Hard_HighContrib_RewardShared = SumQ2P1_Hard_HighContrib_RewardShared + ResultsQ2_player1(itrial);
                    SumQ1P2_Hard_LowContrib_RewardShared = SumQ1P2_Hard_LowContrib_RewardShared + ResultsQ1_player2(itrial);
                    SumQ2P2_Hard_LowContrib_RewardShared = SumQ2P2_Hard_LowContrib_RewardShared + ResultsQ2_player2(itrial);                    
                elseif trials.blocReward(itrial) == 2 %fair reward
                    NumOfTrials_Hard_HighContrib_RewardContri_P1 = NumOfTrials_Hard_HighContrib_RewardContri_P1 + 1;
                    SumQ1P1_Hard_HighContrib_RewardContriPos = SumQ1P1_Hard_HighContrib_RewardContriPos + ResultsQ1_player1(itrial);
                    SumQ2P1_Hard_HighContrib_RewardContriPos = SumQ2P1_Hard_HighContrib_RewardContriPos + ResultsQ2_player1(itrial);
                    SumQ1P2_Hard_LowContrib_RewardContriNeg = SumQ1P2_Hard_LowContrib_RewardContriNeg + ResultsQ1_player2(itrial);
                    SumQ2P2_Hard_LowContrib_RewardContriNeg = SumQ2P2_Hard_LowContrib_RewardContriNeg + ResultsQ2_player2(itrial);
                elseif trials.blocReward(itrial) == 3 
                    NumOfTrials_Hard_HighContrib_RewardRandom_P1 = NumOfTrials_Hard_HighContrib_RewardRandom_P1 + 1;
                    SumQ1P1_Hard_HighContrib_RewardRandom = SumQ1P1_Hard_HighContrib_RewardRandom + ResultsQ1_player1(itrial);
                    SumQ2P1_Hard_HighContrib_RewardRandom = SumQ2P1_Hard_HighContrib_RewardRandom + ResultsQ2_player1(itrial);
                    SumQ1P2_Hard_LowContrib_RewardRandom = SumQ1P2_Hard_LowContrib_RewardRandom + ResultsQ1_player2(itrial);
                    SumQ2P2_Hard_LowContrib_RewardRandom = SumQ2P2_Hard_LowContrib_RewardRandom + ResultsQ2_player2(itrial);
                    if trials.randomReward1(itrial) == 0 % random reward that is incongruent with players' contributions
                        NumOfTrials_Hard_HighContrib_RewardRandomNeg_P1 = NumOfTrials_Hard_HighContrib_RewardRandomNeg_P1 + 1;
                        SumQ1P1_Hard_HighContrib_RewardRandomNeg = SumQ1P1_Hard_HighContrib_RewardRandomNeg + ResultsQ1_player1(itrial);
                        SumQ2P1_Hard_HighContrib_RewardRandomNeg = SumQ2P1_Hard_HighContrib_RewardRandomNeg + ResultsQ2_player1(itrial);
                        SumQ1P2_Hard_LowContrib_RewardRandomPos = SumQ1P2_Hard_LowContrib_RewardRandomPos + ResultsQ1_player2(itrial);
                        SumQ2P2_Hard_LowContrib_RewardRandomPos = SumQ2P2_Hard_LowContrib_RewardRandomPos + ResultsQ2_player2(itrial);
                    elseif trials.randomReward1(itrial) == 1 % random reward that is congruent with players' contributions
                        NumOfTrials_Hard_HighContrib_RewardRandomPos_P1 = NumOfTrials_Hard_HighContrib_RewardRandomPos_P1 + 1;
                        SumQ1P1_Hard_HighContrib_RewardRandomPos = SumQ1P1_Hard_HighContrib_RewardRandomPos + ResultsQ1_player1(itrial);
                        SumQ2P1_Hard_HighContrib_RewardRandomPos = SumQ2P1_Hard_HighContrib_RewardRandomPos + ResultsQ2_player1(itrial);
                        SumQ1P2_Hard_LowContrib_RewardRandomNeg = SumQ1P2_Hard_LowContrib_RewardRandomNeg + ResultsQ1_player2(itrial);
                        SumQ2P2_Hard_LowContrib_RewardRandomNeg = SumQ2P2_Hard_LowContrib_RewardRandomNeg + ResultsQ2_player2(itrial);
                    end 
                end 
                
            elseif trials.fluency(itrial) ==  2 & contribPlayer(itrial).P2 >= 0.55 % Low fluency and low contrib for player1 (high contrib for player2) 
                NumOfTrials_Hard_HighContrib_P2 = NumOfTrials_Hard_HighContrib_P2 + 1;
                SumQ1P2_Hard_HighContrib = SumQ1P2_Hard_HighContrib + ResultsQ1_player2(itrial);
                SumQ2P2_Hard_HighContrib = SumQ2P2_Hard_HighContrib + ResultsQ2_player2(itrial);
                SumQ1P1_Hard_LowContrib = SumQ1P1_Hard_LowContrib + ResultsQ1_player1(itrial);
                SumQ2P1_Hard_LowContrib = SumQ2P1_Hard_LowContrib + ResultsQ2_player1(itrial);
                if trials.blocReward(itrial) == 1 %shared reward
                    NumOfTrials_Hard_HighContrib_RewardShared_P2 = NumOfTrials_Hard_HighContrib_RewardShared_P2 + 1;
                    SumQ1P2_Hard_HighContrib_RewardShared = SumQ1P2_Hard_HighContrib_RewardShared + ResultsQ1_player2(itrial);
                    SumQ2P2_Hard_HighContrib_RewardShared = SumQ2P2_Hard_HighContrib_RewardShared + ResultsQ2_player2(itrial);
                    SumQ1P1_Hard_LowContrib_RewardShared = SumQ1P1_Hard_LowContrib_RewardShared + ResultsQ1_player1(itrial);
                    SumQ2P1_Hard_LowContrib_RewardShared = SumQ2P1_Hard_LowContrib_RewardShared + ResultsQ2_player1(itrial);                    
                elseif trials.blocReward(itrial) == 2 %fair reward
                    NumOfTrials_Hard_HighContrib_RewardContriPos_P2 = NumOfTrials_Hard_HighContrib_RewardContriPos_P2 + 1;
                    SumQ1P2_Hard_HighContrib_RewardContriPos = SumQ1P2_Hard_HighContrib_RewardContriPos + ResultsQ1_player2(itrial);
                    SumQ2P2_Hard_HighContrib_RewardContriPos = SumQ2P2_Hard_HighContrib_RewardContriPos + ResultsQ2_player2(itrial);
                    SumQ1P1_Hard_LowContrib_RewardContriNeg = SumQ1P1_Hard_LowContrib_RewardContriNeg + ResultsQ1_player1(itrial);
                    SumQ2P1_Hard_LowContrib_RewardContriNeg = SumQ2P1_Hard_LowContrib_RewardContriNeg + ResultsQ2_player1(itrial);
                elseif trials.blocReward(itrial) == 3 
                        NumOfTrials_Hard_HighContrib_RewardRandom_P2 = NumOfTrials_Hard_HighContrib_RewardRandom_P2 + 1;
                        SumQ1P2_Hard_HighContrib_RewardRandom = SumQ1P2_Hard_HighContrib_RewardRandom + ResultsQ1_player2(itrial);
                        SumQ2P2_Hard_HighContrib_RewardRandom = SumQ2P2_Hard_HighContrib_RewardRandom + ResultsQ2_player2(itrial);
                        SumQ1P1_Hard_LowContrib_RewardRandom = SumQ1P1_Hard_LowContrib_RewardRandom + ResultsQ1_player1(itrial);
                        SumQ2P1_Hard_LowContrib_RewardRandom = SumQ2P1_Hard_LowContrib_RewardRandom + ResultsQ2_player1(itrial);
                    if trials.randomReward1(itrial) == 0 % random reward that is congruent with players' contributions
                        NumOfTrials_Hard_HighContrib_RewardRandomPos_P2 = NumOfTrials_Hard_HighContrib_RewardRandomPos_P2 + 1;
                        SumQ1P2_Hard_HighContrib_RewardRandomPos= SumQ1P2_Hard_HighContrib_RewardRandomPos + ResultsQ1_player2(itrial);
                        SumQ2P2_Hard_HighContrib_RewardRandomPos = SumQ2P2_Hard_HighContrib_RewardRandomPos + ResultsQ2_player2(itrial);
                        SumQ1P1_Hard_LowContrib_RewardRandomNeg = SumQ1P1_Hard_LowContrib_RewardRandomNeg + ResultsQ1_player1(itrial);
                        SumQ2P1_Hard_LowContrib_RewardRandomNeg = SumQ2P1_Hard_LowContrib_RewardRandomNeg + ResultsQ2_player1(itrial);
                    elseif trials.randomReward1(itrial) == 1 % random reward that is incongruent with players' contributions
                        NumOfTrials_Hard_HighContrib_RewardRandomNeg_P2 = NumOfTrials_Hard_HighContrib_RewardRandomNeg_P2 + 1;
                        SumQ1P2_Hard_HighContrib_RewardRandomNeg = SumQ1P2_Hard_HighContrib_RewardRandomNeg + ResultsQ1_player2(itrial);
                        SumQ2P2_Hard_HighContrib_RewardRandomNeg = SumQ2P2_Hard_HighContrib_RewardRandomNeg + ResultsQ2_player2(itrial);
                        SumQ1P1_Hard_LowContrib_RewardRandomPos = SumQ1P1_Hard_LowContrib_RewardRandomPos + ResultsQ1_player1(itrial);
                        SumQ2P1_Hard_LowContrib_RewardRandomPos = SumQ2P1_Hard_LowContrib_RewardRandomPos + ResultsQ2_player1(itrial);
                    end 
                end
                
            elseif trials.fluency(itrial) == 2 & contribPlayer(itrial).P1 < 0.55 & contribPlayer(itrial).P1 >= 0.45 % Low fluency & equivalent contribution for both players
                NumOfTrials_Hard_SameContrib_P2 = NumOfTrials_Hard_SameContrib_P2 + 1;
                SumQ1P2_Hard_SameContrib = SumQ1P2_Hard_SameContrib + ResultsQ1_player2(itrial);
                SumQ2P2_Hard_SameContrib = SumQ2P2_Hard_SameContrib + ResultsQ2_player2(itrial);
                SumQ1P1_Hard_SameContrib = SumQ1P1_Hard_SameContrib + ResultsQ1_player1(itrial);
                SumQ2P1_Hard_SameContrib = SumQ2P1_Hard_SameContrib + ResultsQ2_player1(itrial);
                if trials.blocReward(itrial) == 1 %shared reward
                    NumOfTrials_Hard_SameContrib_RewardShared_P1 = NumOfTrials_Hard_SameContrib_RewardShared_P1 + 1;
                    SumQ1P1_Hard_SameContrib_RewardShared = SumQ1P1_Hard_SameContrib_RewardShared + ResultsQ1_player1(itrial);
                    SumQ2P1_Hard_SameContrib_RewardShared = SumQ2P1_Hard_SameContrib_RewardShared + ResultsQ2_player1(itrial);
                    SumQ1P2_Hard_SameContrib_RewardShared = SumQ1P2_Hard_SameContrib_RewardShared + ResultsQ1_player2(itrial);
                    SumQ2P2_Hard_SameContrib_RewardShared = SumQ2P2_Hard_SameContrib_RewardShared + ResultsQ2_player2(itrial);                    
                elseif trials.blocReward(itrial) == 2 %fair reward
                    NumOfTrials_Hard_SameContrib_RewardContriPos_P1 = NumOfTrials_Hard_SameContrib_RewardContriPos_P1 + 1;
                    SumQ1P1_Hard_SameContrib_RewardContri = SumQ1P1_Hard_SameContrib_RewardContri + ResultsQ1_player1(itrial);
                    SumQ2P1_Hard_SameContrib_RewardContri = SumQ2P1_Hard_SameContrib_RewardContri + ResultsQ2_player1(itrial);
                    SumQ1P2_Hard_SameContrib_RewardContri = SumQ1P2_Hard_SameContrib_RewardContri + ResultsQ1_player2(itrial);
                    SumQ2P2_Hard_SameContrib_RewardContri = SumQ2P2_Hard_SameContrib_RewardContri + ResultsQ2_player2(itrial);
                elseif trials.blocReward(itrial) == 3 
                    NumOfTrials_Hard_SameContrib_RewardRandom_P1 = NumOfTrials_Hard_SameContrib_RewardRandom_P1 + 1;
                    SumQ1P1_Hard_SameContrib_RewardRandom = SumQ1P1_Hard_SameContrib_RewardRandom + ResultsQ1_player1(itrial);
                    SumQ2P1_Hard_SameContrib_RewardRandom = SumQ2P1_Hard_SameContrib_RewardRandom + ResultsQ2_player1(itrial);
                    SumQ1P2_Hard_SameContrib_RewardRandom = SumQ1P2_Hard_SameContrib_RewardRandom + ResultsQ1_player2(itrial);
                    SumQ2P2_Hard_SameContrib_RewardRandom = SumQ2P2_Hard_SameContrib_RewardRandom + ResultsQ2_player2(itrial);
                    if trials.randomReward1(itrial) == 0 % random reward 
                        NumOfTrials_Hard_SameContrib_RewardRandomNeg_P1 = NumOfTrials_Hard_SameContrib_RewardRandomNeg_P1 + 1;
                        SumQ1P1_Hard_SameContrib_RewardRandomNeg = SumQ1P1_Hard_SameContrib_RewardRandomNeg + ResultsQ1_player1(itrial);
                        SumQ2P1_Hard_SameContrib_RewardRandomNeg = SumQ2P1_Hard_SameContrib_RewardRandomNeg + ResultsQ2_player1(itrial);
                        SumQ1P2_Hard_SameContrib_RewardRandomPos = SumQ1P2_Hard_SameContrib_RewardRandomPos + ResultsQ1_player2(itrial);
                        SumQ2P2_Hard_SameContrib_RewardRandomPos = SumQ2P2_Hard_SameContrib_RewardRandomPos + ResultsQ2_player2(itrial);
                    elseif trials.randomReward1(itrial) == 1 % random reward 
                        NumOfTrials_Hard_SameContrib_RewardRandomPos_P1 = NumOfTrials_Hard_SameContrib_RewardRandomPos_P1 + 1;
                        SumQ1P1_Hard_SameContrib_RewardRandomPos = SumQ1P1_Hard_SameContrib_RewardRandomPos + ResultsQ1_player1(itrial);
                        SumQ2P1_Hard_SameContrib_RewardRandomPos = SumQ2P1_Hard_SameContrib_RewardRandomPos + ResultsQ2_player1(itrial);
                        SumQ1P2_Hard_SameContrib_RewardRandomNeg = SumQ1P2_Hard_SameContrib_RewardRandomNeg + ResultsQ1_player2(itrial);
                        SumQ2P2_Hard_SameContrib_RewardRandomNeg = SumQ2P2_Hard_SameContrib_RewardRandomNeg + ResultsQ2_player2(itrial);
                        
                    end
                end
            end
            
                        
            if trials.fluency(itrial) == 1 & trials.blocReward(itrial) == 1 % high fluency and shared reward
                NumOfTrials_Easy_RewardShared_P1 = NumOfTrials_Easy_RewardShared_P1 + 1;
                SumQ1P1_Easy_RewardShared = SumQ1P1_Easy_RewardShared + ResultsQ1_player1(itrial);
                SumQ2P1_Easy_RewardShared = SumQ2P1_Easy_RewardShared + ResultsQ2_player1(itrial);
                SumQ1P2_Easy_RewardShared = SumQ1P2_Easy_RewardShared + ResultsQ1_player2(itrial);
                SumQ2P2_Easy_RewardShared = SumQ2P2_Easy_RewardShared + ResultsQ2_player2(itrial);
            elseif trials.fluency(itrial) == 1 & trials.blocReward(itrial) == 2 & contribPlayer(itrial).P1 < 0.55 & contribPlayer(itrial).P2 >= 0.45 % high fluency and reward linked to motor contribution : positive for player1 and negative for player2
                NumOfTrials_Easy_RewardContriPos_P1 = NumOfTrials_Easy_RewardContriPos_P1 + 1;
                SumQ1P1_Easy_RewardContriPos = SumQ1P1_Easy_RewardContriPos + ResultsQ1_player1(itrial);
                SumQ2P1_Easy_RewardContriPos = SumQ2P1_Easy_RewardContriPos + ResultsQ2_player1(itrial);
                SumQ1P2_Easy_RewardContriNeg = SumQ1P2_Easy_RewardContriNeg + ResultsQ1_player2(itrial);
                SumQ2P2_Easy_RewardContriNeg = SumQ2P2_Easy_RewardContriNeg + ResultsQ2_player2(itrial);    
            elseif trials.fluency(itrial) == 1 & trials.blocReward(itrial) == 2 & contribPlayer(itrial).P2 < 0.55 & contribPlayer(itrial).P1 >= 0.45 % high fluency and reward linked to motor contribution : positive for player2 and negative for player1
                NumOfTrials_Easy_RewardContriPos_P2 = NumOfTrials_Easy_RewardContriPos_P2 + 1;
                SumQ1P2_Easy_RewardContriPos = SumQ1P2_Easy_RewardContriPos + ResultsQ1_player2(itrial);
                SumQ2P2_Easy_RewardContriPos = SumQ2P2_Easy_RewardContriPos + ResultsQ2_player2(itrial);
                SumQ1P1_Easy_RewardContriNeg = SumQ1P1_Easy_RewardContriNeg + ResultsQ1_player1(itrial);
                SumQ2P1_Easy_RewardContriNeg = SumQ2P1_Easy_RewardContriNeg + ResultsQ2_player1(itrial);
            elseif trials.fluency(itrial) == 1 & trials.blocReward(itrial) == 3 & trials.randomReward1(itrial) == 1 % high fluency and positive random reward for player1 and negative random reward for player2
                NumOfTrials_Easy_RewardRandomPos_P1 = NumOfTrials_Easy_RewardRandomPos_P1 + 1;
                SumQ1P1_Easy_RewardRandomPos = SumQ1P1_Easy_RewardRandomPos + ResultsQ1_player1(itrial);
                SumQ2P1_Easy_RewardRandomPos = SumQ2P1_Easy_RewardRandomPos + ResultsQ2_player1(itrial);
                SumQ1P2_Easy_RewardRandomNeg = SumQ1P2_Easy_RewardRandomNeg + ResultsQ1_player2(itrial);
                SumQ2P2_Easy_RewardRandomNeg = SumQ2P2_Easy_RewardRandomNeg + ResultsQ2_player2(itrial);
            elseif trials.fluency(itrial) == 1 & trials.blocReward(itrial) == 3 & trials.randomReward1(itrial) == 0 % high fluency and positive random reward for player2 and negative random reward for player1
                NumOfTrials_Easy_RewardRandomPos_P2 = NumOfTrials_Easy_RewardRandomPos_P2 + 1;
                SumQ1P2_Easy_RewardRandomPos = SumQ1P2_Easy_RewardRandomPos + ResultsQ1_player2(itrial);
                SumQ2P2_Easy_RewardRandomPos = SumQ2P2_Easy_RewardRandomPos + ResultsQ2_player2(itrial);
                SumQ1P1_Easy_RewardRandomNeg = SumQ1P1_Easy_RewardRandomNeg + ResultsQ1_player1(itrial);
                SumQ2P1_Easy_RewardRandomNeg = SumQ2P1_Easy_RewardRandomNeg + ResultsQ2_player1(itrial);
                
            elseif trials.fluency(itrial) == 2 & trials.blocReward(itrial) == 1 % low fluency and shared reward
                NumOfTrials_Hard_RewardShared_P1 = NumOfTrials_Hard_RewardShared_P1 + 1;
                SumQ1P1_Hard_RewardShared = SumQ1P1_Hard_RewardShared + ResultsQ1_player1(itrial);
                SumQ2P1_Hard_RewardShared = SumQ2P1_Hard_RewardShared + ResultsQ2_player1(itrial);
                SumQ1P2_Hard_RewardShared = SumQ1P2_Hard_RewardShared + ResultsQ1_player2(itrial);
                SumQ2P2_Hard_RewardShared = SumQ2P2_Hard_RewardShared + ResultsQ2_player2(itrial);
            elseif trials.fluency(itrial) == 2 & trials.blocReward(itrial) == 2 & contribPlayer(itrial).P1 < 0.55 & contribPlayer(itrial).P2 >= 0.45 % low fluency and reward linked to motor contribution : positive for player1 and negative for player2
                NumOfTrials_Hard_RewardContriPos_P1 = NumOfTrials_Hard_RewardContriPos_P1 + 1;
                SumQ1P1_Hard_RewardContriPos = SumQ1P1_Hard_RewardContriPos + ResultsQ1_player1(itrial);
                SumQ2P1_Hard_RewardContriPos = SumQ2P1_Hard_RewardContriPos + ResultsQ2_player1(itrial);
                SumQ1P2_Hard_RewardContriNeg = SumQ1P2_Hard_RewardContriNeg + ResultsQ1_player2(itrial);
                SumQ2P2_Hard_RewardContriNeg = SumQ2P2_Hard_RewardContriNeg + ResultsQ2_player2(itrial);    
            elseif trials.fluency(itrial) == 2 & trials.blocReward(itrial) == 2 & contribPlayer(itrial).P2 < 0.55 & contribPlayer(itrial).P1 >= 0.45 % low fluency and reward linked to motor contribution : positive for player2 and negative for player1
                NumOfTrials_Hard_RewardContriPos_P2 = NumOfTrials_Hard_RewardContriPos_P2 + 1;
                SumQ1P2_Hard_RewardContriPos = SumQ1P2_Hard_RewardContriPos + ResultsQ1_player2(itrial);
                SumQ2P2_Hard_RewardContriPos = SumQ2P2_Hard_RewardContriPos + ResultsQ2_player2(itrial);
                SumQ1P1_Hard_RewardContriNeg = SumQ1P1_Hard_RewardContriNeg + ResultsQ1_player1(itrial);
                SumQ2P1_Hard_RewardContriNeg = SumQ2P1_Hard_RewardContriNeg + ResultsQ2_player1(itrial);
            elseif trials.fluency(itrial) == 2 & trials.blocReward(itrial) == 3 & trials.randomReward1(itrial) == 1 % low fluency and positive random reward for player1 and negative random reward for player2
                NumOfTrials_Hard_RewardRandomPos_P1 = NumOfTrials_Hard_RewardRandomPos_P1 + 1;
                SumQ1P1_Hard_RewardRandomPos = SumQ1P1_Hard_RewardRandomPos + ResultsQ1_player1(itrial);
                SumQ2P1_Hard_RewardRandomPos = SumQ2P1_Hard_RewardRandomPos + ResultsQ2_player1(itrial);
                SumQ1P2_Hard_RewardRandomNeg = SumQ1P2_Hard_RewardRandomNeg + ResultsQ1_player2(itrial);
                SumQ2P2_Hard_RewardRandomNeg = SumQ2P2_Hard_RewardRandomNeg + ResultsQ2_player2(itrial);
            elseif trials.fluency(itrial) == 2 & trials.blocReward(itrial) == 3 & trials.randomReward1(itrial) == 0 % low fluency and positive random reward for player2 and negative random reward for player1
                NumOfTrials_Hard_RewardRandomPos_P2 = NumOfTrials_Hard_RewardRandomPos_P2 + 1;
                SumQ1P2_Hard_RewardRandomPos = SumQ1P2_Hard_RewardRandomPos + ResultsQ1_player2(itrial);
                SumQ2P2_Hard_RewardRandomPos = SumQ2P2_Hard_RewardRandomPos + ResultsQ2_player2(itrial);
                SumQ1P1_Hard_RewardRandomNeg = SumQ1P1_Hard_RewardRandomNeg + ResultsQ1_player1(itrial);
                SumQ2P1_Hard_RewardRandomNeg = SumQ2P1_Hard_RewardRandomNeg + ResultsQ2_player1(itrial);             
            end
            
            if contribPlayer(itrial).P1 >= 0.55 & trials.blocReward(itrial) == 1 % high contrib for player 1, low contrib for player 2 but shared reward
                NumOfTrials_HighContrib_RewardShared_P1 = NumOfTrials_HighContrib_RewardShared_P1 + 1;
                SumQ1P1_HighContrib_RewardShared = SumQ1P1_HighContrib_RewardShared + ResultsQ1_player1(itrial);
                SumQ2P1_HighContrib_RewardShared = SumQ2P1_HighContrib_RewardShared + ResultsQ2_player1(itrial);
                SumQ1P2_LowContrib_RewardShared = SumQ1P2_LowContrib_RewardShared + ResultsQ1_player2(itrial);
                SumQ2P2_LowContrib_RewardShared = SumQ2P2_LowContrib_RewardShared + ResultsQ2_player2(itrial);
            elseif contribPlayer(itrial).P1 >= 0.55 & trials.blocReward(itrial) == 2 % high contrib for player 1, low contrib for player 2 and reward linked to this contrib
                NumOfTrials_HighContrib_RewardContriPos_P1 = NumOfTrials_HighContrib_RewardContriPos_P1 + 1;
                SumQ1P1_HighContrib_RewardContriPos = SumQ1P1_HighContrib_RewardContriPos + ResultsQ1_player1(itrial);
                SumQ2P1_HighContrib_RewardContriPos = SumQ2P1_HighContrib_RewardContriPos + ResultsQ2_player1(itrial);
                SumQ1P2_LowContrib_RewardContriNeg = SumQ1P2_LowContrib_RewardContriNeg + ResultsQ1_player2(itrial);
                SumQ2P2_LowContrib_RewardContriNeg = SumQ2P2_LowContrib_RewardContriNeg + ResultsQ2_player2(itrial);
            elseif contribPlayer(itrial).P1 >= 0.55 & trials.blocReward(itrial) == 3 & trials.randomReward1(itrial) == 0 % incongruency between motor contrib and random reward (high contrib player 1 but no reward) 
                NumOfTrials_HighContrib_RewardRandomNeg_P1 = NumOfTrials_HighContrib_RewardRandomNeg_P1 + 1;
                SumQ1P1_HighContrib_RewardRandomNeg = SumQ1P1_HighContrib_RewardRandomNeg + ResultsQ1_player1(itrial);
                SumQ2P1_HighContrib_RewardRandomNeg = SumQ2P1_HighContrib_RewardRandomNeg + ResultsQ2_player1(itrial);
                SumQ1P2_LowContrib_RewardRandomPos = SumQ1P2_LowContrib_RewardRandomPos + ResultsQ1_player2(itrial);
                SumQ2P2_LowContrib_RewardRandomPos = SumQ2P2_LowContrib_RewardRandomPos + ResultsQ2_player2(itrial);
            elseif contribPlayer(itrial).P1 >= 0.55 & trials.blocReward(itrial) == 3 & trials.randomReward1(itrial) == 1 % congruency between motor contrib and random reward (high contrib player 1 and full reward) 
                NumOfTrials_HighContrib_RewardRandomPos_P1 = NumOfTrials_HighContrib_RewardRandomPos_P1 + 1;
                SumQ1P1_HighContrib_RewardRandomPos = SumQ1P1_HighContrib_RewardRandomPos + ResultsQ1_player1(itrial);
                SumQ2P1_HighContrib_RewardRandomPos = SumQ2P1_HighContrib_RewardRandomPos + ResultsQ2_player1(itrial);
                SumQ1P2_LowContrib_RewardRandomNeg = SumQ1P2_LowContrib_RewardRandomNeg + ResultsQ1_player2(itrial);
                SumQ2P2_LowContrib_RewardRandomNeg = SumQ2P2_LowContrib_RewardRandomNeg + ResultsQ2_player2(itrial);
                
            elseif contribPlayer(itrial).P2 >= 0.55 & trials.blocReward(itrial) == 1 % high contrib for player 1, low contrib for player 2 but shared reward
                NumOfTrials_HighContrib_RewardShared_P2 = NumOfTrials_HighContrib_RewardShared_P2 + 1;
                SumQ1P2_HighContrib_RewardShared = SumQ1P2_HighContrib_RewardShared + ResultsQ1_player2(itrial);
                SumQ2P2_HighContrib_RewardShared = SumQ2P2_HighContrib_RewardShared + ResultsQ2_player2(itrial);
                SumQ1P1_LowContrib_RewardShared = SumQ1P1_LowContrib_RewardShared + ResultsQ1_player1(itrial);
                SumQ2P1_LowContrib_RewardShared = SumQ2P1_LowContrib_RewardShared + ResultsQ2_player1(itrial);
            elseif contribPlayer(itrial).P2 >= 0.55 & trials.blocReward(itrial) == 2 % high contrib for player 1, low contrib for player 2 and reward linked to this contrib
                NumOfTrials_HighContrib_RewardContriPos_P2 = NumOfTrials_HighContrib_RewardContriPos_P2 + 1;
                SumQ1P2_HighContrib_RewardContriPos = SumQ1P2_HighContrib_RewardContriPos + ResultsQ1_player2(itrial);
                SumQ2P2_HighContrib_RewardContriPos = SumQ2P2_HighContrib_RewardContriPos + ResultsQ2_player2(itrial);
                SumQ1P1_LowContrib_RewardContriNeg = SumQ1P1_LowContrib_RewardContriNeg + ResultsQ1_player1(itrial);
                SumQ2P1_LowContrib_RewardContriNeg = SumQ2P1_LowContrib_RewardContriNeg + ResultsQ2_player1(itrial);
            elseif contribPlayer(itrial).P2 >= 0.55 & trials.blocReward(itrial) == 3 & trials.randomReward1(itrial) == 0 % incongruency between motor contrib and random reward (high contrib player 1 but no reward) 
                NumOfTrials_HighContrib_RewardRandomNeg_P2 = NumOfTrials_HighContrib_RewardRandomNeg_P2 + 1;
                SumQ1P2_HighContrib_RewardRandomNeg = SumQ1P2_HighContrib_RewardRandomNeg + ResultsQ1_player2(itrial);
                SumQ2P2_HighContrib_RewardRandomNeg = SumQ2P2_HighContrib_RewardRandomNeg + ResultsQ2_player2(itrial);
                SumQ1P1_LowContrib_RewardRandomPos = SumQ1P1_LowContrib_RewardRandomPos + ResultsQ1_player1(itrial);
                SumQ2P1_LowContrib_RewardRandomPos = SumQ2P1_LowContrib_RewardRandomPos + ResultsQ2_player1(itrial);
            elseif contribPlayer(itrial).P2 >= 0.55 & trials.blocReward(itrial) == 3 & trials.randomReward1(itrial) == 1 % congruency between motor contrib and random reward (high contrib player 1 and full reward) 
                NumOfTrials_HighContrib_RewardRandomPos_P2 = NumOfTrials_HighContrib_RewardRandomPos_P2 + 1;
                SumQ1P2_HighContrib_RewardRandomPos = SumQ1P2_HighContrib_RewardRandomPos + ResultsQ1_player2(itrial);
                SumQ2P2_HighContrib_RewardRandomPos = SumQ2P2_HighContrib_RewardRandomPos + ResultsQ2_player2(itrial);
                SumQ1P1_LowContrib_RewardRandomNeg = SumQ1P1_LowContrib_RewardRandomNeg + ResultsQ1_player1(itrial);
                SumQ2P1_LowContrib_RewardRandomNeg = SumQ2P1_LowContrib_RewardRandomNeg + ResultsQ2_player1(itrial);
            end
            
    end
           
end 

NumOfTrials_Easy_HighContrib_P1;
MeanQ1P1_Easy_HighContrib = SumQ1P1_Easy_HighContrib / NumOfTrials_Easy_HighContrib_P1;
MeanQ2P1_Easy_HighContrib = SumQ2P1_Easy_HighContrib / NumOfTrials_Easy_HighContrib_P1;
MeanQ1P2_Easy_LowContrib = SumQ1P2_Easy_LowContrib / NumOfTrials_Easy_HighContrib_P1;
MeanQ2P2_Easy_LowContrib = SumQ2P2_Easy_LowContrib / NumOfTrials_Easy_HighContrib_P1;

    NumOfTrials_Easy_HighContrib_RewardShared_P1;
    MeanQ1P1_Easy_HighContrib_RewardShared = SumQ1P1_Easy_HighContrib_RewardShared / NumOfTrials_Easy_HighContrib_RewardShared_P1;
    MeanQ2P1_Easy_HighContrib_RewardShared = SumQ2P1_Easy_HighContrib_RewardShared / NumOfTrials_Easy_HighContrib_RewardShared_P1;
    MeanQ1P2_Easy_LowContrib_RewardShared = SumQ1P2_Easy_LowContrib_RewardShared / NumOfTrials_Easy_HighContrib_RewardShared_P1;
    MeanQ2P2_Easy_LowContrib_RewardShared = SumQ2P2_Easy_LowContrib_RewardShared / NumOfTrials_Easy_HighContrib_RewardShared_P1; 

    NumOfTrials_Easy_HighContrib_RewardContriPos_P1;
    MeanQ1P1_Easy_HighContrib_RewardContriPos = SumQ1P1_Easy_HighContrib_RewardContriPos / NumOfTrials_Easy_HighContrib_RewardContriPos_P1;
    MeanQ2P1_Easy_HighContrib_RewardContriPos = SumQ2P1_Easy_HighContrib_RewardContriPos / NumOfTrials_Easy_HighContrib_RewardContriPos_P1;
    MeanQ1P2_Easy_LowContrib_RewardContriNeg = SumQ1P2_Easy_LowContrib_RewardContriNeg / NumOfTrials_Easy_HighContrib_RewardContriPos_P1;
    MeanQ2P2_Easy_LowContrib_RewardContriNeg = SumQ2P2_Easy_LowContrib_RewardContriNeg / NumOfTrials_Easy_HighContrib_RewardContriPos_P1;
    
    NumOfTrials_Easy_HighContrib_RewardRandom_P1;
    MeanQ1P1_Easy_HighContrib_RewardRandom = SumQ1P1_Easy_HighContrib_RewardRandom / NumOfTrials_Easy_HighContrib_RewardRandom_P1;
    MeanQ2P1_Easy_HighContrib_RewardRandom= SumQ2P1_Easy_HighContrib_RewardRandom / NumOfTrials_Easy_HighContrib_RewardRandom_P1;
    MeanQ1P2_Easy_LowContrib_RewardRandom = SumQ1P2_Easy_LowContrib_RewardRandom / NumOfTrials_Easy_HighContrib_RewardRandom_P1;
    MeanQ2P2_Easy_LowContrib_RewardRandom = SumQ2P2_Easy_LowContrib_RewardRandom / NumOfTrials_Easy_HighContrib_RewardRandom_P1;

    NumOfTrials_Easy_HighContrib_RewardRandomNeg_P1;
    MeanQ1P1_Easy_HighContrib_RewardRandomNeg = SumQ1P1_Easy_HighContrib_RewardRandomNeg / NumOfTrials_Easy_HighContrib_RewardRandomNeg_P1;
    MeanQ2P1_Easy_HighContrib_RewardRandomNeg = SumQ2P1_Easy_HighContrib_RewardRandomNeg / NumOfTrials_Easy_HighContrib_RewardRandomNeg_P1;
    MeanQ1P2_Easy_LowContrib_RewardRandomPos = SumQ1P2_Easy_LowContrib_RewardRandomPos / NumOfTrials_Easy_HighContrib_RewardRandomNeg_P1;
    MeanQ2P2_Easy_LowContrib_RewardRandomPos = SumQ2P2_Easy_LowContrib_RewardRandomPos / NumOfTrials_Easy_HighContrib_RewardRandomNeg_P1;

    NumOfTrials_Easy_HighContrib_RewardRandomPos_P1 ;
    MeanQ1P1_Easy_HighContrib_RewardRandomPos = SumQ1P1_Easy_HighContrib_RewardRandomPos / NumOfTrials_Easy_HighContrib_RewardRandomPos_P1;
    MeanQ2P1_Easy_HighContrib_RewardRandomPos = SumQ2P1_Easy_HighContrib_RewardRandomPos / NumOfTrials_Easy_HighContrib_RewardRandomPos_P1;
    MeanQ1P2_Easy_LowContrib_RewardRandomNeg = SumQ1P2_Easy_LowContrib_RewardRandomNeg / NumOfTrials_Easy_HighContrib_RewardRandomPos_P1;
    MeanQ2P2_Easy_LowContrib_RewardRandomNeg = SumQ2P2_Easy_LowContrib_RewardRandomNeg / NumOfTrials_Easy_HighContrib_RewardRandomPos_P1;

NumOfTrials_Easy_HighContrib_P2;
MeanQ1P2_Easy_HighContrib = SumQ1P2_Easy_HighContrib / NumOfTrials_Easy_HighContrib_P2;
MeanQ2P2_Easy_HighContrib = SumQ2P2_Easy_HighContrib / NumOfTrials_Easy_HighContrib_P2;
MeanQ1P1_Easy_LowContrib = SumQ1P1_Easy_LowContrib / NumOfTrials_Easy_HighContrib_P2;
MeanQ2P1_Easy_LowContrib = SumQ2P1_Easy_LowContrib / NumOfTrials_Easy_HighContrib_P2;


    NumOfTrials_Easy_HighContrib_RewardShared_P2;
    MeanQ1P2_Easy_HighContrib_RewardShared = SumQ1P2_Easy_HighContrib_RewardShared / NumOfTrials_Easy_HighContrib_RewardShared_P2;
    MeanQ2P2_Easy_HighContrib_RewardShared = SumQ2P2_Easy_HighContrib_RewardShared / NumOfTrials_Easy_HighContrib_RewardShared_P2;
    MeanQ1P1_Easy_LowContrib_RewardShared = SumQ1P1_Easy_LowContrib_RewardShared / NumOfTrials_Easy_HighContrib_RewardShared_P2;
    MeanQ2P1_Easy_LowContrib_RewardShared = SumQ2P1_Easy_LowContrib_RewardShared / NumOfTrials_Easy_HighContrib_RewardShared_P2;                    
                
    NumOfTrials_Easy_HighContrib_RewardContriPos_P2;
    MeanQ1P2_Easy_HighContrib_RewardContriPos = SumQ1P2_Easy_HighContrib_RewardContriPos / NumOfTrials_Easy_HighContrib_RewardContriPos_P2;
    MeanQ2P2_Easy_HighContrib_RewardContriPos = SumQ2P2_Easy_HighContrib_RewardContriPos / NumOfTrials_Easy_HighContrib_RewardContriPos_P2;
    MeanQ1P1_Easy_LowContrib_RewardContriNeg = SumQ1P1_Easy_LowContrib_RewardContriNeg / NumOfTrials_Easy_HighContrib_RewardContriPos_P2;
    MeanQ2P1_Easy_LowContrib_RewardContriNeg = SumQ2P1_Easy_LowContrib_RewardContriNeg / NumOfTrials_Easy_HighContrib_RewardContriPos_P2;
    
    NumOfTrials_Easy_HighContrib_RewardRandom_P2;
    MeanQ1P2_Easy_HighContrib_RewardRandom = SumQ1P2_Easy_HighContrib_RewardRandom / NumOfTrials_Easy_HighContrib_RewardRandom_P2;
    MeanQ2P2_Easy_HighContrib_RewardRandom = SumQ2P2_Easy_HighContrib_RewardRandom / NumOfTrials_Easy_HighContrib_RewardRandom_P2;
    MeanQ1P1_Easy_LowContrib_RewardRandom = SumQ1P1_Easy_LowContrib_RewardRandom / NumOfTrials_Easy_HighContrib_RewardRandom_P2;
    MeanQ2P1_Easy_LowContrib_RewardRandom = SumQ2P1_Easy_LowContrib_RewardRandom / NumOfTrials_Easy_HighContrib_RewardRandom_P2;
                
    NumOfTrials_Easy_HighContrib_RewardRandomNeg_P2 ;
    MeanQ1P2_Easy_HighContrib_RewardRandomNeg = SumQ1P2_Easy_HighContrib_RewardRandomNeg / NumOfTrials_Easy_HighContrib_RewardRandomNeg_P2;
    MeanQ2P2_Easy_HighContrib_RewardRandomNeg = SumQ2P2_Easy_HighContrib_RewardRandomNeg / NumOfTrials_Easy_HighContrib_RewardRandomNeg_P2;
    MeanQ1P1_Easy_LowContrib_RewardRandomPos = SumQ1P1_Easy_LowContrib_RewardRandomPos / NumOfTrials_Easy_HighContrib_RewardRandomNeg_P2;
    MeanQ2P1_Easy_LowContrib_RewardRandomPos = SumQ2P1_Easy_LowContrib_RewardRandomPos / NumOfTrials_Easy_HighContrib_RewardRandomNeg_P2;
                
    NumOfTrials_Easy_HighContrib_RewardRandomPos_P2 ;
    MeanQ1P2_Easy_HighContrib_RewardRandomPos = SumQ1P2_Easy_HighContrib_RewardRandomPos / NumOfTrials_Easy_HighContrib_RewardRandomPos_P2;
    MeanQ2P2_Easy_HighContrib_RewardRandomPos = SumQ2P2_Easy_HighContrib_RewardRandomPos / NumOfTrials_Easy_HighContrib_RewardRandomPos_P2;
    MeanQ1P1_Easy_LowContrib_RewardRandomNeg = SumQ1P1_Easy_LowContrib_RewardRandomNeg / NumOfTrials_Easy_HighContrib_RewardRandomPos_P2;
    MeanQ2P1_Easy_LowContrib_RewardRandomNeg = SumQ2P1_Easy_LowContrib_RewardRandomNeg / NumOfTrials_Easy_HighContrib_RewardRandomPos_P2;
    
NumOfTrials_Easy_SameContrib_P2 ;
MeanQ1P2_Easy_SameContrib = SumQ1P2_Easy_SameContrib / NumOfTrials_Easy_SameContrib_P2 ;
MeanQ2P2_Easy_SameContrib = SumQ2P2_Easy_SameContrib / NumOfTrials_Easy_SameContrib_P2 ;
MeanQ1P1_Easy_SameContrib = SumQ1P1_Easy_SameContrib / NumOfTrials_Easy_SameContrib_P2 ;
MeanQ2P1_Easy_SameContrib = SumQ2P1_Easy_SameContrib / NumOfTrials_Easy_SameContrib_P2 ;

    NumOfTrials_Easy_SameContrib_RewardShared_P1 ;
    MeanQ1P1_Easy_SameContrib_RewardShared = SumQ1P1_Easy_SameContrib_RewardShared / NumOfTrials_Easy_SameContrib_RewardShared_P1;
    MeanQ2P1_Easy_SameContrib_RewardShared = SumQ2P1_Easy_SameContrib_RewardShared / NumOfTrials_Easy_SameContrib_RewardShared_P1;
    MeanQ1P2_Easy_SameContrib_RewardShared = SumQ1P2_Easy_SameContrib_RewardShared / NumOfTrials_Easy_SameContrib_RewardShared_P1;
    MeanQ2P2_Easy_SameContrib_RewardShared = SumQ2P2_Easy_SameContrib_RewardShared / NumOfTrials_Easy_SameContrib_RewardShared_P1;                    
                
    NumOfTrials_Easy_SameContrib_RewardContri_P1 ;
    MeanQ1P1_Easy_SameContrib_RewardContri = SumQ1P1_Easy_SameContrib_RewardContri / NumOfTrials_Easy_SameContrib_RewardContri_P1;
    MeanQ2P1_Easy_SameContrib_RewardContri = SumQ2P1_Easy_SameContrib_RewardContri / NumOfTrials_Easy_SameContrib_RewardContri_P1 ;
    MeanQ1P2_Easy_SameContrib_RewardContri = SumQ1P2_Easy_SameContrib_RewardContri / NumOfTrials_Easy_SameContrib_RewardContri_P1;
    MeanQ2P2_Easy_SameContrib_RewardContri = SumQ2P2_Easy_SameContrib_RewardContri / NumOfTrials_Easy_SameContrib_RewardContri_P1;
    
    NumOfTrials_Easy_SameContrib_RewardRandom_P1;
    MeanQ1P1_Easy_SameContrib_RewardRandom = SumQ1P1_Easy_SameContrib_RewardRandom / NumOfTrials_Easy_SameContrib_RewardRandom_P1;
    MeanQ2P1_Easy_SameContrib_RewardRandom = SumQ2P1_Easy_SameContrib_RewardRandom / NumOfTrials_Easy_SameContrib_RewardRandom_P1;
    MeanQ1P2_Easy_SameContrib_RewardRandom = SumQ1P2_Easy_SameContrib_RewardRandom / NumOfTrials_Easy_SameContrib_RewardRandom_P1;
    MeanQ2P2_Easy_SameContrib_RewardRandom = SumQ2P2_Easy_SameContrib_RewardRandom / NumOfTrials_Easy_SameContrib_RewardRandom_P1;

    NumOfTrials_Easy_SameContrib_RewardRandomNeg_P1 ;
    MeanQ1P1_Easy_SameContrib_RewardRandomNeg = SumQ1P1_Easy_SameContrib_RewardRandomNeg / NumOfTrials_Easy_SameContrib_RewardRandomNeg_P1 ;
    MeanQ2P1_Easy_SameContrib_RewardRandomNeg = SumQ2P1_Easy_SameContrib_RewardRandomNeg / NumOfTrials_Easy_SameContrib_RewardRandomNeg_P1 ;
    MeanQ1P2_Easy_SameContrib_RewardRandomPos = SumQ1P2_Easy_SameContrib_RewardRandomPos / NumOfTrials_Easy_SameContrib_RewardRandomNeg_P1 ;
    MeanQ2P2_Easy_SameContrib_RewardRandomPos = SumQ2P2_Easy_SameContrib_RewardRandomPos / NumOfTrials_Easy_SameContrib_RewardRandomNeg_P1 ;

    NumOfTrials_Easy_SameContrib_RewardRandomPos_P1 ;
    MeanQ1P1_Easy_SameContrib_RewardRandomPos = SumQ1P1_Easy_SameContrib_RewardRandomPos / NumOfTrials_Easy_SameContrib_RewardRandomPos_P1 ;
    MeanQ2P1_Easy_SameContrib_RewardRandomPos = SumQ2P1_Easy_SameContrib_RewardRandomPos / NumOfTrials_Easy_SameContrib_RewardRandomPos_P1 ;
    MeanQ1P2_Easy_SameContrib_RewardRandomNeg = SumQ1P2_Easy_SameContrib_RewardRandomNeg / NumOfTrials_Easy_SameContrib_RewardRandomPos_P1 ;
    MeanQ2P2_Easy_SameContrib_RewardRandomNeg = SumQ2P2_Easy_SameContrib_RewardRandomNeg / NumOfTrials_Easy_SameContrib_RewardRandomPos_P1 ;
    
NumOfTrials_Hard_HighContrib_P1 ;
MeanQ1P1_Hard_HighContrib = SumQ1P1_Hard_HighContrib / NumOfTrials_Hard_HighContrib_P1;
MeanQ2P1_Hard_HighContrib = SumQ2P1_Hard_HighContrib / NumOfTrials_Hard_HighContrib_P1;
MeanQ1P2_Hard_LowContrib = SumQ1P2_Hard_LowContrib / NumOfTrials_Hard_HighContrib_P1;
MeanQ2P2_Hard_LowContrib = SumQ2P2_Hard_LowContrib / NumOfTrials_Hard_HighContrib_P1;
                
    NumOfTrials_Hard_HighContrib_RewardShared_P1 ;
    MeanQ1P1_Hard_HighContrib_RewardShared = SumQ1P1_Hard_HighContrib_RewardShared / NumOfTrials_Hard_HighContrib_RewardShared_P1;
    MeanQ2P1_Hard_HighContrib_RewardShared = SumQ2P1_Hard_HighContrib_RewardShared / NumOfTrials_Hard_HighContrib_RewardShared_P1;
    MeanQ1P2_Hard_LowContrib_RewardShared = SumQ1P2_Hard_LowContrib_RewardShared / NumOfTrials_Hard_HighContrib_RewardShared_P1;
    MeanQ2P2_Hard_LowContrib_RewardShared = SumQ2P2_Hard_LowContrib_RewardShared / NumOfTrials_Hard_HighContrib_RewardShared_P1;                    
                
    NumOfTrials_Hard_HighContrib_RewardContri_P1 ;
    MeanQ1P1_Hard_HighContrib_RewardContriPos = SumQ1P1_Hard_HighContrib_RewardContriPos / NumOfTrials_Hard_HighContrib_RewardContri_P1;
    MeanQ2P1_Hard_HighContrib_RewardContriPos = SumQ2P1_Hard_HighContrib_RewardContriPos / NumOfTrials_Hard_HighContrib_RewardContri_P1;
    MeanQ1P2_Hard_LowContrib_RewardContriNeg = SumQ1P2_Hard_LowContrib_RewardContriNeg / NumOfTrials_Hard_HighContrib_RewardContri_P1;
    MeanQ2P2_Hard_LowContrib_RewardContriNeg = SumQ2P2_Hard_LowContrib_RewardContriNeg / NumOfTrials_Hard_HighContrib_RewardContri_P1;
    
    NumOfTrials_Hard_HighContrib_RewardRandom_P1 ;
    MeanQ1P1_Hard_HighContrib_RewardRandom = SumQ1P1_Hard_HighContrib_RewardRandom / NumOfTrials_Hard_HighContrib_RewardRandom_P1;
    MeanQ2P1_Hard_HighContrib_RewardRandom = SumQ2P1_Hard_HighContrib_RewardRandom / NumOfTrials_Hard_HighContrib_RewardRandom_P1;
    MeanQ1P2_Hard_LowContrib_RewardRandom = SumQ1P2_Hard_LowContrib_RewardRandom / NumOfTrials_Hard_HighContrib_RewardRandom_P1;
    MeanQ2P2_Hard_LowContrib_RewardRandom = SumQ2P2_Hard_LowContrib_RewardRandom / NumOfTrials_Hard_HighContrib_RewardRandom_P1;
                
    NumOfTrials_Hard_HighContrib_RewardRandomNeg_P1 ;
    MeanQ1P1_Hard_HighContrib_RewardRandomNeg = SumQ1P1_Hard_HighContrib_RewardRandomNeg / NumOfTrials_Hard_HighContrib_RewardRandomNeg_P1;
    MeanQ2P1_Hard_HighContrib_RewardRandomNeg = SumQ2P1_Hard_HighContrib_RewardRandomNeg / NumOfTrials_Hard_HighContrib_RewardRandomNeg_P1;
    MeanQ1P2_Hard_LowContrib_RewardRandomPos = SumQ1P2_Hard_LowContrib_RewardRandomPos / NumOfTrials_Hard_HighContrib_RewardRandomNeg_P1;
    MeanQ2P2_Hard_LowContrib_RewardRandomPos = SumQ2P2_Hard_LowContrib_RewardRandomPos / NumOfTrials_Hard_HighContrib_RewardRandomNeg_P1;
                
    NumOfTrials_Hard_HighContrib_RewardRandomPos_P1 ;
    MeanQ1P1_Hard_HighContrib_RewardRandomPos = SumQ1P1_Hard_HighContrib_RewardRandomPos / NumOfTrials_Hard_HighContrib_RewardRandomPos_P1 ;
    MeanQ2P1_Hard_HighContrib_RewardRandomPos = SumQ2P1_Hard_HighContrib_RewardRandomPos / NumOfTrials_Hard_HighContrib_RewardRandomPos_P1;
    MeanQ1P2_Hard_LowContrib_RewardRandomNeg = SumQ1P2_Hard_LowContrib_RewardRandomNeg / NumOfTrials_Hard_HighContrib_RewardRandomPos_P1;
    MeanQ2P2_Hard_LowContrib_RewardRandomNeg = SumQ2P2_Hard_LowContrib_RewardRandomNeg / NumOfTrials_Hard_HighContrib_RewardRandomPos_P1;             
                
                
NumOfTrials_Hard_HighContrib_P2 ;
MeanQ1P2_Hard_HighContrib = SumQ1P2_Hard_HighContrib / NumOfTrials_Hard_HighContrib_P2;
MeanQ2P2_Hard_HighContrib = SumQ2P2_Hard_HighContrib / NumOfTrials_Hard_HighContrib_P2;
MeanQ1P1_Hard_LowContrib = SumQ1P1_Hard_LowContrib / NumOfTrials_Hard_HighContrib_P2;
MeanQ2P1_Hard_LowContrib = SumQ2P1_Hard_LowContrib / NumOfTrials_Hard_HighContrib_P2;
                
    NumOfTrials_Hard_HighContrib_RewardShared_P2 ;
    MeanQ1P2_Hard_HighContrib_RewardShared = SumQ1P2_Hard_HighContrib_RewardShared / NumOfTrials_Hard_HighContrib_RewardShared_P2 ;
    MeanQ2P2_Hard_HighContrib_RewardShared = SumQ2P2_Hard_HighContrib_RewardShared / NumOfTrials_Hard_HighContrib_RewardShared_P2 ;
    MeanQ1P1_Hard_LowContrib_RewardShared = SumQ1P1_Hard_LowContrib_RewardShared / NumOfTrials_Hard_HighContrib_RewardShared_P2 ;
    MeanQ2P1_Hard_LowContrib_RewardShared = SumQ2P1_Hard_LowContrib_RewardShared / NumOfTrials_Hard_HighContrib_RewardShared_P2 ;                    
                
    NumOfTrials_Hard_HighContrib_RewardContriPos_P2 ;
    MeanQ1P2_Hard_HighContrib_RewardContriPos = SumQ1P2_Hard_HighContrib_RewardContriPos / NumOfTrials_Hard_HighContrib_RewardContriPos_P2;
    MeanQ2P2_Hard_HighContrib_RewardContriPos = SumQ2P2_Hard_HighContrib_RewardContriPos / NumOfTrials_Hard_HighContrib_RewardContriPos_P2;
    MeanQ1P1_Hard_LowContrib_RewardContriNeg = SumQ1P1_Hard_LowContrib_RewardContriNeg / NumOfTrials_Hard_HighContrib_RewardContriPos_P2;
    MeanQ2P1_Hard_LowContrib_RewardContriNeg = SumQ2P1_Hard_LowContrib_RewardContriNeg / NumOfTrials_Hard_HighContrib_RewardContriPos_P2;
    
    NumOfTrials_Hard_HighContrib_RewardRandom_P2;
    MeanQ1P2_Hard_HighContrib_RewardRandom = SumQ1P2_Hard_HighContrib_RewardRandom / NumOfTrials_Hard_HighContrib_RewardRandom_P2;
    MeanQ2P2_Hard_HighContrib_RewardRandom = SumQ2P2_Hard_HighContrib_RewardRandom / NumOfTrials_Hard_HighContrib_RewardRandom_P2;
    MeanQ1P1_Hard_LowContrib_RewardRandom = SumQ1P1_Hard_LowContrib_RewardRandom / NumOfTrials_Hard_HighContrib_RewardRandom_P2;
    MeanQ2P1_Hard_LowContrib_RewardRandom = SumQ2P1_Hard_LowContrib_RewardRandom / NumOfTrials_Hard_HighContrib_RewardRandom_P2 ;

    NumOfTrials_Hard_HighContrib_RewardRandomNeg_P2 ;
    MeanQ1P2_Hard_HighContrib_RewardRandomNeg = SumQ1P2_Hard_HighContrib_RewardRandomNeg / NumOfTrials_Hard_HighContrib_RewardRandomNeg_P2 ;
    MeanQ2P2_Hard_HighContrib_RewardRandomNeg = SumQ2P2_Hard_HighContrib_RewardRandomNeg / NumOfTrials_Hard_HighContrib_RewardRandomNeg_P2;
    MeanQ1P1_Hard_LowContrib_RewardRandomPos = SumQ1P1_Hard_LowContrib_RewardRandomPos / NumOfTrials_Hard_HighContrib_RewardRandomNeg_P2 ;
    MeanQ2P1_Hard_LowContrib_RewardRandomPos = SumQ2P1_Hard_LowContrib_RewardRandomPos / NumOfTrials_Hard_HighContrib_RewardRandomNeg_P2 ;
                
    NumOfTrials_Hard_HighContrib_RewardRandomPos_P2 ;
    MeanQ1P2_Hard_HighContrib_RewardRandomPos = SumQ1P2_Hard_HighContrib_RewardRandomPos / NumOfTrials_Hard_HighContrib_RewardRandomPos_P2;
    MeanQ2P2_Hard_HighContrib_RewardRandomPos = SumQ2P2_Hard_HighContrib_RewardRandomPos / NumOfTrials_Hard_HighContrib_RewardRandomPos_P2;
    MeanQ1P1_Hard_LowContrib_RewardRandomNeg = SumQ1P1_Hard_LowContrib_RewardRandomNeg / NumOfTrials_Hard_HighContrib_RewardRandomPos_P2;
    MeanQ2P1_Hard_LowContrib_RewardRandomNeg = SumQ2P1_Hard_LowContrib_RewardRandomNeg / NumOfTrials_Hard_HighContrib_RewardRandomPos_P2;
                
                
NumOfTrials_Hard_SameContrib_P2 ;
MeanQ1P2_Hard_SameContrib = SumQ1P2_Hard_SameContrib / NumOfTrials_Hard_SameContrib_P2;
MeanQ2P2_Hard_SameContrib = SumQ2P2_Hard_SameContrib / NumOfTrials_Hard_SameContrib_P2;
MeanQ1P1_Hard_SameContrib = SumQ1P1_Hard_SameContrib / NumOfTrials_Hard_SameContrib_P2;
MeanQ2P1_Hard_SameContrib = SumQ2P1_Hard_SameContrib / NumOfTrials_Hard_SameContrib_P2;
                
                
    NumOfTrials_Hard_SameContrib_RewardShared_P1 ;
    MeanQ1P1_Hard_SameContrib_RewardShared = SumQ1P1_Hard_SameContrib_RewardShared / NumOfTrials_Hard_SameContrib_RewardShared_P1;
    MeanQ2P1_Hard_SameContrib_RewardShared = SumQ2P1_Hard_SameContrib_RewardShared / NumOfTrials_Hard_SameContrib_RewardShared_P1;
    MeanQ1P2_Hard_SameContrib_RewardShared = SumQ1P2_Hard_SameContrib_RewardShared / NumOfTrials_Hard_SameContrib_RewardShared_P1;
    MeanQ2P2_Hard_SameContrib_RewardShared = SumQ2P2_Hard_SameContrib_RewardShared / NumOfTrials_Hard_SameContrib_RewardShared_P1;                    

    NumOfTrials_Hard_SameContrib_RewardContriPos_P1 ;
    MeanQ1P1_Hard_SameContrib_RewardContri = SumQ1P1_Hard_SameContrib_RewardContri / NumOfTrials_Hard_SameContrib_RewardContriPos_P1;
    MeanQ2P1_Hard_SameContrib_RewardContri = SumQ2P1_Hard_SameContrib_RewardContri / NumOfTrials_Hard_SameContrib_RewardContriPos_P1;
    MeanQ1P2_Hard_SameContrib_RewardContri = SumQ1P2_Hard_SameContrib_RewardContri / NumOfTrials_Hard_SameContrib_RewardContriPos_P1;
    MeanQ2P2_Hard_SameContrib_RewardContri = SumQ2P2_Hard_SameContrib_RewardContri / NumOfTrials_Hard_SameContrib_RewardContriPos_P1;

    NumOfTrials_Hard_SameContrib_RewardRandom_P1 ;
    MeanQ1P1_Hard_SameContrib_RewardRandom = SumQ1P1_Hard_SameContrib_RewardRandom / NumOfTrials_Hard_SameContrib_RewardRandom_P1;
    MeanQ2P1_Hard_SameContrib_RewardRandom = SumQ2P1_Hard_SameContrib_RewardRandom / NumOfTrials_Hard_SameContrib_RewardRandom_P1;
    MeanQ1P2_Hard_SameContrib_RewardRandom = SumQ1P2_Hard_SameContrib_RewardRandom / NumOfTrials_Hard_SameContrib_RewardRandom_P1;
    MeanQ2P2_Hard_SameContrib_RewardRandom = SumQ2P2_Hard_SameContrib_RewardRandom / NumOfTrials_Hard_SameContrib_RewardRandom_P1;
    
    NumOfTrials_Hard_SameContrib_RewardRandomNeg_P1 ;
    MeanQ1P1_Hard_SameContrib_RewardRandomNeg = SumQ1P1_Hard_SameContrib_RewardRandomNeg / NumOfTrials_Hard_SameContrib_RewardRandomNeg_P1;
    MeanQ2P1_Hard_SameContrib_RewardRandomNeg = SumQ2P1_Hard_SameContrib_RewardRandomNeg / NumOfTrials_Hard_SameContrib_RewardRandomNeg_P1;
    MeanQ1P2_Hard_SameContrib_RewardRandomPos = SumQ1P2_Hard_SameContrib_RewardRandomPos / NumOfTrials_Hard_SameContrib_RewardRandomNeg_P1;
    MeanQ2P2_Hard_SameContrib_RewardRandomPos = SumQ2P2_Hard_SameContrib_RewardRandomPos / NumOfTrials_Hard_SameContrib_RewardRandomNeg_P1;

    NumOfTrials_Hard_SameContrib_RewardRandomPos_P1 ;
    MeanQ1P1_Hard_SameContrib_RewardRandomPos = SumQ1P1_Hard_SameContrib_RewardRandomPos / NumOfTrials_Hard_SameContrib_RewardRandomPos_P1 ;
    MeanQ2P1_Hard_SameContrib_RewardRandomPos = SumQ2P1_Hard_SameContrib_RewardRandomPos / NumOfTrials_Hard_SameContrib_RewardRandomPos_P1;
    MeanQ1P2_Hard_SameContrib_RewardRandomNeg = SumQ1P2_Hard_SameContrib_RewardRandomNeg / NumOfTrials_Hard_SameContrib_RewardRandomPos_P1;
    MeanQ2P2_Hard_SameContrib_RewardRandomNeg = SumQ2P2_Hard_SameContrib_RewardRandomNeg / NumOfTrials_Hard_SameContrib_RewardRandomPos_P1; 
    
fluency_contrib_data1 = [MeanQ1P1_Easy_HighContrib; MeanQ2P1_Easy_HighContrib; MeanQ1P1_Easy_LowContrib; MeanQ2P1_Easy_LowContrib; MeanQ1P1_Easy_SameContrib; MeanQ2P1_Easy_SameContrib; MeanQ1P1_Hard_HighContrib; MeanQ2P1_Hard_HighContrib; MeanQ1P1_Hard_LowContrib; MeanQ2P1_Hard_LowContrib; MeanQ1P1_Hard_SameContrib; MeanQ2P1_Hard_SameContrib]; 
fluency_contrib_data2 = [MeanQ1P2_Easy_HighContrib; MeanQ2P2_Easy_HighContrib; MeanQ1P2_Easy_LowContrib; MeanQ2P2_Easy_LowContrib; MeanQ1P2_Easy_SameContrib; MeanQ2P2_Easy_SameContrib; MeanQ1P2_Hard_HighContrib; MeanQ2P2_Hard_HighContrib; MeanQ1P2_Hard_LowContrib; MeanQ2P2_Hard_LowContrib; MeanQ1P2_Hard_SameContrib; MeanQ2P2_Hard_SameContrib]; 
Fluency_contrib_data1(ipar, :) = [fluency_contrib_data1]';
Fluency_contrib_data2(ipar, :) = [fluency_contrib_data2]';
% 
% fluency_contrib_reward_data1 = [MeanQ1P1_Easy_HighContrib_RewardShared; MeanQ2P1_Easy_HighContrib_RewardShared; MeanQ1P1_Easy_HighContrib_RewardContriPos; MeanQ2P1_Easy_HighContrib_RewardContriPos; MeanQ1P1_Easy_HighContrib_RewardRandom; MeanQ2P1_Easy_HighContrib_RewardRandom; MeanQ1P1_Easy_HighContrib_RewardRandomNeg; MeanQ2P1_Easy_HighContrib_RewardRandomNeg; MeanQ1P1_Easy_HighContrib_RewardRandomPos; MeanQ2P1_Easy_HighContrib_RewardRandomPos; MeanQ1P1_Easy_HighContrib_RewardShared; MeanQ2P1_Easy_HighContrib_RewardShared; MeanQ1P1_Easy_LowContrib_RewardContriNeg; MeanQ2P1_Easy_LowContrib_RewardContriNeg; MeanQ1P1_Easy_LowContrib_RewardRandom; MeanQ2P1_Easy_LowContrib_RewardRandom; MeanQ1P1_Easy_LowContrib_RewardRandomNeg; MeanQ2P1_Easy_LowContrib_RewardRandomNeg; MeanQ1P1_Easy_LowContrib_RewardRandomPos; MeanQ2P1_Easy_LowContrib_RewardRandomPos; MeanQ1P1_Easy_SameContrib_RewardShared; MeanQ2P1_Easy_SameContrib_RewardShared; MeanQ1P1_Easy_SameContrib_RewardContri; MeanQ2P1_Easy_SameContrib_RewardContri; MeanQ1P1_Easy_SameContrib_RewardRandom; MeanQ2P1_Easy_SameContrib_RewardRandom; MeanQ1P1_Easy_SameContrib_RewardRandomNeg; MeanQ2P1_Easy_SameContrib_RewardRandomNeg; MeanQ1P1_Easy_SameContrib_RewardRandomPos; MeanQ2P1_Easy_SameContrib_RewardRandomPos; MeanQ1P1_Hard_HighContrib_RewardShared; MeanQ2P1_Hard_HighContrib_RewardShared; MeanQ1P1_Hard_HighContrib_RewardContriPos; MeanQ2P1_Hard_HighContrib_RewardContriPos; MeanQ1P1_Hard_HighContrib_RewardRandom; MeanQ2P1_Hard_HighContrib_RewardRandom; MeanQ1P1_Hard_HighContrib_RewardRandomNeg; MeanQ2P1_Hard_HighContrib_RewardRandomNeg; MeanQ1P1_Hard_HighContrib_RewardRandomPos; MeanQ2P1_Hard_HighContrib_RewardRandomPos; MeanQ1P1_Hard_HighContrib_RewardShared; MeanQ2P1_Hard_HighContrib_RewardShared; MeanQ1P1_Hard_LowContrib_RewardContriNeg; MeanQ2P1_Hard_LowContrib_RewardContriNeg; MeanQ1P1_Hard_LowContrib_RewardRandom; MeanQ2P1_Hard_LowContrib_RewardRandom; MeanQ1P1_Hard_LowContrib_RewardRandomNeg; MeanQ2P1_Hard_LowContrib_RewardRandomNeg; MeanQ1P1_Hard_LowContrib_RewardRandomPos; MeanQ2P1_Hard_LowContrib_RewardRandomPos; MeanQ1P1_Hard_SameContrib_RewardShared; MeanQ2P1_Hard_SameContrib_RewardShared; MeanQ1P1_Hard_SameContrib_RewardContri; MeanQ2P1_Hard_SameContrib_RewardContri; MeanQ1P1_Hard_SameContrib_RewardRandom; MeanQ2P1_Hard_SameContrib_RewardRandom; MeanQ1P1_Hard_SameContrib_RewardRandomNeg; MeanQ2P1_Hard_SameContrib_RewardRandomNeg; MeanQ1P1_Hard_SameContrib_RewardRandomPos; MeanQ2P1_Hard_SameContrib_RewardRandomPos];
% fluency_contrib_reward_data2 = [MeanQ1P2_Easy_HighContrib_RewardShared; MeanQ2P2_Easy_HighContrib_RewardShared; MeanQ1P2_Easy_HighContrib_RewardContriPos; MeanQ2P2_Easy_HighContrib_RewardContriPos; MeanQ1P2_Easy_HighContrib_RewardRandom; MeanQ2P2_Easy_HighContrib_RewardRandom; MeanQ1P2_Easy_HighContrib_RewardRandomNeg; MeanQ2P2_Easy_HighContrib_RewardRandomNeg; MeanQ1P2_Easy_HighContrib_RewardRandomPos; MeanQ2P2_Easy_HighContrib_RewardRandomPos; MeanQ1P2_Easy_HighContrib_RewardShared; MeanQ2P2_Easy_HighContrib_RewardShared; MeanQ1P2_Easy_LowContrib_RewardContriNeg; MeanQ2P2_Easy_LowContrib_RewardContriNeg; MeanQ1P2_Easy_LowContrib_RewardRandom; MeanQ2P2_Easy_LowContrib_RewardRandom; MeanQ1P2_Easy_LowContrib_RewardRandomNeg; MeanQ2P2_Easy_LowContrib_RewardRandomNeg; MeanQ1P2_Easy_LowContrib_RewardRandomPos; MeanQ2P2_Easy_LowContrib_RewardRandomPos; MeanQ1P2_Easy_SameContrib_RewardShared; MeanQ2P2_Easy_SameContrib_RewardShared; MeanQ1P2_Easy_SameContrib_RewardContri; MeanQ2P2_Easy_SameContrib_RewardContri; MeanQ1P2_Easy_SameContrib_RewardRandom; MeanQ2P2_Easy_SameContrib_RewardRandom; MeanQ1P2_Easy_SameContrib_RewardRandomNeg; MeanQ2P2_Easy_SameContrib_RewardRandomNeg; MeanQ1P2_Easy_SameContrib_RewardRandomPos; MeanQ2P2_Easy_SameContrib_RewardRandomPos; MeanQ1P2_Hard_HighContrib_RewardShared; MeanQ2P2_Hard_HighContrib_RewardShared; MeanQ1P2_Hard_HighContrib_RewardContriPos; MeanQ2P2_Hard_HighContrib_RewardContriPos; MeanQ1P2_Hard_HighContrib_RewardRandom; MeanQ2P2_Hard_HighContrib_RewardRandom; MeanQ1P2_Hard_HighContrib_RewardRandomNeg; MeanQ2P2_Hard_HighContrib_RewardRandomNeg; MeanQ1P2_Hard_HighContrib_RewardRandomPos; MeanQ2P2_Hard_HighContrib_RewardRandomPos; MeanQ1P2_Hard_HighContrib_RewardShared; MeanQ2P2_Hard_HighContrib_RewardShared; MeanQ1P2_Hard_LowContrib_RewardContriNeg; MeanQ2P2_Hard_LowContrib_RewardContriNeg; MeanQ1P2_Hard_LowContrib_RewardRandom; MeanQ2P2_Hard_LowContrib_RewardRandom; MeanQ1P2_Hard_LowContrib_RewardRandomNeg; MeanQ2P2_Hard_LowContrib_RewardRandomNeg; MeanQ1P2_Hard_LowContrib_RewardRandomPos; MeanQ2P2_Hard_LowContrib_RewardRandomPos; MeanQ1P2_Hard_SameContrib_RewardShared; MeanQ2P2_Hard_SameContrib_RewardShared; MeanQ1P2_Hard_SameContrib_RewardContri; MeanQ2P2_Hard_SameContrib_RewardContri; MeanQ1P2_Hard_SameContrib_RewardRandom; MeanQ2P2_Hard_SameContrib_RewardRandom; MeanQ1P2_Hard_SameContrib_RewardRandomNeg; MeanQ2P2_Hard_SameContrib_RewardRandomNeg; MeanQ1P2_Hard_SameContrib_RewardRandomPos; MeanQ2P2_Hard_SameContrib_RewardRandomPos];
% fluency_contrib_reward_Data1 = [MeanQ1P1_Easy_HighContrib_RewardShared; MeanQ2P1_Easy_HighContrib_RewardShared; MeanQ1P1_Easy_HighContrib_RewardContriPos; MeanQ2P1_Easy_HighContrib_RewardContriPos; MeanQ1P1_Easy_HighContrib_RewardRandom; MeanQ2P1_Easy_HighContrib_RewardRandom; MeanQ1P1_Easy_HighContrib_RewardShared; MeanQ2P1_Easy_HighContrib_RewardShared; MeanQ1P1_Easy_LowContrib_RewardContriNeg; MeanQ2P1_Easy_LowContrib_RewardContriNeg; MeanQ1P1_Easy_LowContrib_RewardRandom; MeanQ2P1_Easy_LowContrib_RewardRandom; MeanQ1P1_Easy_SameContrib_RewardShared; MeanQ2P1_Easy_SameContrib_RewardShared; MeanQ1P1_Easy_SameContrib_RewardContri; MeanQ2P1_Easy_SameContrib_RewardContri; MeanQ1P1_Easy_SameContrib_RewardRandom; MeanQ2P1_Easy_SameContrib_RewardRandom; MeanQ1P1_Hard_HighContrib_RewardShared; MeanQ2P1_Hard_HighContrib_RewardShared; MeanQ1P1_Hard_HighContrib_RewardContriPos; MeanQ2P1_Hard_HighContrib_RewardContriPos; MeanQ1P1_Hard_HighContrib_RewardRandom; MeanQ2P1_Hard_HighContrib_RewardRandom; MeanQ1P1_Hard_HighContrib_RewardShared; MeanQ2P1_Hard_HighContrib_RewardShared; MeanQ1P1_Hard_LowContrib_RewardContriNeg; MeanQ2P1_Hard_LowContrib_RewardContriNeg; MeanQ1P1_Hard_LowContrib_RewardRandom; MeanQ2P1_Hard_LowContrib_RewardRandom; MeanQ1P1_Hard_SameContrib_RewardShared; MeanQ2P1_Hard_SameContrib_RewardShared; MeanQ1P1_Hard_SameContrib_RewardContri; MeanQ2P1_Hard_SameContrib_RewardContri; MeanQ1P1_Hard_SameContrib_RewardRandom; MeanQ2P1_Hard_SameContrib_RewardRandom];
% fluency_contrib_reward_Data2 = [MeanQ1P2_Easy_HighContrib_RewardShared; MeanQ2P2_Easy_HighContrib_RewardShared; MeanQ1P2_Easy_HighContrib_RewardContriPos; MeanQ2P2_Easy_HighContrib_RewardContriPos; MeanQ1P2_Easy_HighContrib_RewardRandom; MeanQ2P2_Easy_HighContrib_RewardRandom; MeanQ1P2_Easy_HighContrib_RewardShared; MeanQ2P2_Easy_HighContrib_RewardShared; MeanQ1P2_Easy_LowContrib_RewardContriNeg; MeanQ2P2_Easy_LowContrib_RewardContriNeg; MeanQ1P2_Easy_LowContrib_RewardRandom; MeanQ2P2_Easy_LowContrib_RewardRandom; MeanQ1P2_Easy_SameContrib_RewardShared; MeanQ2P2_Easy_SameContrib_RewardShared; MeanQ1P2_Easy_SameContrib_RewardContri; MeanQ2P2_Easy_SameContrib_RewardContri; MeanQ1P2_Easy_SameContrib_RewardRandom; MeanQ2P2_Easy_SameContrib_RewardRandom; MeanQ1P2_Hard_HighContrib_RewardShared; MeanQ2P2_Hard_HighContrib_RewardShared; MeanQ1P2_Hard_HighContrib_RewardContriPos; MeanQ2P2_Hard_HighContrib_RewardContriPos; MeanQ1P2_Hard_HighContrib_RewardRandom; MeanQ2P2_Hard_HighContrib_RewardRandom; MeanQ1P2_Hard_HighContrib_RewardShared; MeanQ2P2_Hard_HighContrib_RewardShared; MeanQ1P2_Hard_LowContrib_RewardContriNeg; MeanQ2P2_Hard_LowContrib_RewardContriNeg; MeanQ1P2_Hard_LowContrib_RewardRandom; MeanQ2P2_Hard_LowContrib_RewardRandom; MeanQ1P2_Hard_SameContrib_RewardShared; MeanQ2P2_Hard_SameContrib_RewardShared; MeanQ1P2_Hard_SameContrib_RewardContri; MeanQ2P2_Hard_SameContrib_RewardContri; MeanQ1P2_Hard_SameContrib_RewardRandom; MeanQ2P2_Hard_SameContrib_RewardRandom];

% fluency_contrib_reward_data1 = [MeanQ1P1_Easy_HighContrib_RewardShared; MeanQ2P1_Easy_HighContrib_RewardShared; MeanQ1P1_Easy_HighContrib_RewardContriPos; MeanQ2P1_Easy_HighContrib_RewardContriPos; MeanQ1P1_Easy_HighContrib_RewardRandom; MeanQ2P1_Easy_HighContrib_RewardRandom; MeanQ1P1_Easy_HighContrib_RewardRandomNeg; MeanQ2P1_Easy_HighContrib_RewardRandomNeg; MeanQ1P1_Easy_HighContrib_RewardRandomPos; MeanQ2P1_Easy_HighContrib_RewardRandomPos; MeanQ1P1_Easy_LowContrib_RewardShared; MeanQ2P1_Easy_LowContrib_RewardShared; MeanQ1P1_Easy_LowContrib_RewardContriNeg; MeanQ2P1_Easy_LowContrib_RewardContriNeg; MeanQ1P1_Easy_LowContrib_RewardRandom; MeanQ2P1_Easy_LowContrib_RewardRandom; MeanQ1P1_Easy_LowContrib_RewardRandomNeg; MeanQ2P1_Easy_LowContrib_RewardRandomNeg; MeanQ1P1_Easy_LowContrib_RewardRandomPos; MeanQ2P1_Easy_LowContrib_RewardRandomPos; MeanQ1P1_Easy_SameContrib_RewardShared; MeanQ2P1_Easy_SameContrib_RewardShared; MeanQ1P1_Easy_SameContrib_RewardContri; MeanQ2P1_Easy_SameContrib_RewardContri; MeanQ1P1_Easy_SameContrib_RewardRandom; MeanQ2P1_Easy_SameContrib_RewardRandom; MeanQ1P1_Easy_SameContrib_RewardRandomNeg; MeanQ2P1_Easy_SameContrib_RewardRandomNeg; MeanQ1P1_Easy_SameContrib_RewardRandomPos; MeanQ2P1_Easy_SameContrib_RewardRandomPos; MeanQ1P1_Hard_HighContrib_RewardContriPos; MeanQ2P1_Hard_HighContrib_RewardContriPos; MeanQ1P1_Hard_HighContrib_RewardRandom; MeanQ2P1_Hard_HighContrib_RewardRandom; MeanQ1P1_Hard_HighContrib_RewardRandomNeg; MeanQ2P1_Hard_HighContrib_RewardRandomNeg; MeanQ1P1_Hard_HighContrib_RewardRandomPos; MeanQ2P1_Hard_HighContrib_RewardRandomPos; MeanQ1P1_Hard_HighContrib_RewardShared; MeanQ2P1_Hard_HighContrib_RewardShared; MeanQ1P1_Hard_LowContrib_RewardShared; MeanQ2P1_Hard_LowContrib_RewardShared; MeanQ1P1_Hard_LowContrib_RewardContriNeg; MeanQ2P1_Hard_LowContrib_RewardContriNeg; MeanQ1P1_Hard_LowContrib_RewardRandom; MeanQ2P1_Hard_LowContrib_RewardRandom; MeanQ1P1_Hard_LowContrib_RewardRandomNeg; MeanQ2P1_Hard_LowContrib_RewardRandomNeg; MeanQ1P1_Hard_LowContrib_RewardRandomPos; MeanQ2P1_Hard_LowContrib_RewardRandomPos; MeanQ1P1_Hard_SameContrib_RewardShared; MeanQ2P1_Hard_SameContrib_RewardShared; MeanQ1P1_Hard_SameContrib_RewardContri; MeanQ2P1_Hard_SameContrib_RewardContri; MeanQ1P1_Hard_SameContrib_RewardRandom; MeanQ2P1_Hard_SameContrib_RewardRandom; MeanQ1P1_Hard_SameContrib_RewardRandomNeg; MeanQ2P1_Hard_SameContrib_RewardRandomNeg; MeanQ1P1_Hard_SameContrib_RewardRandomPos; MeanQ2P1_Hard_SameContrib_RewardRandomPos];
% fluency_contrib_reward_data2 = [MeanQ1P2_Easy_HighContrib_RewardShared; MeanQ2P2_Easy_HighContrib_RewardShared; MeanQ1P2_Easy_HighContrib_RewardContriPos; MeanQ2P2_Easy_HighContrib_RewardContriPos; MeanQ1P2_Easy_HighContrib_RewardRandom; MeanQ2P2_Easy_HighContrib_RewardRandom; MeanQ1P2_Easy_HighContrib_RewardRandomNeg; MeanQ2P2_Easy_HighContrib_RewardRandomNeg; MeanQ1P2_Easy_HighContrib_RewardRandomPos; MeanQ2P2_Easy_HighContrib_RewardRandomPos; MeanQ1P2_Easy_LowContrib_RewardShared; MeanQ2P2_Easy_LowContrib_RewardShared; MeanQ1P2_Easy_LowContrib_RewardContriNeg; MeanQ2P2_Easy_LowContrib_RewardContriNeg; MeanQ1P2_Easy_LowContrib_RewardRandom; MeanQ2P2_Easy_LowContrib_RewardRandom; MeanQ1P2_Easy_LowContrib_RewardRandomNeg; MeanQ2P2_Easy_LowContrib_RewardRandomNeg; MeanQ1P2_Easy_LowContrib_RewardRandomPos; MeanQ2P2_Easy_LowContrib_RewardRandomPos; MeanQ1P2_Easy_SameContrib_RewardShared; MeanQ2P2_Easy_SameContrib_RewardShared; MeanQ1P2_Easy_SameContrib_RewardContri; MeanQ2P2_Easy_SameContrib_RewardContri; MeanQ1P2_Easy_SameContrib_RewardRandom; MeanQ2P2_Easy_SameContrib_RewardRandom; MeanQ1P2_Easy_SameContrib_RewardRandomNeg; MeanQ2P2_Easy_SameContrib_RewardRandomNeg; MeanQ1P2_Easy_SameContrib_RewardRandomPos; MeanQ2P2_Easy_SameContrib_RewardRandomPos; MeanQ1P2_Hard_HighContrib_RewardContriPos; MeanQ2P2_Hard_HighContrib_RewardContriPos; MeanQ1P2_Hard_HighContrib_RewardRandom; MeanQ2P2_Hard_HighContrib_RewardRandom; MeanQ1P2_Hard_HighContrib_RewardRandomNeg; MeanQ2P2_Hard_HighContrib_RewardRandomNeg; MeanQ1P2_Hard_HighContrib_RewardRandomPos; MeanQ2P2_Hard_HighContrib_RewardRandomPos; MeanQ1P2_Hard_HighContrib_RewardShared; MeanQ2P2_Hard_HighContrib_RewardShared; MeanQ1P2_Hard_LowContrib_RewardShared; MeanQ2P2_Hard_LowContrib_RewardShared; MeanQ1P2_Hard_LowContrib_RewardContriNeg; MeanQ2P2_Hard_LowContrib_RewardContriNeg; MeanQ1P2_Hard_LowContrib_RewardRandom; MeanQ2P2_Hard_LowContrib_RewardRandom; MeanQ1P2_Hard_LowContrib_RewardRandomNeg; MeanQ2P2_Hard_LowContrib_RewardRandomNeg; MeanQ1P2_Hard_LowContrib_RewardRandomPos; MeanQ2P2_Hard_LowContrib_RewardRandomPos; MeanQ1P2_Hard_SameContrib_RewardShared; MeanQ2P2_Hard_SameContrib_RewardShared; MeanQ1P2_Hard_SameContrib_RewardContri; MeanQ2P2_Hard_SameContrib_RewardContri; MeanQ1P2_Hard_SameContrib_RewardRandom; MeanQ2P2_Hard_SameContrib_RewardRandom; MeanQ1P2_Hard_SameContrib_RewardRandomNeg; MeanQ2P2_Hard_SameContrib_RewardRandomNeg; MeanQ1P2_Hard_SameContrib_RewardRandomPos; MeanQ2P2_Hard_SameContrib_RewardRandomPos];
% fluency_contrib_reward_Data1 = [MeanQ1P1_Easy_HighContrib_RewardShared; MeanQ2P1_Easy_HighContrib_RewardShared; MeanQ1P1_Easy_HighContrib_RewardContriPos; MeanQ2P1_Easy_HighContrib_RewardContriPos; MeanQ1P1_Easy_HighContrib_RewardRandom; MeanQ2P1_Easy_HighContrib_RewardRandom; MeanQ1P1_Easy_LowContrib_RewardShared; MeanQ2P1_Easy_LowContrib_RewardShared; MeanQ1P1_Easy_LowContrib_RewardContriNeg; MeanQ2P1_Easy_LowContrib_RewardContriNeg; MeanQ1P1_Easy_LowContrib_RewardRandom; MeanQ2P1_Easy_LowContrib_RewardRandom; MeanQ1P1_Easy_SameContrib_RewardShared; MeanQ2P1_Easy_SameContrib_RewardShared; MeanQ1P1_Easy_SameContrib_RewardContri; MeanQ2P1_Easy_SameContrib_RewardContri; MeanQ1P1_Easy_SameContrib_RewardRandom; MeanQ2P1_Easy_SameContrib_RewardRandom; MeanQ1P1_Hard_HighContrib_RewardShared; MeanQ2P1_Hard_HighContrib_RewardShared; MeanQ1P1_Hard_HighContrib_RewardContriPos; MeanQ2P1_Hard_HighContrib_RewardContriPos; MeanQ1P1_Hard_HighContrib_RewardRandom; MeanQ2P1_Hard_HighContrib_RewardRandom; MeanQ1P1_Hard_LowContrib_RewardShared; MeanQ2P1_Hard_LowContrib_RewardShared; MeanQ1P1_Hard_LowContrib_RewardContriNeg; MeanQ2P1_Hard_LowContrib_RewardContriNeg; MeanQ1P1_Hard_LowContrib_RewardRandom; MeanQ2P1_Hard_LowContrib_RewardRandom; MeanQ1P1_Hard_SameContrib_RewardShared; MeanQ2P1_Hard_SameContrib_RewardShared; MeanQ1P1_Hard_SameContrib_RewardContri; MeanQ2P1_Hard_SameContrib_RewardContri; MeanQ1P1_Hard_SameContrib_RewardRandom; MeanQ2P1_Hard_SameContrib_RewardRandom];
% fluency_contrib_reward_Data2 = [MeanQ1P2_Easy_HighContrib_RewardShared; MeanQ2P2_Easy_HighContrib_RewardShared; MeanQ1P2_Easy_HighContrib_RewardContriPos; MeanQ2P2_Easy_HighContrib_RewardContriPos; MeanQ1P2_Easy_HighContrib_RewardRandom; MeanQ2P2_Easy_HighContrib_RewardRandom; MeanQ1P2_Easy_LowContrib_RewardShared; MeanQ2P2_Easy_LowContrib_RewardShared; MeanQ1P2_Easy_LowContrib_RewardContriNeg; MeanQ2P2_Easy_LowContrib_RewardContriNeg; MeanQ1P2_Easy_LowContrib_RewardRandom; MeanQ2P2_Easy_LowContrib_RewardRandom; MeanQ1P2_Easy_SameContrib_RewardShared; MeanQ2P2_Easy_SameContrib_RewardShared; MeanQ1P2_Easy_SameContrib_RewardContri; MeanQ2P2_Easy_SameContrib_RewardContri; MeanQ1P2_Easy_SameContrib_RewardRandom; MeanQ2P2_Easy_SameContrib_RewardRandom; MeanQ1P2_Hard_HighContrib_RewardShared; MeanQ2P2_Hard_HighContrib_RewardShared; MeanQ1P2_Hard_HighContrib_RewardContriPos; MeanQ2P2_Hard_HighContrib_RewardContriPos; MeanQ1P2_Hard_HighContrib_RewardRandom; MeanQ2P2_Hard_HighContrib_RewardRandom; MeanQ1P2_Hard_LowContrib_RewardShared; MeanQ2P2_Hard_LowContrib_RewardShared; MeanQ1P2_Hard_LowContrib_RewardContriNeg; MeanQ2P2_Hard_LowContrib_RewardContriNeg; MeanQ1P2_Hard_LowContrib_RewardRandom; MeanQ2P2_Hard_LowContrib_RewardRandom; MeanQ1P2_Hard_SameContrib_RewardShared; MeanQ2P2_Hard_SameContrib_RewardShared; MeanQ1P2_Hard_SameContrib_RewardContri; MeanQ2P2_Hard_SameContrib_RewardContri; MeanQ1P2_Hard_SameContrib_RewardRandom; MeanQ2P2_Hard_SameContrib_RewardRandom];

fluency_contrib_reward_data1 = [MeanQ1P1_Easy_HighContrib_RewardShared; MeanQ2P1_Easy_HighContrib_RewardShared; MeanQ1P1_Easy_HighContrib_RewardContriPos; MeanQ2P1_Easy_HighContrib_RewardContriPos; MeanQ1P1_Easy_HighContrib_RewardRandom; MeanQ2P1_Easy_HighContrib_RewardRandom; MeanQ1P1_Easy_HighContrib_RewardRandomNeg; MeanQ2P1_Easy_HighContrib_RewardRandomNeg; MeanQ1P1_Easy_HighContrib_RewardRandomPos; MeanQ2P1_Easy_HighContrib_RewardRandomPos; MeanQ1P1_Easy_LowContrib_RewardShared; MeanQ2P1_Easy_LowContrib_RewardShared; MeanQ1P1_Easy_LowContrib_RewardContriNeg; MeanQ2P1_Easy_LowContrib_RewardContriNeg; MeanQ1P1_Easy_LowContrib_RewardRandom; MeanQ2P1_Easy_LowContrib_RewardRandom; MeanQ1P1_Easy_LowContrib_RewardRandomNeg; MeanQ2P1_Easy_LowContrib_RewardRandomNeg; MeanQ1P1_Easy_LowContrib_RewardRandomPos; MeanQ2P1_Easy_LowContrib_RewardRandomPos; MeanQ1P1_Easy_SameContrib_RewardShared; MeanQ2P1_Easy_SameContrib_RewardShared; MeanQ1P1_Easy_SameContrib_RewardContri; MeanQ2P1_Easy_SameContrib_RewardContri; MeanQ1P1_Easy_SameContrib_RewardRandom; MeanQ2P1_Easy_SameContrib_RewardRandom; MeanQ1P1_Easy_SameContrib_RewardRandomNeg; MeanQ2P1_Easy_SameContrib_RewardRandomNeg; MeanQ1P1_Easy_SameContrib_RewardRandomPos; MeanQ2P1_Easy_SameContrib_RewardRandomPos; MeanQ1P1_Hard_HighContrib_RewardShared; MeanQ2P1_Hard_HighContrib_RewardShared; MeanQ1P1_Hard_HighContrib_RewardContriPos; MeanQ2P1_Hard_HighContrib_RewardContriPos; MeanQ1P1_Hard_HighContrib_RewardRandom; MeanQ2P1_Hard_HighContrib_RewardRandom; MeanQ1P1_Hard_HighContrib_RewardRandomNeg; MeanQ2P1_Hard_HighContrib_RewardRandomNeg; MeanQ1P1_Hard_HighContrib_RewardRandomPos; MeanQ2P1_Hard_HighContrib_RewardRandomPos; MeanQ1P1_Hard_HighContrib_RewardShared; MeanQ2P1_Hard_HighContrib_RewardShared; MeanQ1P1_Hard_LowContrib_RewardShared; MeanQ2P1_Hard_LowContrib_RewardShared; MeanQ1P1_Hard_LowContrib_RewardContriNeg; MeanQ2P1_Hard_LowContrib_RewardContriNeg; MeanQ1P1_Hard_LowContrib_RewardRandom; MeanQ2P1_Hard_LowContrib_RewardRandom; MeanQ1P1_Hard_LowContrib_RewardRandomNeg; MeanQ2P1_Hard_LowContrib_RewardRandomNeg; MeanQ1P1_Hard_LowContrib_RewardRandomPos; MeanQ2P1_Hard_LowContrib_RewardRandomPos; MeanQ1P1_Hard_SameContrib_RewardShared; MeanQ2P1_Hard_SameContrib_RewardShared; MeanQ1P1_Hard_SameContrib_RewardContri; MeanQ2P1_Hard_SameContrib_RewardContri; MeanQ1P1_Hard_SameContrib_RewardRandom; MeanQ2P1_Hard_SameContrib_RewardRandom; MeanQ1P1_Hard_SameContrib_RewardRandomNeg; MeanQ2P1_Hard_SameContrib_RewardRandomNeg; MeanQ1P1_Hard_SameContrib_RewardRandomPos; MeanQ2P1_Hard_SameContrib_RewardRandomPos];
fluency_contrib_reward_data2 = [MeanQ1P2_Easy_HighContrib_RewardShared; MeanQ2P2_Easy_HighContrib_RewardShared; MeanQ1P2_Easy_HighContrib_RewardContriPos; MeanQ2P2_Easy_HighContrib_RewardContriPos; MeanQ1P2_Easy_HighContrib_RewardRandom; MeanQ2P2_Easy_HighContrib_RewardRandom; MeanQ1P2_Easy_HighContrib_RewardRandomNeg; MeanQ2P2_Easy_HighContrib_RewardRandomNeg; MeanQ1P2_Easy_HighContrib_RewardRandomPos; MeanQ2P2_Easy_HighContrib_RewardRandomPos; MeanQ1P2_Easy_LowContrib_RewardShared; MeanQ2P2_Easy_LowContrib_RewardShared; MeanQ1P2_Easy_LowContrib_RewardContriNeg; MeanQ2P2_Easy_LowContrib_RewardContriNeg; MeanQ1P2_Easy_LowContrib_RewardRandom; MeanQ2P2_Easy_LowContrib_RewardRandom; MeanQ1P2_Easy_LowContrib_RewardRandomNeg; MeanQ2P2_Easy_LowContrib_RewardRandomNeg; MeanQ1P2_Easy_LowContrib_RewardRandomPos; MeanQ2P2_Easy_LowContrib_RewardRandomPos; MeanQ1P2_Easy_SameContrib_RewardShared; MeanQ2P2_Easy_SameContrib_RewardShared; MeanQ1P2_Easy_SameContrib_RewardContri; MeanQ2P2_Easy_SameContrib_RewardContri; MeanQ1P2_Easy_SameContrib_RewardRandom; MeanQ2P2_Easy_SameContrib_RewardRandom; MeanQ1P2_Easy_SameContrib_RewardRandomNeg; MeanQ2P2_Easy_SameContrib_RewardRandomNeg; MeanQ1P2_Easy_SameContrib_RewardRandomPos; MeanQ2P2_Easy_SameContrib_RewardRandomPos; MeanQ1P2_Hard_HighContrib_RewardShared; MeanQ2P2_Hard_HighContrib_RewardShared; MeanQ1P2_Hard_HighContrib_RewardContriPos; MeanQ2P2_Hard_HighContrib_RewardContriPos; MeanQ1P2_Hard_HighContrib_RewardRandom; MeanQ2P2_Hard_HighContrib_RewardRandom; MeanQ1P2_Hard_HighContrib_RewardRandomNeg; MeanQ2P2_Hard_HighContrib_RewardRandomNeg; MeanQ1P2_Hard_HighContrib_RewardRandomPos; MeanQ2P2_Hard_HighContrib_RewardRandomPos; MeanQ1P2_Hard_HighContrib_RewardShared; MeanQ2P2_Hard_HighContrib_RewardShared; MeanQ1P2_Hard_LowContrib_RewardShared; MeanQ2P2_Hard_LowContrib_RewardShared; MeanQ1P2_Hard_LowContrib_RewardContriNeg; MeanQ2P2_Hard_LowContrib_RewardContriNeg; MeanQ1P2_Hard_LowContrib_RewardRandom; MeanQ2P2_Hard_LowContrib_RewardRandom; MeanQ1P2_Hard_LowContrib_RewardRandomNeg; MeanQ2P2_Hard_LowContrib_RewardRandomNeg; MeanQ1P2_Hard_LowContrib_RewardRandomPos; MeanQ2P2_Hard_LowContrib_RewardRandomPos; MeanQ1P2_Hard_SameContrib_RewardShared; MeanQ2P2_Hard_SameContrib_RewardShared; MeanQ1P2_Hard_SameContrib_RewardContri; MeanQ2P2_Hard_SameContrib_RewardContri; MeanQ1P2_Hard_SameContrib_RewardRandom; MeanQ2P2_Hard_SameContrib_RewardRandom; MeanQ1P2_Hard_SameContrib_RewardRandomNeg; MeanQ2P2_Hard_SameContrib_RewardRandomNeg; MeanQ1P2_Hard_SameContrib_RewardRandomPos; MeanQ2P2_Hard_SameContrib_RewardRandomPos]
fluency_contrib_reward_Data1 = [MeanQ1P1_Easy_HighContrib_RewardShared; MeanQ2P1_Easy_HighContrib_RewardShared; MeanQ1P1_Easy_HighContrib_RewardContriPos; MeanQ2P1_Easy_HighContrib_RewardContriPos; MeanQ1P1_Easy_HighContrib_RewardRandom; MeanQ2P1_Easy_HighContrib_RewardRandom; MeanQ1P1_Easy_LowContrib_RewardShared; MeanQ2P1_Easy_LowContrib_RewardShared; MeanQ1P1_Easy_LowContrib_RewardContriNeg; MeanQ2P1_Easy_LowContrib_RewardContriNeg; MeanQ1P1_Easy_LowContrib_RewardRandom; MeanQ2P1_Easy_LowContrib_RewardRandom; MeanQ1P1_Easy_SameContrib_RewardShared; MeanQ2P1_Easy_SameContrib_RewardShared; MeanQ1P1_Easy_SameContrib_RewardContri; MeanQ2P1_Easy_SameContrib_RewardContri; MeanQ1P1_Easy_SameContrib_RewardRandom; MeanQ2P1_Easy_SameContrib_RewardRandom; MeanQ1P1_Hard_HighContrib_RewardShared; MeanQ2P1_Hard_HighContrib_RewardShared; MeanQ1P1_Hard_HighContrib_RewardContriPos; MeanQ2P1_Hard_HighContrib_RewardContriPos; MeanQ1P1_Hard_HighContrib_RewardRandom; MeanQ2P1_Hard_HighContrib_RewardRandom; MeanQ1P1_Hard_LowContrib_RewardShared; MeanQ2P1_Hard_LowContrib_RewardShared; MeanQ1P1_Hard_LowContrib_RewardContriNeg; MeanQ2P1_Hard_LowContrib_RewardContriNeg; MeanQ1P1_Hard_LowContrib_RewardRandom; MeanQ2P1_Hard_LowContrib_RewardRandom; MeanQ1P1_Hard_SameContrib_RewardShared; MeanQ2P1_Hard_SameContrib_RewardShared; MeanQ1P1_Hard_SameContrib_RewardContri; MeanQ2P1_Hard_SameContrib_RewardContri; MeanQ1P1_Hard_SameContrib_RewardRandom; MeanQ2P1_Hard_SameContrib_RewardRandom];
fluency_contrib_reward_Data2 = [MeanQ1P2_Easy_HighContrib_RewardShared; MeanQ2P2_Easy_HighContrib_RewardShared; MeanQ1P2_Easy_HighContrib_RewardContriPos; MeanQ2P2_Easy_HighContrib_RewardContriPos; MeanQ1P2_Easy_HighContrib_RewardRandom; MeanQ2P2_Easy_HighContrib_RewardRandom; MeanQ1P2_Easy_LowContrib_RewardShared; MeanQ2P2_Easy_LowContrib_RewardShared; MeanQ1P2_Easy_LowContrib_RewardContriNeg; MeanQ2P2_Easy_LowContrib_RewardContriNeg; MeanQ1P2_Easy_LowContrib_RewardRandom; MeanQ2P2_Easy_LowContrib_RewardRandom; MeanQ1P2_Easy_SameContrib_RewardShared; MeanQ2P2_Easy_SameContrib_RewardShared; MeanQ1P2_Easy_SameContrib_RewardContri; MeanQ2P2_Easy_SameContrib_RewardContri; MeanQ1P2_Easy_SameContrib_RewardRandom; MeanQ2P2_Easy_SameContrib_RewardRandom; MeanQ1P2_Hard_HighContrib_RewardShared; MeanQ2P2_Hard_HighContrib_RewardShared; MeanQ1P2_Hard_HighContrib_RewardContriPos; MeanQ2P2_Hard_HighContrib_RewardContriPos; MeanQ1P2_Hard_HighContrib_RewardRandom; MeanQ2P2_Hard_HighContrib_RewardRandom; MeanQ1P2_Hard_LowContrib_RewardShared; MeanQ2P2_Hard_LowContrib_RewardShared; MeanQ1P2_Hard_LowContrib_RewardContriNeg; MeanQ2P2_Hard_LowContrib_RewardContriNeg; MeanQ1P2_Hard_LowContrib_RewardRandom; MeanQ2P2_Hard_LowContrib_RewardRandom; MeanQ1P2_Hard_SameContrib_RewardShared; MeanQ2P2_Hard_SameContrib_RewardShared; MeanQ1P2_Hard_SameContrib_RewardContri; MeanQ2P2_Hard_SameContrib_RewardContri; MeanQ1P2_Hard_SameContrib_RewardRandom; MeanQ2P2_Hard_SameContrib_RewardRandom];


Triple_Interactions_behav1(ipar, :) = [fluency_contrib_reward_data1];
Triple_Interactions_behav2(ipar, :) = [fluency_contrib_reward_data2];
Triple_Interactions_Behav1(ipar, :) = [fluency_contrib_reward_Data1];
Triple_Interactions_Behav2(ipar, :) = [fluency_contrib_reward_Data2];

Full_Behav_table = [Triple_Interactions_behav1; Triple_Interactions_behav2];


NumOfTrials_Easy_RewardShared_P1 ;
MeanQ1P1_Easy_RewardShared = SumQ1P1_Easy_RewardShared / NumOfTrials_Easy_RewardShared_P1;
MeanQ2P1_Easy_RewardShared = SumQ2P1_Easy_RewardShared / NumOfTrials_Easy_RewardShared_P1;
MeanQ1P2_Easy_RewardShared = SumQ1P2_Easy_RewardShared / NumOfTrials_Easy_RewardShared_P1;
MeanQ2P2_Easy_RewardShared = SumQ2P2_Easy_RewardShared / NumOfTrials_Easy_RewardShared_P1;

NumOfTrials_Easy_RewardContriPos_P1 ;
MeanQ1P1_Easy_RewardContriPos = SumQ1P1_Easy_RewardContriPos / NumOfTrials_Easy_RewardContriPos_P1;
MeanQ2P1_Easy_RewardContriPos = SumQ2P1_Easy_RewardContriPos / NumOfTrials_Easy_RewardContriPos_P1;
MeanQ1P2_Easy_RewardContriNeg = SumQ1P2_Easy_RewardContriNeg / NumOfTrials_Easy_RewardContriPos_P1;
MeanQ2P2_Easy_RewardContriNeg = SumQ2P2_Easy_RewardContriNeg / NumOfTrials_Easy_RewardContriPos_P1;    

NumOfTrials_Easy_RewardContriPos_P2 ;
MeanQ1P2_Easy_RewardContriPos = SumQ1P2_Easy_RewardContriPos / NumOfTrials_Easy_RewardContriPos_P2 ;
MeanQ2P2_Easy_RewardContriPos = SumQ2P2_Easy_RewardContriPos / NumOfTrials_Easy_RewardContriPos_P2;
MeanQ1P1_Easy_RewardContriNeg = SumQ1P1_Easy_RewardContriNeg / NumOfTrials_Easy_RewardContriPos_P2;
MeanQ2P1_Easy_RewardContriNeg = SumQ2P1_Easy_RewardContriNeg / NumOfTrials_Easy_RewardContriPos_P2;

NumOfTrials_Easy_RewardRandomPos_P1;
MeanQ1P1_Easy_RewardRandomPos = SumQ1P1_Easy_RewardRandomPos / NumOfTrials_Easy_RewardRandomPos_P1 ;
MeanQ2P1_Easy_RewardRandomPos = SumQ2P1_Easy_RewardRandomPos / NumOfTrials_Easy_RewardRandomPos_P1;
MeanQ1P2_Easy_RewardRandomNeg = SumQ1P2_Easy_RewardRandomNeg / NumOfTrials_Easy_RewardRandomPos_P1;
MeanQ2P2_Easy_RewardRandomNeg = SumQ2P2_Easy_RewardRandomNeg / NumOfTrials_Easy_RewardRandomPos_P1;

NumOfTrials_Easy_RewardRandomPos_P2 ;
MeanQ1P2_Easy_RewardRandomPos = SumQ1P2_Easy_RewardRandomPos / NumOfTrials_Easy_RewardRandomPos_P2;
MeanQ2P2_Easy_RewardRandomPos = SumQ2P2_Easy_RewardRandomPos / NumOfTrials_Easy_RewardRandomPos_P2;
MeanQ1P1_Easy_RewardRandomNeg = SumQ1P1_Easy_RewardRandomNeg / NumOfTrials_Easy_RewardRandomPos_P2;
MeanQ2P1_Easy_RewardRandomNeg = SumQ2P1_Easy_RewardRandomNeg / NumOfTrials_Easy_RewardRandomPos_P2;


NumOfTrials_Hard_RewardShared_P1 ;
MeanQ1P1_Hard_RewardShared = SumQ1P1_Hard_RewardShared / NumOfTrials_Hard_RewardShared_P1;
MeanQ2P1_Hard_RewardShared = SumQ2P1_Hard_RewardShared / NumOfTrials_Hard_RewardShared_P1;
MeanQ1P2_Hard_RewardShared = SumQ1P2_Hard_RewardShared / NumOfTrials_Hard_RewardShared_P1;
MeanQ2P2_Hard_RewardShared = SumQ2P2_Hard_RewardShared / NumOfTrials_Hard_RewardShared_P1;

NumOfTrials_Hard_RewardContriPos_P1 ;
MeanQ1P1_Hard_RewardContriPos = SumQ1P1_Hard_RewardContriPos / NumOfTrials_Hard_RewardContriPos_P1;
MeanQ2P1_Hard_RewardContriPos = SumQ2P1_Hard_RewardContriPos / NumOfTrials_Hard_RewardContriPos_P1;
MeanQ1P2_Hard_RewardContriNeg = SumQ1P2_Hard_RewardContriNeg / NumOfTrials_Hard_RewardContriPos_P1;
MeanQ2P2_Hard_RewardContriNeg = SumQ2P2_Hard_RewardContriNeg / NumOfTrials_Hard_RewardContriPos_P1;    

NumOfTrials_Hard_RewardContriPos_P2 ;
MeanQ1P2_Hard_RewardContriPos = SumQ1P2_Hard_RewardContriPos / NumOfTrials_Hard_RewardContriPos_P2;
MeanQ2P2_Hard_RewardContriPos = SumQ2P2_Hard_RewardContriPos / NumOfTrials_Hard_RewardContriPos_P2;
MeanQ1P1_Hard_RewardContriNeg = SumQ1P1_Hard_RewardContriNeg / NumOfTrials_Hard_RewardContriPos_P2;
MeanQ2P1_Hard_RewardContriNeg = SumQ2P1_Hard_RewardContriNeg / NumOfTrials_Hard_RewardContriPos_P2;

NumOfTrials_Hard_RewardRandomPos_P1 ;
MeanQ1P1_Hard_RewardRandomPos = SumQ1P1_Hard_RewardRandomPos / NumOfTrials_Hard_RewardRandomPos_P1;
MeanQ2P1_Hard_RewardRandomPos = SumQ2P1_Hard_RewardRandomPos / NumOfTrials_Hard_RewardRandomPos_P1;
MeanQ1P2_Hard_RewardRandomNeg = SumQ1P2_Hard_RewardRandomNeg / NumOfTrials_Hard_RewardRandomPos_P1;
MeanQ2P2_Hard_RewardRandomNeg = SumQ2P2_Hard_RewardRandomNeg / NumOfTrials_Hard_RewardRandomPos_P1;

NumOfTrials_Hard_RewardRandomPos_P2 ;
MeanQ1P2_Hard_RewardRandomPos = SumQ1P2_Hard_RewardRandomPos / NumOfTrials_Hard_RewardRandomPos_P2;
MeanQ2P2_Hard_RewardRandomPos = SumQ2P2_Hard_RewardRandomPos / NumOfTrials_Hard_RewardRandomPos_P2;
MeanQ1P1_Hard_RewardRandomNeg = SumQ1P1_Hard_RewardRandomNeg / NumOfTrials_Hard_RewardRandomPos_P2;
MeanQ2P1_Hard_RewardRandomNeg = SumQ2P1_Hard_RewardRandomNeg / NumOfTrials_Hard_RewardRandomPos_P2;             


NumOfTrials_HighContrib_RewardShared_P1;
MeanQ1P1_HighContrib_RewardShared = SumQ1P1_HighContrib_RewardShared / NumOfTrials_HighContrib_RewardShared_P1;
MeanQ2P1_HighContrib_RewardShared = SumQ2P1_HighContrib_RewardShared / NumOfTrials_HighContrib_RewardShared_P1;
MeanQ1P2_LowContrib_RewardShared = SumQ1P2_LowContrib_RewardShared / NumOfTrials_HighContrib_RewardShared_P1;
MeanQ2P2_LowContrib_RewardShared = SumQ2P2_LowContrib_RewardShared / NumOfTrials_HighContrib_RewardShared_P1;

NumOfTrials_HighContrib_RewardContriPos_P1 ;
MeanQ1P1_HighContrib_RewardContriPos = SumQ1P1_HighContrib_RewardContriPos / NumOfTrials_HighContrib_RewardContriPos_P1;
MeanQ2P1_HighContrib_RewardContriPos = SumQ2P1_HighContrib_RewardContriPos / NumOfTrials_HighContrib_RewardContriPos_P1;
MeanQ1P2_LowContrib_RewardContriNeg = SumQ1P2_LowContrib_RewardContriNeg/ NumOfTrials_HighContrib_RewardContriPos_P1;
MeanQ2P2_LowContrib_RewardContriNeg = SumQ2P2_LowContrib_RewardContriNeg / NumOfTrials_HighContrib_RewardContriPos_P1;

NumOfTrials_HighContrib_RewardRandomNeg_P1 ;
MeanQ1P1_HighContrib_RewardRandomNeg = SumQ1P1_HighContrib_RewardRandomNeg / NumOfTrials_HighContrib_RewardRandomNeg_P1;
MeanQ2P1_HighContrib_RewardRandomNeg = SumQ2P1_HighContrib_RewardRandomNeg / NumOfTrials_HighContrib_RewardRandomNeg_P1;
MeanQ1P2_LowContrib_RewardRandomPos = SumQ1P2_LowContrib_RewardRandomPos / NumOfTrials_HighContrib_RewardRandomNeg_P1;
MeanQ2P2_LowContrib_RewardRandomPos = SumQ2P2_LowContrib_RewardRandomPos / NumOfTrials_HighContrib_RewardRandomNeg_P1;

NumOfTrials_HighContrib_RewardRandomPos_P1 ;
MeanQ1P1_HighContrib_RewardRandomPos = SumQ1P1_HighContrib_RewardRandomPos / NumOfTrials_HighContrib_RewardRandomPos_P1;
MeanQ2P1_HighContrib_RewardRandomPos = SumQ2P1_HighContrib_RewardRandomPos / NumOfTrials_HighContrib_RewardRandomPos_P1;
MeanQ1P2_LowContrib_RewardRandomNeg = SumQ1P2_LowContrib_RewardRandomNeg / NumOfTrials_HighContrib_RewardRandomPos_P1;
MeanQ2P2_LowContrib_RewardRandomNeg = SumQ2P2_LowContrib_RewardRandomNeg / NumOfTrials_HighContrib_RewardRandomPos_P1;


NumOfTrials_HighContrib_RewardShared_P2 ;
MeanQ1P2_HighContrib_RewardShared = SumQ1P2_HighContrib_RewardShared / NumOfTrials_HighContrib_RewardShared_P2;
MeanQ2P2_HighContrib_RewardShared = SumQ2P2_HighContrib_RewardShared / NumOfTrials_HighContrib_RewardShared_P2;
MeanQ1P1_LowContrib_RewardShared = SumQ1P1_LowContrib_RewardShared / NumOfTrials_HighContrib_RewardShared_P2;
MeanQ2P1_LowContrib_RewardShared = SumQ2P1_LowContrib_RewardShared / NumOfTrials_HighContrib_RewardShared_P2;

NumOfTrials_HighContrib_RewardContriPos_P2 ;
MeanQ1P2_HighContrib_RewardContriPos = SumQ1P2_HighContrib_RewardContriPos / NumOfTrials_HighContrib_RewardContriPos_P2;
MeanQ2P2_HighContrib_RewardContriPos = SumQ2P2_HighContrib_RewardContriPos / NumOfTrials_HighContrib_RewardContriPos_P2;
MeanQ1P1_LowContrib_RewardContriNeg = SumQ1P1_LowContrib_RewardContriNeg / NumOfTrials_HighContrib_RewardContriPos_P2;
MeanQ2P1_LowContrib_RewardContriNeg = SumQ2P1_LowContrib_RewardContriNeg / NumOfTrials_HighContrib_RewardContriPos_P2;

NumOfTrials_HighContrib_RewardRandomNeg_P2 ;
MeanQ1P2_HighContrib_RewardRandomNeg = SumQ1P2_HighContrib_RewardRandomNeg / NumOfTrials_HighContrib_RewardRandomNeg_P2 ;
MeanQ2P2_HighContrib_RewardRandomNeg = SumQ2P2_HighContrib_RewardRandomNeg / NumOfTrials_HighContrib_RewardRandomNeg_P2;
MeanQ1P1_LowContrib_RewardRandomPos = SumQ1P1_LowContrib_RewardRandomPos / NumOfTrials_HighContrib_RewardRandomNeg_P2;
MeanQ2P1_LowContrib_RewardRandomPos = SumQ2P1_LowContrib_RewardRandomPos / NumOfTrials_HighContrib_RewardRandomNeg_P2;

NumOfTrials_HighContrib_RewardRandomPos_P2 ;
MeanQ1P2_HighContrib_RewardRandomPos = SumQ1P2_HighContrib_RewardRandomPos / NumOfTrials_HighContrib_RewardRandomPos_P2;
MeanQ2P2_HighContrib_RewardRandomPos = SumQ2P2_HighContrib_RewardRandomPos / NumOfTrials_HighContrib_RewardRandomPos_P2;
MeanQ1P1_LowContrib_RewardRandomNeg = SumQ1P1_LowContrib_RewardRandomNeg / NumOfTrials_HighContrib_RewardRandomPos_P2;
MeanQ2P1_LowContrib_RewardRandomNeg = SumQ2P1_LowContrib_RewardRandomNeg / NumOfTrials_HighContrib_RewardRandomPos_P2;

% end % to be suppressed for including physio analyses in the general loop

%%%%%%%%%%%%%%%% ANALYSES PHYSIO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set data time to 0

PhysioTime = [];
PhysioRoundTime = [];

% if part == ['LB']
%     comb = [-1 1 185990 1 1; -1 1 485980 1 2; -1 1 494390 1 3];
%     for i = 1:3
%     PhysioTime(i) = (comb(i, 3) - (comb(1, 3)-1)); % set time to 1 for the first trigger in physio data : when the sync begins
%     PhysioRoundTime(i) = ((comb(i, 3) - (comb(1, 3))-1))/1000;
%     end
    
% else
    for i = 1:length(com)
    PhysioTime(i) = (com(i, 3) - (com(1, 3)-1)); % set time to 1 for the first trigger in physio data : when the sync begins
    PhysioRoundTime(i) = ((com(i, 3) - (com(1, 3))-1))/1000;
    end
% end
PhysioRoundTime = PhysioRoundTime';

 %creation matrice bloctriggers
    
%    TriggerMat = [];
%    TriggerMat.matim = [bloctriggers(1).time, trialtriggers(1:24).time, bloctriggers(24).time, bloctriggers(25).time, trialtriggers(25:48).time, bloctriggers(48).time, bloctriggers(49).time, trialtriggers(49:72).time, bloctriggers(72).time, bloctriggers(73).time, trialtriggers(73:96).time,bloctriggers(96).time, bloctriggers(97).time, trialtriggers(97:120).time, bloctriggers(120).time, bloctriggers(121).time, trialtriggers(121:144).time, bloctriggers(144).time, bloctriggers(145).time, trialtriggers(145:168).time, bloctriggers(168).time, bloctriggers(169).time, trialtriggers(169:192).time, bloctriggers(192).time]
%    TriggerMat.time = TriggerMat.matim - TriggerMat.matim(1)
%    TriggerMat.time = TriggerMat.time'
%    TriggerMat.frame = TriggerMat.time*1000
%    TriggerMat.stim = [bloctriggers(1).stim, trialtriggers(1:24).stim, bloctriggers(24).stim, bloctriggers(25).stim, trialtriggers(25:48).stim, bloctriggers(48).stim, bloctriggers(49).stim, trialtriggers(49:72).stim, bloctriggers(72).stim, bloctriggers(73).stim, trialtriggers(73:96).stim,bloctriggers(96).stim, bloctriggers(97).stim, trialtriggers(97:120).stim, bloctriggers(120).stim, bloctriggers(121).stim, trialtriggers(121:144).stim, bloctriggers(144).stim, bloctriggers(145).stim, trialtriggers(145:168).stim, bloctriggers(168).stim, bloctriggers(169).stim, trialtriggers(169:192).stim, bloctriggers(192).stim]'
%    TriggerMat.num = [bloctriggers(1).num, trialtriggers(1:24).num, bloctriggers(24).num, bloctriggers(25).num, trialtriggers(25:48).num, bloctriggers(48).num, bloctriggers(49).num, trialtriggers(49:72).num, bloctriggers(72).num, bloctriggers(73).num, trialtriggers(73:96).num,bloctriggers(96).num, bloctriggers(97).num, trialtriggers(97:120).num, bloctriggers(120).num, bloctriggers(121).num, trialtriggers(121:144).num, bloctriggers(144).num, bloctriggers(145).num, trialtriggers(145:168).num, bloctriggers(168).num, bloctriggers(169).num, trialtriggers(169:192).num, bloctriggers(192).num]'
%    TriggerMat.cond = [bloctriggers(1).cond, trialtriggers(1:24).cond, bloctriggers(24).cond, bloctriggers(25).cond, trialtriggers(25:48).cond, bloctriggers(48).cond, bloctriggers(49).cond, trialtriggers(49:72).cond, bloctriggers(72).cond, bloctriggers(73).cond, trialtriggers(73:96).cond,bloctriggers(96).cond, bloctriggers(97).cond, trialtriggers(97:120).cond, bloctriggers(120).cond, bloctriggers(121).cond, trialtriggers(121:144).cond, bloctriggers(144).cond, bloctriggers(145).cond, trialtriggers(145:168).cond, bloctriggers(168).cond, bloctriggers(169).cond, trialtriggers(169:192).cond, bloctriggers(192).cond]'
%    TriggerMat.kind = [NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(1:24).kind, NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(25:48).kind,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(49:72).kind,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(73:96).kind,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(97:120).kind,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(121:144).kind,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(145:168).kind,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(169:192).kind, NaN, NaN]'
%    TriggerMat.ntrial = [NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(1:24).ntrial, NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(25:48).ntrial,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(49:72).ntrial,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(73:96).ntrial,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(97:120).ntrial,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(121:144).ntrial,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(145:168).ntrial,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(169:192).ntrial, NaN, NaN]'
%    TriggerMat.nbloc = [NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(1:24).nbloc, NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(25:48).nbloc,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(49:72).nbloc,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(73:96).nbloc,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(97:120).nbloc,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(121:144).nbloc,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(145:168).nbloc,  NaN,NaN,NaN,NaN,NaN,NaN,NaN, trialtriggers(169:192).nbloc, NaN, NaN]'
%    
%    TrigTab = [TriggerMat.num,TriggerMat.stim,TriggerMat.time, TriggerMat.frame, TriggerMat.cond,TriggerMat.kind,TriggerMat.ntrial,TriggerMat.nbloc];
%    
   
% extraction of physio data

% if part == ['TN']
%     REDmain=dataPhy(datastart(1):dataend(1));
%     REDmain = dataPhy((com(1,3) + 1) : dataend(1)); %from first trigger (sync) to end of feet data
%     REDplayer1 = dataPhy((datastart(2) + com(1,3)) : dataend(2));
%     REDmain_filtre=dataPhy((datastart(3) + com(1,3)):dataend(3));
%     REDplayer1_filtre=dataPhy((datastart(5) + com(1,3)):dataend(5));
% elseif part == ['LB']
%     REDplayer1=dataPhy(datastart(1):dataend(1));
%     REDplayer1 = dataPhy((comb(1,3) + 1) : dataend(1)); %from first trigger (sync) to end of feet data
%     REDmain = dataPhy((datastart(2) + comb(1,3)) : dataend(2));
%     REDplayer1_filtre=dataPhy((datastart(3) + comb(1,3)):dataend(3));
%     REDmain_filtre=dataPhy((datastart(5) + comb(1,3)):dataend(5));
%else 
    REDplayer1=dataPhy(datastart(1):dataend(1));
    REDplayer1 = dataPhy((com(1,3) + 1) : dataend(1)); %from first trigger (start of baseline) to end of P1 data
    REDplayer2 = dataPhy((datastart(2) + com(1,3)) : dataend(2));
%     REDplayer1_filtre=dataPhy((datastart(3) + com(1,3)):dataend(3));
%     REDplayer2_filtre=dataPhy((datastart(5) + com(1,3)):dataend(5));
%end 
    
%     % correlation pied main
%     
%     SYNCpied = REDplayer1(1:PhysioTime(2));
%     SYNCmain = REDmain(1:PhysioTime(2));
%     SYNCpm = [SYNCmain; SYNCpied]';
%     figure;
%     subplot(1,3,1);
%     plot(SYNCpied)
%     title('SYNC PIED')
%     subplot(1,3,2);
%     plot(SYNCmain)
%     title('SYNC MAIN')
%     subplot(1,3,1);
% %     [R, Pvalue] = corrplot(SYNCpm)
% %     title('CORREL MAIN PIED')
%     [R, P] =corrcoef(SYNCpied, SYNCmain)
    
 
  
    
   % creation of a rounded frame variable in trialtriggers 
    
    for itrial = 1:length(bloctriggers)
        if itrial ==1 || itrial == 32 || itrial== 33 || itrial == 64 || itrial == 65 || itrial == 96 || itrial == 97 || itrial == 128 || itrial == 129 || itrial == 160|| itrial ==161 || itrial == 192 
            bloctriggers(itrial).timeBis = bloctriggers(itrial).time - bloctriggers(1).time(1); % set time to 0
            bloctriggers(itrial).frame = round(bloctriggers(itrial).timeBis*1000) + 1;
        end
    
    end
    
    for itrial = 1:length(trialtriggers)
        trialtriggers(itrial).timeBis = trialtriggers(itrial).time - bloctriggers(1).time(1); % set time to 0 for the first matlab trigger
        trialtriggers(itrial).frame = round(trialtriggers(itrial).timeBis*1000) + 1;
    end
   
    
    % cleaning data : only EDA data from the real trials without baseline, and irregular trials
     
    
    REDclean_player1 = [];
    REDclean_player2 = [];
       
     
    for itrial = 1:length(trialtriggers)
       
        if itrial < length(trialtriggers) %& trialtriggers(itrial).kind == 1
        
            trialtriggers(itrial).ITI = (trialtriggers(itrial+1).frame(1) - trialtriggers(itrial).frame(8)); % to reveal the breaks between two trials
        
        elseif itrial == length(trialtriggers)
        
            trialtriggers(itrial).ITI = 9999;
        end        
    end 
    
    
    for itrial = 1:length(trialtriggers)
        
        trialtriggers(itrial).BaselineTrial_P1 = mean(REDplayer1(trialtriggers(itrial).frame(1) : trialtriggers(itrial).frame(2)))*10^6;% from dot onset to beginning of questions
        trialtriggers(itrial).BaselineTrial_P2 = mean(REDplayer2(trialtriggers(itrial).frame(1) : trialtriggers(itrial).frame(2)))*10^6;% from dot onset to beginning of questions
       
        
       if itrial == 1
           trialtriggers(itrial).BaselineTrial_P1 = mean(REDplayer1(trialtriggers(itrial).frame(1) : trialtriggers(itrial).frame(2)))*10^6% from dot onset to beginning of questions
           trialtriggers(itrial).BaselineTrial_P2 = mean(REDplayer2(trialtriggers(itrial).frame(1) : trialtriggers(itrial).frame(2)))*10^6% from dot onset to beginning of questions
       
       elseif itrial > 1
           trialtriggers(itrial).BaselineTrial_P1 = mean(REDplayer1(trialtriggers(itrial - 1).frame(7) : trialtriggers(itrial - 1).frame(8)))*10^6% from dot onset to beginning of questions
           trialtriggers(itrial).BaselineTrial_P2 = mean(REDplayer2(trialtriggers(itrial - 1).frame(7) : trialtriggers(itrial - 1).frame(8)))*10^6% from dot onset to beginning of questions
           
       end 
       
       trialtriggers(itrial).MagnTrial_P1 = mean(REDplayer1(trialtriggers(itrial).frame(2) : trialtriggers(itrial).frame(7)))*10^6  - trialtriggers(itrial).BaselineTrial_P1; % from dot onset to beginning of questions
       trialtriggers(itrial).MagnReward_P1 = mean((REDplayer1(trialtriggers(itrial).frame(5) + 1000) : trialtriggers(itrial).frame(6)))*10^6 - trialtriggers(itrial).BaselineTrial_P1;  % from 1s after beginning of reward to end of ereward
       trialtriggers(itrial).MagnTrial_P2 = mean(REDplayer2(trialtriggers(itrial).frame(2) : trialtriggers(itrial).frame(7)))*10^6 - trialtriggers(itrial).BaselineTrial_P2; % from dot onset to beginning of questions
       trialtriggers(itrial).MagnReward_P2 = mean(REDplayer2((trialtriggers(itrial).frame(5) + 1000) : trialtriggers(itrial).frame(6)))*10^6 -  trialtriggers(itrial).BaselineTrial_P2 ;   % from 1s afte beginning of reward to end of ereward
       
       trialtriggers(itrial).AmpTrial_P1 = mean(REDplayer1(trialtriggers(itrial).frame(2) : trialtriggers(itrial).frame(7)))*10^6% from dot onset to beginning of questions
       trialtriggers(itrial).AmpReward_P1 = mean(REDplayer1(trialtriggers(itrial).frame(5) : trialtriggers(itrial).frame(6)))*10^6 % from beginning of reward to end of ereward
       trialtriggers(itrial).AmpTrial_P2 = mean(REDplayer2(trialtriggers(itrial).frame(2) : trialtriggers(itrial).frame(7)))*10^6% from dot onset to beginning of questions
       trialtriggers(itrial).AmpReward_P2 = mean(REDplayer2(trialtriggers(itrial).frame(5) : trialtriggers(itrial).frame(6)))*10^6 % from beginning of reward to end of ereward
       
       trialtriggers(itrial).RewardSlope1_P1  = ((REDplayer1(trialtriggers(itrial).frame(5) + 1000) - REDplayer1(trialtriggers(itrial).frame(5))) ./ ((trialtriggers(itrial).frame(5) + 1000) - (trialtriggers(itrial).frame(5))))*10^6 ;
       trialtriggers(itrial).RewardSlope2_P1  = ((REDplayer1(trialtriggers(itrial).frame(5) + 2000) - REDplayer1(trialtriggers(itrial).frame(5) + 1000)) ./ ((trialtriggers(itrial).frame(5) + 2000) - (trialtriggers(itrial).frame(5) + 1000)))*10^6 ;
       trialtriggers(itrial).RewardSlope3_P1  = ((REDplayer1(trialtriggers(itrial).frame(5) + 3000) - REDplayer1(trialtriggers(itrial).frame(5) + 2000)) ./ 1000)*10^6 ; % slope calculated each second (1000 ms)
       trialtriggers(itrial).RewardSlope4_P1  = ((REDplayer1(trialtriggers(itrial).frame(5) + 4000) - REDplayer1(trialtriggers(itrial).frame(5) + 3000)) ./ 1000)*10^6 ; % slope calculated each second (1000 ms)
       trialtriggers(itrial).RewardSlope5_P1  = ((REDplayer1(trialtriggers(itrial).frame(5) + 5000) - REDplayer1(trialtriggers(itrial).frame(5) + 4000)) ./ 1000)*10^6 ; % slope calculated each second (1000 ms)
       
       trialtriggers(itrial).RewardSlope1_P2  = ((REDplayer2(trialtriggers(itrial).frame(5) + 1000) - REDplayer2(trialtriggers(itrial).frame(5))) ./ ((trialtriggers(itrial).frame(5) + 1000) - (trialtriggers(itrial).frame(5))))*10^6 ;
       trialtriggers(itrial).RewardSlope2_P2  = ((REDplayer2(trialtriggers(itrial).frame(5) + 2000) - REDplayer2(trialtriggers(itrial).frame(5) + 1000)) ./ ((trialtriggers(itrial).frame(5) + 2000) - (trialtriggers(itrial).frame(5) + 1000)))*10^6 ;
       trialtriggers(itrial).RewardSlope3_P2  = ((REDplayer1(trialtriggers(itrial).frame(5) + 3000) - REDplayer2(trialtriggers(itrial).frame(5) + 2000)) ./ 1000)*10^6 ; % slope calculated each second (1000 ms)
       trialtriggers(itrial).RewardSlope4_P2  = ((REDplayer2(trialtriggers(itrial).frame(5) + 4000) - REDplayer2(trialtriggers(itrial).frame(5) + 3000)) ./ 1000)*10^6 ; % slope calculated each second (1000 ms)
       trialtriggers(itrial).RewardSlope5_P2  = ((REDplayer2(trialtriggers(itrial).frame(5) + 5000) - REDplayer2(trialtriggers(itrial).frame(5) + 4000)) ./ 1000)*10^6 ; % slope calculated each second (1000 ms)
              
       
       [MaxAmpReward_P1, Index_At_F_P1] = max(double(REDplayer1(trialtriggers(itrial).frame(5) : trialtriggers(itrial).frame(6)))); % max amp for reward
       trialtriggers(itrial).MaxAmpReward_P1 = MaxAmpReward_P1;
       trialtriggers(itrial).t_MaxAmpReward_P1 = Index_At_F_P1;
       [MaxAmpReward_P2, Index_At_F_P2] = max(double(REDplayer2(trialtriggers(itrial).frame(5) : trialtriggers(itrial).frame(6)))); % max amp for reward
       trialtriggers(itrial).MaxAmpReward_P2 = MaxAmpReward_P2;
       trialtriggers(itrial).t_MaxAmpReward_P2 = Index_At_F_P2;
       
        
       
%         if  trialtriggers(itrial).kind == 1 % report EDA values for regular trials
%            
%          if trialtriggers(itrial).stim(3) == 12 % if trial is succeed
%                        
%              REDclean_player1(trialtriggers(itrial).frame(1) : trialtriggers(itrial).frame(8)) = REDplayer1(trialtriggers(itrial).frame(1) : trialtriggers(itrial).frame(8)); % entire trial
% %              trialtriggers(itrial).AmpTrial_P1 = mean(REDplayer1(trialtriggers(itrial).frame(2) : trialtriggers(itrial).frame(7)))*10^6% from dot onset to beginning of questions
% %              trialtriggers(itrial).AmpReward_P1 = mean(REDplayer1(trialtriggers(itrial).frame(5) : trialtriggers(itrial).frame(6)))*10^6 % from beginning of reward to end of ereward
% %              
%              % do the same for player2
%              REDclean_player2(trialtriggers(itrial).frame(1) : trialtriggers(itrial).frame(8)) = REDplayer2(trialtriggers(itrial).frame(1) : trialtriggers(itrial).frame(8)); % entire trial
% %              trialtriggers(itrial).AmpTrial_P2 = mean(REDplayer2(trialtriggers(itrial).frame(2) : trialtriggers(itrial).frame(7)))*10^6% from dot onset to beginning of questions
% %              trialtriggers(itrial).AmpReward_P2 = mean(REDplayer2(trialtriggers(itrial).frame(5) : trialtriggers(itrial).frame(6)))*10^6 % 
% %              
%                if trialtriggers(itrial).ITI < 1600 % if trials are consecutive in the block (no intermittent baseline) 
% 
%                     REDclean_player1(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = REDplayer1(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1));
%                     REDclean_player2(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = REDplayer2(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1));
% 
%                elseif trialtriggers(itrial).ITI > 1600 % if trials are not consecutive in the block ( intermittent baseline)
% 
%                         REDclean_player1(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = 0; %note 0 for baseline
%                         REDclean_player2(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = 0;
% 
%                end     
%                                                     
%          elseif trialtriggers(itrial).stim(3) == 11 | trialtriggers(itrial).stim(3) == 13 % if trial is failed
%              REDclean_player1(trialtriggers(itrial).frame(1) : trialtriggers(itrial).frame(8)) = 0;%9999; % note 9999 for invalid trials
%              %REDclean_player1(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = 9999;
%              REDclean_player2(trialtriggers(itrial).frame(1) : trialtriggers(itrial).frame(8)) = 0;%9999;
%              %REDclean_player2(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = 9999;  
%              
%                if trialtriggers(itrial).ITI < 1600 % if trials are consecutive in the block (no intermittent baseline) 
% 
%                     REDclean_player1(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = REDplayer1(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1));
%                     REDclean_player2(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = REDplayer2(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1));
% 
%                elseif trialtriggers(itrial).ITI > 1600 % if trials are not consecutive in the block ( intermittent baseline)
% 
%                         REDclean_player1(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = 0; %note 0 for baseline
%                         REDclean_player2(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = 0;
% 
%                end     
% 
%              
%          end
%                  
%     
%        elseif trialtriggers(itrial).kind == 2 |  trialtriggers(itrial).kind == 3 % note 9999 for irregular trials 
%            
%            if trialtriggers(itrial).stim(3) == 12 % if trial irregular is succeed
%              REDclean_player1(trialtriggers(itrial).frame(1) : trialtriggers(itrial).frame(8)) = 0;%9999;
%              REDclean_player2(trialtriggers(itrial).frame(1) : trialtriggers(itrial).frame(8)) = 0;%9999;
%              
%                if trialtriggers(itrial).ITI < 1600 % if trials are consecutive in the block (no intermittent baseline) 
% 
%                     REDclean_player1(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = REDplayer1(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1));
%                     REDclean_player2(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = REDplayer2(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1));
% 
%                elseif trialtriggers(itrial).ITI > 1600 % if trials are not consecutive in the block ( intermittent baseline)
% 
%                         REDclean_player1(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = 0; %note 0 for baseline
%                         REDclean_player2(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = 0;
% 
%                end     
% 
%            elseif trialtriggers(itrial).stim(3) == 11 | trialtriggers(itrial).stim(3) == 13  % note  9999 if irregular trial is failed        
%              REDclean_player1(trialtriggers(itrial).frame(1) : trialtriggers(itrial).frame(8)) = 0;%9999;
%              %REDclean_player1(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = 9999;
%              REDclean_player2(trialtriggers(itrial).frame(1) : trialtriggers(itrial).frame(8)) = 0;%9999;
%              %REDclean_player2(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = 9999;
%              
%                if trialtriggers(itrial).ITI < 1600 % if trials are consecutive in the block (no intermittent baseline) 
% 
%                     REDclean_player1(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = REDplayer1(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1));
%                     REDclean_player2(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = REDplayer2(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1));
% 
%                elseif trialtriggers(itrial).ITI > 1600 % if trials are not consecutive in the block ( intermittent baseline)
% 
%                         REDclean_player1(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = 0; %note 0 for baseline
%                         REDclean_player2(trialtriggers(itrial).frame(8) : trialtriggers(itrial + 1).frame(1)) = 0;
% 
%                end     
% 
%            end
%            
%         end
    end 
  
    
    phyData = [];

%     phyData.clear_P1 = REDclean_player1;
%     phyData.clear_P2 = REDclean_player2;
    
    for i = 1:length(REDclean_player1)
        
        phyData.time(i) =  i;
        
    end 
    
        
      for itrial = 1:length(trialtriggers)  
          
        if itrial < ntrials
            phyData.stim(trialtriggers(itrial).frame(8):trialtriggers(itrial +1).frame(1)) = trialtriggers(itrial).stim(7);
            phyData.ntrial(trialtriggers(itrial).frame(1):trialtriggers(itrial +1).frame(1)) = itrial;
%             if  trialtriggers(itrial).kind == 1 & trialtriggers(itrial).stim(3) == 10
%             trialtriggers(itrial).AmpTrial = mean(REDplayer1(trialtriggers(itrial).frame(2) : trialtriggers(itrial + 1).frame(1)));
%             end
            phyData.nbloc(trialtriggers(itrial).frame(1):trialtriggers(itrial +1).frame(1)) = trialtriggers(itrial).nbloc(1);
            phyData.reward(trialtriggers(itrial).frame(1):trialtriggers(itrial +1).frame(1)) = trialtriggers(itrial).blocReward(1);
            phyData.fluency(trialtriggers(itrial).frame(1):trialtriggers(itrial +1).frame(1)) = trialtriggers(itrial).fluency(1);
            phyData.contribP1(trialtriggers(itrial).frame(1):trialtriggers(itrial +1).frame(1)) = contribPlayer(itrial).P1;
            phyData.contribP2(trialtriggers(itrial).frame(1):trialtriggers(itrial +1).frame(1)) = contribPlayer(itrial).P2;
        
        elseif itrial == ntrials
            phyData.stim(trialtriggers(itrial).frame(8):length(REDclean_player1)) = trialtriggers(itrial).stim(8);
            phyData.ntrial(trialtriggers(itrial).frame(1):length(REDclean_player1)) = itrial;
%             if  trialtriggers(itrial).kind == 1 & trialtriggers(itrial).stim(3) == 10
%             trialtriggers(itrial).AmpTrial = mean(REDplayer1(trialtriggers(itrial).frame(2) : trialtriggers(itrial).frame(5)));
%             end
            phyData.nbloc(trialtriggers(itrial).frame(1):length(REDclean_player1)) = trialtriggers(itrial).nbloc(1);
            phyData.reward(trialtriggers(itrial).frame(1):length(REDclean_player1)) = trialtriggers(itrial).blocReward(1);
            phyData.fluency(trialtriggers(itrial).frame(1):length(REDclean_player1)) = trialtriggers(itrial).fluency(1);
            phyData.contribP1(trialtriggers(itrial).frame(1):length(REDclean_player1)) = contribPlayer(itrial).P1;
            phyData.contribP2(trialtriggers(itrial).frame(1):length(REDclean_player1)) = contribPlayer(itrial).P2;
        
        end
      end 
        
    for itrial = 1:length(trialtriggers)
        
        phyData.stim(trialtriggers(itrial).frame(1):trialtriggers(itrial).frame(2)) = trialtriggers(itrial).stim(1); % squares onset to ball onset
        phyData.stim(trialtriggers(itrial).frame(2):trialtriggers(itrial).frame(3)) = trialtriggers(itrial).stim(2); % joint action
        phyData.stim(trialtriggers(itrial).frame(3):trialtriggers(itrial).frame(5)) = trialtriggers(itrial).stim(3); % colored feedback + ISI
        %phyData.stim(trialtriggers(itrial).frame(4):trialtriggers(itrial).frame(5)) = trialtriggers(itrial).stim(4);
        %phyData.stim(trialtriggers(itrial).frame(5):trialtriggers(itrial).frame(7)) = trialtriggers(itrial).stim(5); % money feedback : reward + ISI
        phyData.stim(trialtriggers(itrial).frame(5):(trialtriggers(itrial).frame(5)+5000)) = trialtriggers(itrial).stim(5); % money feedback : strict reward interval
        phyData.stim((trialtriggers(itrial).frame(5)+5001):trialtriggers(itrial).frame(7))= trialtriggers(itrial).stim(6); % ISI reward - questions
        %phyData.stim(trialtriggers(itrial).frame(5 + 5000):trialtriggers(itrial).frame(7)) = trialtriggers(itrial).stim(6); % ISI between reward and questions
        phyData.stim(trialtriggers(itrial).frame(7):trialtriggers(itrial).frame(8)) = trialtriggers(itrial).stim(7); % questions
    end 
    
  EDR_reward = [];
  
% EDR mean for player 1 for each type of reward

  n_EDR_sharedReward_P1 = 0;
  n_EDR_contribReward_P1 = 0;
  n_EDR_randomReward_P1 = 0;
    for itrial = 1:length(trialtriggers)
        
        if trialtriggers(itrial).t_MaxAmpReward_P1 > 1000 & trialtriggers(itrial).t_MaxAmpReward_P1 < 4500  &  trialtriggers(itrial).stim(3) == 12 & trialtriggers(itrial).kind == 1 % if peak of EDR is in the right time window (response to the stim)
            if trialtriggers(itrial).blocReward(1) == 1 % shared reward
                EDR_reward(itrial).sharedReward_P1(1:5000) = REDplayer1(trialtriggers(itrial).frame(5) : (trialtriggers(itrial).frame(5) + 4999));
                n_EDR_sharedReward_P1 = n_EDR_sharedReward_P1 + 1;
            elseif trialtriggers(itrial).blocReward(1)  == 2 % motor contrib reward
                EDR_reward(itrial).contribReward_P1(1:5000) = REDplayer1(trialtriggers(itrial).frame(5) : (trialtriggers(itrial).frame(5) + 4999));
                n_EDR_contribReward_P1 = n_EDR_contribReward_P1 + 1;
            elseif trialtriggers(itrial).blocReward(1) == 3
                EDR_reward(itrial).randomReward_P1(1:5000) = REDplayer1(trialtriggers(itrial).frame(5) : (trialtriggers(itrial).frame(5) + 4999));
                n_EDR_randomReward_P1 = n_EDR_randomReward_P1 + 1 ;
            end 
        end 
    end 
    
    EDR_sharedreward_P1 = [EDR_reward.sharedReward_P1];
    EDR_contribreward_P1 = [EDR_reward.contribReward_P1];
    EDR_randomreward_P1 = [EDR_reward.randomReward_P1];
    
    EDR_sharedReward_P1 = [];
    EDR_contribReward_P1 = [];
    EDR_randomReward_P1 = [];
    
    for i = 1:n_EDR_sharedReward_P1
        
        if i == 1        
        EDR_sharedReward_P1(i, 1:5000) =  EDR_sharedreward_P1(1:5000);        
        elseif i > 1            
        EDR_sharedReward_P1(i, 1:5000) = EDR_sharedreward_P1(((5000*(i-1))+ 1):(5000*i));        
        end
       
    end
    
    for i = 1:n_EDR_contribReward_P1
        
        if i == 1        
        EDR_contribReward_P1(i, 1:5000) =  EDR_contribreward_P1(1:5000);        
        elseif i > 1            
        EDR_contribReward_P1(i, 1:5000) = EDR_contribreward_P1(((5000*(i-1))+ 1):(5000*i));        
        end
       
    end
    
    for i = 1:n_EDR_randomReward_P1
        
        if i == 1        
        EDR_randomReward_P1(i, 1:5000) =  EDR_randomreward_P1(1:5000);        
        elseif i > 1            
        EDR_randomReward_P1(i, 1:5000) = EDR_randomreward_P1(((5000*(i-1))+ 1):(5000*i));        
        end
       
    end
    
 % EDR mean for player 2 for each type of reward

  n_EDR_sharedReward_P2 = 0;
  n_EDR_contribReward_P2 = 0;
  n_EDR_randomReward_P2 = 0;
    for itrial = 1:length(trialtriggers)
        
        if trialtriggers(itrial).t_MaxAmpReward_P2 > 1000 & trialtriggers(itrial).t_MaxAmpReward_P2 < 4500  &  trialtriggers(itrial).stim(3) == 12 & trialtriggers(itrial).kind == 1 % if peak of EDR is in the right time window (response to the stim)
            if trialtriggers(itrial).blocReward(1) == 1 % shared reward
                EDR_reward(itrial).sharedReward_P2(1:5000) = REDplayer2(trialtriggers(itrial).frame(5) : (trialtriggers(itrial).frame(5) + 4999));
                n_EDR_sharedReward_P2 = n_EDR_sharedReward_P2 + 1;
            elseif trialtriggers(itrial).blocReward(1)  == 2 % motor contrib reward
                EDR_reward(itrial).contribReward_P2(1:5000) = REDplayer2(trialtriggers(itrial).frame(5) : (trialtriggers(itrial).frame(5) + 4999));
                n_EDR_contribReward_P2 = n_EDR_contribReward_P2 + 1;
            elseif trialtriggers(itrial).blocReward(1) == 3
                EDR_reward(itrial).randomReward_P2(1:5000) = REDplayer2(trialtriggers(itrial).frame(5) : (trialtriggers(itrial).frame(5) + 4999));
                n_EDR_randomReward_P2 = n_EDR_randomReward_P2 + 1 ;
            end 
        end 
    end 
    
    EDR_sharedreward_P2 = [EDR_reward.sharedReward_P2];
    EDR_contribreward_P2 = [EDR_reward.contribReward_P2];
    EDR_randomreward_P2 = [EDR_reward.randomReward_P2];
    
    EDR_sharedReward_P2 = [];
    EDR_contribReward_P2 = [];
    EDR_randomReward_P2 = [];
    
    for i = 1:n_EDR_sharedReward_P2
        
        if i == 1        
        EDR_sharedReward_P2(i, 1:5000) =  EDR_sharedreward_P2(1:5000);        
        elseif i > 1            
        EDR_sharedReward_P2(i, 1:5000) = EDR_sharedreward_P2(((5000*(i-1))+ 1):(5000*i));        
        end
       
    end
    
    for i = 1:n_EDR_contribReward_P2
        
        if i == 1        
        EDR_contribReward_P2(i, 1:5000) =  EDR_contribreward_P2(1:5000);        
        elseif i > 1            
        EDR_contribReward_P2(i, 1:5000) = EDR_contribreward_P2(((5000*(i-1))+ 1):(5000*i));        
        end
       
    end
    
    for i = 1:n_EDR_randomReward_P2
        
        if i == 1        
        EDR_randomReward_P2(i, 1:5000) =  EDR_randomreward_P2(1:5000);        
        elseif i > 1            
        EDR_randomReward_P2(i, 1:5000) = EDR_randomreward_P2(((5000*(i-1))+ 1):(5000*i));        
        end
       
    end
    
    
 %to save
 Mean_EDRsharedReward_P1 = mean(EDR_sharedReward_P1);
 Mean_EDRcontribReward_P1 = mean(EDR_contribReward_P1);
 Mean_EDRrandomReward_P1 = mean(EDR_randomReward_P1);
 
 Mean_EDRsharedReward_P2 = mean(EDR_sharedReward_P2);
 Mean_EDRcontribReward_P2 = mean(EDR_contribReward_P2);
 Mean_EDRrandomReward_P2 = mean(EDR_randomReward_P2);
 
 Mean_EDRsharedReward1(ipar, :) = [Mean_EDRsharedReward_P1]';
 Mean_EDRcontribReward1(ipar, : ) = [Mean_EDRcontribReward_P1]';
 Mean_EDRrandomReward1(ipar, :) = [Mean_EDRrandomReward_P1]';
 
 Mean_EDRsharedReward2(ipar, :) = [Mean_EDRsharedReward_P2]';
 Mean_EDRcontribReward2(ipar, : ) = [Mean_EDRcontribReward_P2]';
 Mean_EDRrandomReward2(ipar, :) = [Mean_EDRrandomReward_P2]';
 
end 
  
Mean_EDRsharedReward = [Mean_EDRsharedReward1; Mean_EDRsharedReward2];
Mean_EDRsharedReward = mean(Mean_EDRsharedReward);
Mean_EDRcontribReward = [Mean_EDRcontribReward1; Mean_EDRcontribReward2];
Mean_EDRcontribReward = mean(Mean_EDRcontribReward);
Mean_EDRrandomReward = [Mean_EDRrandomReward1; Mean_EDRrandomReward2];
Mean_EDRrandomReward = mean(Mean_EDRrandomReward);


figure
plot(Mean_EDRsharedReward, Mean_EDRcontribReward, Mean_EDRrandomReward)
legend('shared', 'fair', 'random')
xlabel('time')
ylabel('Mean amplitude in microSiemens')
title('SCR mean amplitude to rewards')

%%% remove 1 '%' for running the rest of the code
          

%  % correction of the EDR means by substracting the value right before the
%  % reward interval (5seconds)
%  
%  
%  % to clear
%  clear(EDR_sharedreward_P1, EDR_contribreward_P1, EDR_randomreward_P1)
%     
%     phyDataMat = [phyData.clear_P1; phyData.clear_P2; phyData.time; phyData.ntrial; phyData.nbloc; phyData.stim; phyData.reward; phyData.fluency; phyData.contribP1; phyData.contribP2];
% 
% %%%%%%%%%%%%%%%%%%%%% basic amplitude analyses
% 
% % Baseline means for blocs
% 
% baseline_mean_Bloc1_P1 = mean(REDplayer1(bloctriggers(1).frame(1):bloctriggers(1).frame(2)));
% baseline_mean_Bloc2_P1 = mean(REDplayer1(bloctriggers(33).frame(1):bloctriggers(33).frame(2)));
% baseline_mean_Bloc3_P1 = mean(REDplayer1(bloctriggers(65).frame(1):bloctriggers(65).frame(2)));
% baseline_mean_Bloc4_P1 = mean(REDplayer1(bloctriggers(97).frame(1):bloctriggers(97).frame(2)));
% baseline_mean_Bloc5_P1 = mean(REDplayer1(bloctriggers(129).frame(1):bloctriggers(129).frame(2)));
% baseline_mean_Bloc6_P1 = mean(REDplayer1(bloctriggers(161).frame(1):bloctriggers(161).frame(2)));
% 
% baseline_mean_Bloc1_P2 = mean(REDplayer2(bloctriggers(1).frame(1):bloctriggers(1).frame(2)));
% baseline_mean_Bloc2_P2 = mean(REDplayer2(bloctriggers(33).frame(1):bloctriggers(33).frame(2)));
% baseline_mean_Bloc3_P2 = mean(REDplayer2(bloctriggers(65).frame(1):bloctriggers(65).frame(2)));
% baseline_mean_Bloc4_P2 = mean(REDplayer2(bloctriggers(97).frame(1):bloctriggers(97).frame(2)));
% baseline_mean_Bloc5_P2 = mean(REDplayer2(bloctriggers(129).frame(1):bloctriggers(129).frame(2)));
% baseline_mean_Bloc6_P2 = mean(REDplayer2(bloctriggers(161).frame(1):bloctriggers(161).frame(2)));
% 
% % corrected baselines for blocs
% 
% baseline_mean_Bloc1_P1c = mean(REDplayer1((bloctriggers(1).frame(1) + 30000):bloctriggers(1).frame(2)));
% baseline_mean_Bloc2_P1c = mean(REDplayer1((bloctriggers(33).frame(1) + 30000):bloctriggers(33).frame(2)));
% baseline_mean_Bloc3_P1c = mean(REDplayer1((bloctriggers(65).frame(1) + 30000):bloctriggers(65).frame(2)));
% baseline_mean_Bloc4_P1c = mean(REDplayer1((bloctriggers(97).frame(1) + 30000):bloctriggers(97).frame(2)));
% baseline_mean_Bloc5_P1c = mean(REDplayer1((bloctriggers(129).frame(1) + 30000):bloctriggers(129).frame(2)));
% baseline_mean_Bloc6_P1c = mean(REDplayer1((bloctriggers(161).frame(1) + 30000):bloctriggers(161).frame(2)));
% 
% baseline_mean_Bloc1_P2c = mean(REDplayer2((bloctriggers(1).frame(1) + 30000):bloctriggers(1).frame(2)));
% baseline_mean_Bloc2_P2c = mean(REDplayer2((bloctriggers(33).frame(1) + 30000):bloctriggers(33).frame(2)));
% baseline_mean_Bloc3_P2c = mean(REDplayer2((bloctriggers(65).frame(1) + 30000):bloctriggers(65).frame(2)));
% baseline_mean_Bloc4_P2c = mean(REDplayer2((bloctriggers(97).frame(1) + 30000):bloctriggers(97).frame(2)));
% baseline_mean_Bloc5_P2c = mean(REDplayer2((bloctriggers(129).frame(1) + 30000):bloctriggers(129).frame(2)));
% baseline_mean_Bloc6_P2c = mean(REDplayer2((bloctriggers(161).frame(1) + 30000):bloctriggers(161).frame(2)));
% 
% 
% % baseline_mean_Bloc7 = mean(REDplayer1(bloctriggers(145).frame(2):bloctriggers(145).frame(3)));
% % 
% % if part ~= ['DA']
% % baseline_mean_Bloc8 = mean(REDplayer1(bloctriggers(169).frame(2):bloctriggers(169).frame(3)));
% % end 
% 
% 
% AmpBloc1_P1 = 0;
% idataBloc1_P1 = 0;
% AmpBloc2_P1 = 0;
% idataBloc2_P1 = 0;
% AmpBloc3_P1 = 0;
% idataBloc3_P1 = 0;
% AmpBloc4_P1 = 0;
% idataBloc4_P1 = 0;
% AmpBloc5_P1 = 0;
% idataBloc5_P1 = 0;
% AmpBloc6_P1 = 0;
% idataBloc6_P1 = 0;
% 
% AmpBloc1_P2 = 0;
% idataBloc1_P2 = 0;
% AmpBloc2_P2 = 0;
% idataBloc2_P2 = 0;
% AmpBloc3_P2 = 0;
% idataBloc3_P2 = 0;
% AmpBloc4_P2 = 0;
% idataBloc4_P2 = 0;
% AmpBloc5_P2 = 0;
% idataBloc5_P2 = 0;
% AmpBloc6_P2 = 0;
% idataBloc6_P2 = 0;
% 
% % RowAmpEasy_P1 = 0;
% % AmpEasy_P1 = 0;
% % idataEasy_P1 = 0;
% % RowAmpHard_P1 = 0;
% % AmpHard_P1 = 0;
% % idataHard_P1 = 0;
% 
% nonexploitable = 0;
% idataExpl = 0;
% 
% 
% for i = 1:length(phyData.clear)
%     
%     if phyData.clear_P1(i) == 0 | phyData.clear_P1(i) == 9999 
%         nonexploitable = nonexploitable + 1;
%         
%     elseif phyData.clear_P1(i) > (15*10^-5) | phyData.clear_P1(i) < (-15*10^-5) | phyData.clear_P2(i) > (15*10^-5) | phyData.clear_P2(i) < (-15*10^-5)
%         nonexploitable = nonexploitable + 1;
%     
%     else 
%         idataExpl = idataExpl + 1;
%         if phyData.nbloc(i) == 1
%             AmpBloc1_P1 = AmpBloc1_P1 + phyData.clear_P1(i);
%             idataBloc1_P1 = idataBloc1_P1 + 1;
%             AmpBloc1_P2 = AmpBloc1_P2 + phyData.clear_P2(i);
%             idataBloc1_P2 = idataBloc1_P2 + 1;
%         elseif phyData.nbloc(i) == 2
%             AmpBloc2_P1 = AmpBloc2_P1 + phyData.clear_P1(i);
%             idataBloc2_P1 = idataBloc2_P1 + 1;
%             AmpBloc2_P2 = AmpBloc2_P2 + phyData.clear_P2(i);
%             idataBloc2_P2 = idataBloc2_P2 + 1;
%         elseif phyData.nbloc(i) == 3
%             AmpBloc3_P1 = AmpBloc3_P1 + phyData.clear_P1(i);
%             idataBloc3_P1 = idataBloc3_P1 + 1;
%             AmpBloc3_P2 = AmpBloc3_P2 + phyData.clear_P2(i);
%             idataBloc3_P2 = idataBloc3_P2 + 1;
%         elseif phyData.nbloc(i) == 4
%             AmpBloc4_P1 = AmpBloc4_P1 + phyData.clear_P1(i);
%             idataBloc4_P1 = idataBloc4_P1 + 1;
%             AmpBloc4_P2 = AmpBloc4_P2 + phyData.clear_P2(i);
%             idataBloc4_P2 = idataBloc4_P2 + 1;
%         elseif phyData.nbloc(i) == 5
%             AmpBloc5_P1 = AmpBloc5_P1 + phyData.clear_P1(i);
%             idataBloc5_P1 = idataBloc5_P1 + 1;
%             AmpBloc5_P2 = AmpBloc5_P2 + phyData.clear_P2(i);
%             idataBloc5_P2 = idataBloc5_P2 + 1;
%         elseif phyData.nbloc(i) == 6
%             AmpBloc6_P1 = AmpBloc6_P1 + phyData.clear_P1(i);
%             idataBloc6_P1 = idataBloc6_P1 + 1;
%             AmpBloc6_P2 = AmpBloc6_P2 + phyData.clear_P2(i);
%             idataBloc6_P2 = idataBloc6_P2 + 1;
%         end
%         
% %         if phyData.clear(i) < (15*10^-5) & phyData.clear_P1(i) > (-15*10^-5)
% %                         
% %             if phyData.cond(i) == 1
% %                 RowAmpEasy = RowAmpEasy + phyData.clear(i);
% %                 idataEasy = idataEasy + 1;
% %             elseif phyData.cond(i) == 2
% %                 RowAmpHard = RowAmpHard + phyData.clear(i);
% %                 idataHard = idataHard + 1;
% % 
% %             end 
% %         end 
%     end 
% end 
%         
%  Row_AmpBloc1_P1_mean = AmpBloc1_P1/idataBloc1_P1;
%  AmpBloc1_P1_mean = (Row_AmpBloc1_P1_mean - baseline_mean_Bloc1_P1c)*10^6;
%  Row_AmpBloc2_P1_mean = AmpBloc2_P1/idataBloc2_P1;
%  AmpBloc2_P1_mean = (Row_AmpBloc2_P1_mean - baseline_mean_Bloc2_P1c)*10^6;
%  Row_AmpBloc3_P1_mean = AmpBloc3_P1/idataBloc3_P1;
%  AmpBloc3_P1_mean = (Row_AmpBloc3_P1_mean - baseline_mean_Bloc3_P1c)*10^6;
%  Row_AmpBloc4_P1_mean = AmpBloc4_P1/idataBloc4_P1;
%  AmpBloc4_P1_mean = (Row_AmpBloc4_P1_mean - baseline_mean_Bloc4_P1c)*10^6;
%  Row_AmpBloc5_P1_mean = AmpBloc5_P1/idataBloc5_P1;
%  AmpBloc5_P1_mean = (Row_AmpBloc5_P1_mean - baseline_mean_Bloc5_P1c)*10^6;
%  Row_AmpBloc6_P1_mean = AmpBloc6_P1/idataBloc6_P1;
%  AmpBloc6_P1_mean = (Row_AmpBloc6_P1_mean - baseline_mean_Bloc6_P1c)*10^6;
%  
%  Row_AmpBloc1_P2_mean = AmpBloc1_P2/idataBloc1_P2;
%  AmpBloc1_P2_mean = (Row_AmpBloc1_P2_mean - baseline_mean_Bloc1_P2c)*10^6;
%  Row_AmpBloc2_P2_mean = AmpBloc2_P2/idataBloc2_P2;
%  AmpBloc2_P2_mean = (Row_AmpBloc2_P2_mean - baseline_mean_Bloc2_P2c)*10^6;
%  Row_AmpBloc3_P2_mean = AmpBloc3_P2/idataBloc3_P2;
%  AmpBloc3_P2_mean = (Row_AmpBloc3_P2_mean - baseline_mean_Bloc3_P2c)*10^6;
%  Row_AmpBloc4_P2_mean = AmpBloc4_P2/idataBloc4_P2;
%  AmpBloc4_P2_mean = (Row_AmpBloc4_P2_mean - baseline_mean_Bloc4_P2c)*10^6;
%  Row_AmpBloc5_P2_mean = AmpBloc5_P2/idataBloc5_P2;
%  AmpBloc5_P2_mean = (Row_AmpBloc5_P2_mean - baseline_mean_Bloc5_P2c)*10^6;
%  Row_AmpBloc6_P2_mean = AmpBloc6_P2/idataBloc6_P2;
%  AmpBloc6_P2_mean = (Row_AmpBloc6_P2_mean - baseline_mean_Bloc6_P2c)*10^6;
% 
%  
%  % removing bloc baseline from all the corresponding trials
%  for itrial = 1:length(trialtriggers)
%      if trialtriggers(itrial).AmpTrial_P1 ~= 0 & trialtriggers(itrial).nbloc(1) == 1
%           trialtriggers(itrial).AmpTrial_P1 = (trialtriggers(itrial).AmpTrial_P1 - baseline_mean_Bloc1_P1)*10^6;
%           trialtriggers(itrial).AmpReward_P1 = (trialtriggers(itrial).AmpReward_P1 - baseline_mean_Bloc1_P1)*10^6;
%      elseif trialtriggers(itrial).AmpTrial_P1 ~= 0 & trialtriggers(itrial).nbloc(1) == 2
%           trialtriggers(itrial).AmpTrial_P1 = (trialtriggers(itrial).AmpTrial_P1 - baseline_mean_Bloc2_P1)*10^6; 
%           trialtriggers(itrial).AmpReward_P1 = (trialtriggers(itrial).AmpReward_P1 - baseline_mean_Bloc2_P1)*10^6;
%      elseif trialtriggers(itrial).AmpTrial_P1 ~= 0 & trialtriggers(itrial).nbloc(1) == 3
%               trialtriggers(itrial).AmpTrial_P1 = (trialtriggers(itrial).AmpTrial_P1 - baseline_mean_Bloc3_P1)*10^6;  
%               trialtriggers(itrial).AmpReward_P1 = (trialtriggers(itrial).AmpReward_P1 - baseline_mean_Bloc3_P1)*10^6;
%     elseif trialtriggers(itrial).AmpTrial_P1 ~= 0 & trialtriggers(itrial).nbloc(1) == 4
%               trialtriggers(itrial).AmpTrial_P1 = (trialtriggers(itrial).AmpTrial_P1 - baseline_mean_Bloc4_P1)*10^6; 
%               trialtriggers(itrial).AmpReward_P1 = (trialtriggers(itrial).AmpReward_P1 - baseline_mean_Bloc4_P1)*10^6;
%     elseif trialtriggers(itrial).AmpTrial_P1 ~= 0 & trialtriggers(itrial).nbloc(1) == 5
%               trialtriggers(itrial).AmpTrial_P1 = (trialtriggers(itrial).AmpTrial_P1 - baseline_mean_Bloc5_P1)*10^6; 
%               trialtriggers(itrial).AmpReward_P1 = (trialtriggers(itrial).AmpReward_P1 - baseline_mean_Bloc5_P1)*10^6;
%     elseif trialtriggers(itrial).AmpTrial_P1 ~= 0 & trialtriggers(itrial).nbloc(1) == 6
%               trialtriggers(itrial).AmpTrial_P1 = (trialtriggers(itrial).AmpTrial_P1 - baseline_mean_Bloc6_P1)*10^6;  
%               trialtriggers(itrial).AmpReward_P1 = (trialtriggers(itrial).AmpReward_P1 - baseline_mean_Bloc6_P1)*10^6;
% %     elseif trialtriggers(itrial).AmpTrial_P1 ~= 0 & trialtriggers(itrial).nbloc(1) == 7
% %               trialtriggers(itrial).AmpTrial_P1 = (trialtriggers(itrial).AmpTrial_P1 - baseline_mean_Bloc7_P1)*10^6;
% %               trialtriggers(itrial).AmpReward_P1 = (trialtriggers(itrial).AmpReward_P1 - baseline_mean_Bloc7_P1)*10^6;
% %     elseif trialtriggers(itrial).AmpTrial_P1 ~= 0 & trialtriggers(itrial).nbloc(1) == 8
% %               trialtriggers(itrial).AmpTrial_P1 = (trialtriggers(itrial).AmpTrial_P1 - baseline_mean_Bloc8_P1)*10^6;
% %               trialtriggers(itrial).AmpReward_P1 = (trialtriggers(itrial).AmpReward_P1 - baseline_mean_Bloc8_P1)*10^6;
%      end 
%  end
%  
%   for itrial = 1:length(trialtriggers)
%      if trialtriggers(itrial).AmpTrial_P2 ~= 0 & trialtriggers(itrial).nbloc(1) == 1
%           trialtriggers(itrial).AmpTrial_P2 = (trialtriggers(itrial).AmpTrial_P2 - baseline_mean_Bloc1_P2)*10^6;
%           trialtriggers(itrial).AmpReward_P2 = (trialtriggers(itrial).AmpReward_P2 - baseline_mean_Bloc1_P2)*10^6;
%      elseif trialtriggers(itrial).AmpTrial_P2 ~= 0 & trialtriggers(itrial).nbloc(1) == 2
%           trialtriggers(itrial).AmpTrial_P2 = (trialtriggers(itrial).AmpTrial_P2 - baseline_mean_Bloc2_P2)*10^6; 
%           trialtriggers(itrial).AmpReward_P2 = (trialtriggers(itrial).AmpReward_P2 - baseline_mean_Bloc2_P2)*10^6;
%      elseif trialtriggers(itrial).AmpTrial_P2 ~= 0 & trialtriggers(itrial).nbloc(1) == 3
%               trialtriggers(itrial).AmpTrial_P2 = (trialtriggers(itrial).AmpTrial_P2 - baseline_mean_Bloc3_P2)*10^6;  
%               trialtriggers(itrial).AmpReward_P2 = (trialtriggers(itrial).AmpReward_P2 - baseline_mean_Bloc3_P2)*10^6;
%     elseif trialtriggers(itrial).AmpTrial_P2 ~= 0 & trialtriggers(itrial).nbloc(1) == 4
%               trialtriggers(itrial).AmpTrial_P2 = (trialtriggers(itrial).AmpTrial_P2 - baseline_mean_Bloc4_P2)*10^6; 
%               trialtriggers(itrial).AmpReward_P2 = (trialtriggers(itrial).AmpReward_P2 - baseline_mean_Bloc4_P2)*10^6;
%     elseif trialtriggers(itrial).AmpTrial_P2 ~= 0 & trialtriggers(itrial).nbloc(1) == 5
%               trialtriggers(itrial).AmpTrial_P2 = (trialtriggers(itrial).AmpTrial_P2 - baseline_mean_Bloc5_P2)*10^6; 
%               trialtriggers(itrial).AmpReward_P2 = (trialtriggers(itrial).AmpReward_P2 - baseline_mean_Bloc5_P2)*10^6;
%     elseif trialtriggers(itrial).AmpTrial_P2 ~= 0 & trialtriggers(itrial).nbloc(1) == 6
%               trialtriggers(itrial).AmpTrial_P2 = (trialtriggers(itrial).AmpTrial_P2 - baseline_mean_Bloc6_P2)*10^6;  
%               trialtriggers(itrial).AmpReward_P2 = (trialtriggers(itrial).AmpReward_P2 - baseline_mean_Bloc6_P2)*10^6;
% %     elseif trialtriggers(itrial).AmpTrial_P1 ~= 0 & trialtriggers(itrial).nbloc(1) == 7
% %               trialtriggers(itrial).AmpTrial_P1 = (trialtriggers(itrial).AmpTrial_P1 - baseline_mean_Bloc7_P1)*10^6;
% %               trialtriggers(itrial).AmpReward_P1 = (trialtriggers(itrial).AmpReward_P1 - baseline_mean_Bloc7_P1)*10^6;
% %     elseif trialtriggers(itrial).AmpTrial_P1 ~= 0 & trialtriggers(itrial).nbloc(1) == 8
% %               trialtriggers(itrial).AmpTrial_P1 = (trialtriggers(itrial).AmpTrial_P1 - baseline_mean_Bloc8_P1)*10^6;
% %               trialtriggers(itrial).AmpReward_P1 = (trialtriggers(itrial).AmpReward_P1 - baseline_mean_Bloc8_P1)*10^6;
%      end 
%  end
%  
%  AmpHard = 0;
%  AmpEasy = 0;
%  
%  
%  
%  
%  condB1 = 0;
%  condB2 = 0;
%  condB3 = 0;
%  condB4 = 0;
%  condB5 = 0;
%  condB6 = 0;
%  condB7 = 0;
%  condB8 = 0;
%  
% 
%  MeanAmp_blocs_P1 = [AmpBloc1_mean; AmpBloc2_mean; AmpBloc3_mean; AmpBloc4_mean; AmpBloc5_mean; AmpBloc6_mean; AmpBloc7_mean; AmpBloc8_mean];
%  MeanQ1_EDA_Blocs = [MeanQ1_blocs, MeanAmp_blocs];
%  MeanQ2_EDA_Blocs = [MeanQ2_blocs, MeanAmp_blocs];
%  MeanPerf_EDA_Blocs = [MeanPerf_blocs, MeanAmp_blocs];
%  
% %  [R1, P1] = corrplot(MeanQ1_EDA_Blocs)
% %  [R2, P2] = corrplot(MeanQ2_EDA_Blocs)
% %  [R3, P3] = corrplot(MeanPerf_EDA_Blocs)
%  
%  [R1, P1] = corrcoef(MeanQ1_blocs, MeanAmp_blocs)
%  [R2, P2] = corrcoef(MeanQ2_blocs, MeanAmp_blocs)
%  [R3, P3] = corrcoef(MeanPerf_blocs, MeanAmp_blocs)
%  
%  for itrial = 1
%      
%      if bloctriggers(1).cond(1) == 1
%          AmpEasy = AmpEasy + AmpBloc1_mean;
%          condB1 = 1;
%      elseif bloctriggers(1).cond(1) == 2
%          AmpHard= AmpHard + AmpBloc1_mean;
%          condB1 = 2;
%      end 
%  end 
%  
% for itrial = 25   
%      if bloctriggers(25).cond(1) == 1
%          AmpEasy = AmpEasy + AmpBloc2_mean;
%          condB2 = 1;
%      elseif bloctriggers(25).cond(1) == 2
%          AmpHard= AmpHard + AmpBloc2_mean;
%          condB2 = 2;
%      end 
% end
%  for itrial = 49     
%      if bloctriggers(49).cond(1) == 1
%          AmpEasy = AmpEasy + AmpBloc3_mean;
%          condB3 = 1;
%      elseif bloctriggers(49).cond(1) == 2
%          AmpHard= AmpHard + AmpBloc3_mean;
%          condB3 = 2;
%      end
%  end 
%  for itrial = 73    
%      if bloctriggers(73).cond(1) == 1
%          AmpEasy = AmpEasy + AmpBloc4_mean;
%          condB4 = 1;
%      elseif bloctriggers(73).cond(1) == 2
%          AmpHard= AmpHard + AmpBloc4_mean;
%          condB4 = 2;
%      end 
%  end
%  for itrial = 97    
%      if bloctriggers(97).cond(1) == 1
%          AmpEasy = AmpEasy + AmpBloc5_mean;
%          condB5 = 1;
%      elseif bloctriggers(97).cond(1) == 2
%          AmpHard= AmpHard + AmpBloc5_mean;
%          condB5 =2;
%      end 
%  end
%  for itrial = 121   
%      if bloctriggers(121).cond(1) == 1
%          AmpEasy = AmpEasy + AmpBloc6_mean;
%          condB6 = 1;
%      elseif bloctriggers(121).cond(1) == 2
%          AmpHard= AmpHard + AmpBloc6_mean;
%          condB6 = 2;
%      end
%  end
%  for itrial = 145     
%      if bloctriggers(145).cond(1) == 1
%          AmpEasy = AmpEasy + AmpBloc7_mean;
%          condB7 = 1;
%      elseif bloctriggers(145).cond(1) == 2
%          AmpHard= AmpHard + AmpBloc7_mean;
%          condB7 = 2;
%      end
%  end
%  if part ~= ['DA']
%  for itrial = 169   
%      if bloctriggers(169).cond(1) == 1
%          AmpEasy = AmpEasy + AmpBloc8_mean;
%          condB8 = 1;
%      elseif bloctriggers(169).cond(1) == 2
%          AmpHard= AmpHard + AmpBloc8_mean;
%          condB8 = 2;
%      end 
%  end 
%  end
%   
%  
%  AmpEasy_mean = AmpEasy/4;
%  if part == ['DA']
%      AmpHard_mean = AmpHard/3;
%  else
%      AmpHard_mean = AmpHard/4;
%  end 
%  difAmp = AmpHard_mean - AmpEasy_mean;
%  DifAmp_ALL(ipar, :) = difAmp;
%  
% %  Row_AmpEasy_mean = AmpEasy/idataEasy
% %  Row_AmpHard_mean = AmpHard/idataHard
% %  Row_difAmp = AmpHard - AmpEasy
% 
% AmpTrial_correl = [];
% 
% for itrial = 1:length(trialtriggers)
%     
%         AmpTrial_correl(itrial).amp = trialtriggers(itrial).AmpTrial;
%         AmpTrial_correl(itrial).inc = trialtriggers(itrial).AmpIncrease;
%         if trialtriggers(itrial).AmpTrial ~= 0
%             AmpTrial_correl(itrial).Q1 = ResultsQ1(itrial);
%             AmpTrial_correl(itrial).Q2 = ResultsQ2(itrial);
%             if trialtriggers(itrial).cond(1) == 1
%                 AmpTrial_correl(itrial).cond = 1;
%             elseif trialtriggers(itrial).cond(2) == 2
%                 AmpTrial_correl(itrial).cond = 2;
%             end
%             if trialtriggers(itrial).nbloc(1) == 1
%                 AmpTrial_correl(itrial).nbloc = 1;
%             elseif trialtriggers(itrial).nbloc(1) == 2
%                 AmpTrial_correl(itrial).nbloc = 2;
%             elseif trialtriggers(itrial).nbloc(1) == 3
%                 AmpTrial_correl(itrial).nbloc = 3;   
%             elseif trialtriggers(itrial).nbloc(1) == 4
%                 AmpTrial_correl(itrial).nbloc = 4;
%             elseif trialtriggers(itrial).nbloc(1) == 5
%                 AmpTrial_correl(itrial).nbloc = 5;   
%             elseif trialtriggers(itrial).nbloc(1) == 6
%                 AmpTrial_correl(itrial).nbloc = 6; 
%             elseif trialtriggers(itrial).nbloc(1) == 7
%                 AmpTrial_correl(itrial).nbloc = 7;   
%             elseif trialtriggers(itrial).nbloc(1) == 8
%                 AmpTrial_correl(itrial).nbloc = 8;
%             end 
%         end 
% 
% end
% 
% AmpTrial_correl = [AmpTrial_correl.amp; AmpTrial_correl.Q1; AmpTrial_correl.Q2; AmpTrial_correl.inc; AmpTrial_correl.cond; AmpTrial_correl.nbloc]'; % reshape matrix to delete empty rows
% 
% AmpInc_Easy = 0;
% AmpInc_Hard = 0;
% n_HardTrials = 0;
% n_EasyTrials = 0;
% 
% for i = 1:length(AmpTrial_correl)
%     if AmpTrial_correl(i, 5) == 1 % condition 1
%         n_EasyTrials = n_EasyTrials  + 1;
%         AmpInc_Easy = AmpInc_Easy + AmpTrial_correl(i, 4) % add Inc for the trial
%     elseif AmpTrial_correl(i, 5) == 2% condition 2
%         n_HardTrials = n_EasyTrials  + 1;
%         AmpInc_Hard = AmpInc_Hard + AmpTrial_correl(i, 4) % add Inc for the trial
%     end 
% end 
% 
% Mean_AmpInc_Easy = AmpInc_Easy / n_EasyTrials
% Mean_AmpInc_Hard = AmpInc_Hard / n_HardTrials
% Dif_AmpInc = Mean_AmpInc_Hard - Mean_AmpInc_Easy
% 
% AmpInc_B1 = 0;
% n_B1 = 0;
% AmpInc_B2 = 0;
% n_B2 = 0;
% AmpInc_B3 = 0;
% n_B3 = 0;
% AmpInc_B4 = 0;
% n_B4 = 0;
% AmpInc_B5 = 0;
% n_B5 = 0;
% AmpInc_B6 = 0;
% n_B6 = 0;
% AmpInc_B7 = 0;
% n_B7 = 0;
% AmpInc_B8 = 0;
% n_B8 = 0;
% 
% for i = 1:length(AmpTrial_correl)
%     if AmpTrial_correl(i, 6) == 1 % bloc 1
%         n_B1 = n_B1  + 1;
%         AmpInc_B1 = AmpInc_B1 + AmpTrial_correl(i, 4) % add Amp Increase for the trial
%     elseif AmpTrial_correl(i, 6) == 2% condition 2
%         n_B2 = n_B2  + 1;
%         AmpInc_B2 = AmpInc_B2 + AmpTrial_correl(i, 4) % add Inc for the trial
%     elseif AmpTrial_correl(i, 6) == 3% condition 2
%         n_B3 = n_B3  + 1;
%         AmpInc_B3 = AmpInc_B3 + AmpTrial_correl(i, 4) % add Inc for the trial
%     elseif AmpTrial_correl(i, 6) == 4% condition 2
%         n_B4 = n_B4  + 1;
%         AmpInc_B4 = AmpInc_B4 + AmpTrial_correl(i, 4) % add Inc for the trial
%     elseif AmpTrial_correl(i, 6) == 5% condition 2
%         n_B5 = n_B5  + 1;
%         AmpInc_B5 = AmpInc_B5 + AmpTrial_correl(i, 4) % add Inc for the trial
%     elseif AmpTrial_correl(i, 6) == 6% condition 2
%         n_B6 = n_B6  + 1;
%         AmpInc_B6 = AmpInc_B6 + AmpTrial_correl(i, 4) % add Inc for the trial    
%     elseif AmpTrial_correl(i, 6) == 7% condition 2
%         n_B7 = n_B7  + 1;
%         AmpInc_B7 = AmpInc_B7 + AmpTrial_correl(i, 4) % add Inc for the trial
%     elseif AmpTrial_correl(i, 6) == 8% condition 2
%         n_B8 = n_B8  + 1;
%         AmpInc_B8 = AmpInc_B8 + AmpTrial_correl(i, 4) % add Inc for the trial
%     end 
% end 
% 
% Mean_AmpInc_B1 = AmpInc_B1 / n_B1
% Mean_AmpInc_B2 = AmpInc_B2 / n_B2
% Mean_AmpInc_B3 = AmpInc_B3 / n_B3
% Mean_AmpInc_B4 = AmpInc_B4 / n_B4
% Mean_AmpInc_B5 = AmpInc_B5 / n_B5
% Mean_AmpInc_B6 = AmpInc_B6 / n_B6
% Mean_AmpInc_B7 = AmpInc_B7 / n_B7
% Mean_AmpInc_B8 = AmpInc_B8 / n_B8
% 
% [R_amp_Q1_trials, P_amp_Q1_trials] = corrplot(AmpTrial_correl(:, 1:2))
% [R_amp_Q1_trials, P_amp_Q1_trials] = corrcoef(AmpTrial_correl(:, 1), AmpTrial_correl(:, 2))
% %[R_amp_Q2_trials, P_amp_Q2_trials] = corrplot(AmpTrial_correl(:, 1:2))
% [R_amp_Q2_trials, P_amp_Q2_trials] = corrcoef(AmpTrial_correl(:, 1), AmpTrial_correl(:, 3))
% [R_ampInc_Q1_trials, P_ampInc_Q1_trials] = corrcoef(AmpTrial_correl(:, 4), AmpTrial_correl(:, 2))
% [R_ampInc_Q2_trials, P_ampInc_Q2_trials] = corrcoef(AmpTrial_correl(:, 4), AmpTrial_correl(:, 3))
%  
% phyData_all(ipar, :) =  [R(1,2); P(1,2); R1(1,2); P1(1,2); R2(1,2); P2(1,2); R3(1,2); P3(1,2); AmpBloc1_mean; condB1; AmpBloc2_mean; condB2; AmpBloc3_mean; condB3; AmpBloc4_mean; condB4; AmpBloc5_mean; condB5; AmpBloc6_mean; condB6; AmpBloc7_mean; condB7; AmpBloc8_mean; condB8; AmpEasy_mean; AmpHard_mean; difAmp; R_amp_Q1_trials(1,2); P_amp_Q1_trials(1,2); R_amp_Q2_trials(1,2); P_amp_Q2_trials(1,2); R_ampInc_Q1_trials(1,2); R_ampInc_Q2_trials(1,2); Mean_AmpInc_Easy; Mean_AmpInc_Hard; Dif_AmpInc];
% phyData_all(ipar, :) = phyData_all(ipar, :)';
% MeanQ1_blocs_all(ipar, :) = [MeanQ1_blocs];
% % MeanQ1_blocs_ALL = [MeanQ1_blocs_all(1, :), MeanQ1_blocs_all(2, :), MeanQ1_blocs_all(3, :), MeanQ1_blocs_all(4, :), MeanQ1_blocs_all(5, :), MeanQ1_blocs_all(6, :), MeanQ1_blocs_all(7, :), MeanQ1_blocs_all(8, :), MeanQ1_blocs_all(9, :)]';
% MeanQ2_blocs_all(ipar, :) = [MeanQ2_blocs];
% % MeanQ2_blocs_ALL = [MeanQ2_blocs_all(1, :), MeanQ2_blocs_all(2, :), MeanQ2_blocs_all(3, :), MeanQ2_blocs_all(4, :), MeanQ2_blocs_all(5, :), MeanQ2_blocs_all(6, :), MeanQ2_blocs_all(7, :), MeanQ2_blocs_all(8, :), MeanQ2_blocs_all(9, :)]';
% MeanPerf_blocs_all(ipar, :) = [MeanPerf_blocs];
% % MeanPerf_blocs_ALL = [MeanPerf_blocs_all(1, :), MeanPerf_blocs_all(2, :), MeanPerf_blocs_all(3, :), MeanPerf_blocs_all(4, :), MeanPerf_blocs_all(5, :), MeanPerf_blocs_all(6, :), MeanPerf_blocs_all(7, :), MeanPerf_blocs_all(8, :), MeanPerf_blocs_all(9, :)]';
% MeanAmp_blocs_all(ipar, :) = [MeanAmp_blocs];
% % MeanAmp_blocs_ALL = [MeanAmp_blocs_all(1, :), MeanAmp_blocs_all(2, :), MeanAmp_blocs_all(3, :), MeanAmp_blocs_all(4, :), MeanAmp_blocs_all(5, :), MeanAmp_blocs_all(6, :), MeanAmp_blocs_all(7, :), MeanAmp_blocs_all(8, :), MeanAmp_blocs_all(9, :)]';
% MeanAmpInc_blocs_all(ipar, :) = [Mean_AmpInc_B1, Mean_AmpInc_B2, Mean_AmpInc_B3, Mean_AmpInc_B4, Mean_AmpInc_B5, Mean_AmpInc_B6, Mean_AmpInc_B7, Mean_AmpInc_B8];
% 
% 
% 
% 
% %end 
% 
% 
%        
%             
% MeanQ1_blocs_ALL = [MeanQ1_blocs_all(1, :), MeanQ1_blocs_all(2, :), MeanQ1_blocs_all(3, :), MeanQ1_blocs_all(4, :), MeanQ1_blocs_all(5, :), MeanQ1_blocs_all(6, :), MeanQ1_blocs_all(7, :), MeanQ1_blocs_all(8, :), MeanQ1_blocs_all(9, :)];%, MeanQ1_blocs_all(10, :) , MeanQ1_blocs_all(11, :), MeanQ1_blocs_all(12, :)]';
% MeanQ2_blocs_ALL = [MeanQ2_blocs_all(1, :), MeanQ2_blocs_all(2, :), MeanQ2_blocs_all(3, :), MeanQ2_blocs_all(4, :), MeanQ2_blocs_all(5, :), MeanQ2_blocs_all(6, :), MeanQ2_blocs_all(7, :), MeanQ2_blocs_all(8, :), MeanQ2_blocs_all(9, :)];%, MeanQ2_blocs_all(10, :) , MeanQ2_blocs_all(11, :), MeanQ2_blocs_all(12, :)]';
% MeanPerf_blocs_ALL = [MeanPerf_blocs_all(1, :), MeanPerf_blocs_all(2, :), MeanPerf_blocs_all(3, :), MeanPerf_blocs_all(4, :), MeanPerf_blocs_all(5, :), MeanPerf_blocs_all(6, :), MeanPerf_blocs_all(7, :), MeanPerf_blocs_all(8, :), MeanPerf_blocs_all(9, :)]; %,MeanPerf_blocs_all(10, :), MeanPerf_blocs_all(11, :), MeanPerf_blocs_all(12, :)]';
% MeanAmp_blocs_ALL = [MeanAmp_blocs_all(1, :), MeanAmp_blocs_all(2, :), MeanAmp_blocs_all(3, :), MeanAmp_blocs_all(4, :), MeanAmp_blocs_all(5, :), MeanAmp_blocs_all(6, :), MeanAmp_blocs_all(7, :), MeanAmp_blocs_all(8, :), MeanAmp_blocs_all(9, :)]; %, MeanAmp_blocs_all(10, :), MeanAmp_blocs_all(11, :), MeanAmp_blocs_all(12, :)]';
% 
%  MeanQ1_EDA_Blocs_ALL = [MeanQ1_blocs_ALL, MeanAmp_blocs_ALL];
%  MeanQ2_EDA_Blocs_ALL = [MeanQ2_blocs_ALL, MeanAmp_blocs_ALL];
%  MeanPerf_EDA_Blocs_ALL = [MeanPerf_blocs_ALL, MeanAmp_blocs_ALL];
%  %DifQ1_ALL = [DifQ1_Easy_Hard(1, :), DifQ1_Easy_Hard(2, :), DifQ1_Easy_Hard(3, :), DifQ1_Easy_Hard(4, :), DifQ1_Easy_Hard(5, :), DifQ1_Easy_Hard(6, :), DifQ1_Easy_Hard(7, :), DifQ1_Easy_Hard(8, :),DifQ1_Easy_Hard(9, :)]'
%  %DifQ2_ALL = [DifQ2_Easy_Hard(1, :), DifQ2_Easy_Hard(2, :), DifQ2_Easy_Hard(3, :), DifQ2_Easy_Hard(4, :), DifQ2_Easy_Hard(5, :), DifQ2_Easy_Hard(6, :), DifQ2_Easy_Hard(7, :), DifQ2_Easy_Hard(8, :),DifQ2_Easy_Hard(9, :)]'
%  %DifPerf_ALL = [DifPerf_Easy_Hard(1, :), DifPerf_Easy_Hard(2, :), DifPerf_Easy_Hard(3, :), DifPerf_Easy_Hard(4, :), DifPerf_Easy_Hard(5, :), DifPerf_Easy_Hard(6, :), DifPerf_Easy_Hard(7, :), DifPerf_Easy_Hard(8, :),DifPerf_Easy_Hard(9, :)]'
%  %DifAmp_ALL = [DifAmp(1, :), DifAmp(2, :), DifAmp(3, :), DifAmp(4, :),DifAmp(5, :), DifAmp(6, :), DifAmp(7, :), DifAmp(8, :),DifAmp(9, :)]
%  
%  %  [R4, P4] = corrplot(MeanQ1_EDA_Blocs_ALL)
% %  [R5, P5] = corrplot(MeanQ2_EDA_Blocs_ALL)
% %  [R6, P6] = corrplot(MeanPerf_EDA_Blocs_ALL)
% 
%  %[R4, P4] = corrcoef(MeanQ1_blocs_ALL(1:95), MeanAmp_blocs_ALL(1:95))
%  [R4, P4] = corrcoef(MeanQ1_blocs_ALL(1:71), MeanAmp_blocs_ALL(1:71)) % 8 full participants * 8 full blocs + 1 partial participant with 7 blocs
%  %[R5, P5] = corrcoef(MeanQ2_blocs_ALL(1:95), MeanAmp_blocs_ALL(1:95))
%  [R5, P5] = corrcoef(MeanQ2_blocs_ALL(1:71), MeanAmp_blocs_ALL(1:71))
%  %[R6, P6] = corrcoef(MeanPerf_blocs_ALL(1:95), MeanAmp_blocs_ALL(1:95))
%  [R6, P6] = corrcoef(MeanPerf_blocs_ALL(1:71), MeanAmp_blocs_ALL(1:71))
%  
%  [R7, P7] = corrcoef(DifQ1_ALL, DifAmp_ALL)
%  [R8, P8] = corrcoef(DifQ2_ALL, DifAmp_ALL)
%  [R9, P9] = corrcoef(DifPerf_ALL, DifAmp_ALL)
% 
%  Correl_blocs_All = [R4(1,2); P4(1,2); R5(1,2); P5(1,2); R6(1,2); P6(1,2)]
%  
%  [h_Q1Q2corr, p_Q1Q2corr] = ttest(Data_all(:,105), 0, 'Alpha', 0.05)
%  mean(Data_all(:, 105))
%  [h_piedmain, p_piedmain] = ttest(phyData_all(:,1), 0, 'Alpha', 0.05)
%  mean(phyData_all(:, 1))
%  [h_EDA_dif, p_EDA_dif] = ttest(phyData_all(:, 25), phyData_all(:, 26), 'Alpha', 0.05)
%  mean(phyData_all(:, 25))
%  mean(phyData_all(:, 26))
%  
%  [h_Q1_dif, p_Q1_dif] = ttest(Data_all(:, 5),Data_all(:, 13), 'Alpha', 0.05)
%  mean(Data_all(:, 5))
%  mean(Data_all(:, 13))
%  [h_Q2_dif, p_Q2_dif] = ttest(Data_all(:, 6),Data_all(:, 14), 'Alpha', 0.05)
%  mean(Data_all(:, 6))
%  mean(Data_all(:, 14))
%  [h_Perf_dif, p_Perf_dif] = ttest(Data_all(:, 7),Data_all(:, 15), 'Alpha', 0.05)
%  mean(Data_all(:, 7))
%  mean(Data_all(:, 15))
%  [h_TR_dif, p_TR_dif] = ttest(Data_all(:, 8),Data_all(:, 16), 'Alpha', 0.05)
%  mean(Data_all(:, 8))
%  mean(Data_all(:, 16))
% [h_r_AmpQ1_trials, p_r_AmpQ1_trials] = ttest(phyData_all(:, 28),0, 'Alpha', 0.05)
%  mean(phyData_all(:, 28))
% [h_r_AmpQ2_trials, p_r_AmpQ2_trials] = ttest(phyData_all(:, 30),0, 'Alpha', 0.05)
%  mean(phyData_all(:, 30))
%  [h_EDAinc_Q1, p_EDAinc_Q1] = ttest(phyData_all(:, 32), 0, 'Alpha', 0.05) % per trial and per participant and then mean on all participants
%  mean(phyData_all(:, 32))
%  [h_EDAinc_Q2, p_EDAinc_Q2] = ttest(phyData_all(:, 33), 0, 'Alpha', 0.05) % per trial and per participant and then mean on all participants
% mean(phyData_all(:, 33))