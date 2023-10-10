NumberOfBloc = 8

onegain1 = [{'1.1'}',{'2.2'}',{'3.3'}']';
onegain2 = repmat({'0.0'}', [3, 1]);
onegain = [onegain1, onegain2];

symgain1 = [{'1.1'}', {'2.2'}', {'3.3'}']'; 
symgain2 = [{'1.1'}', {'2.2'}', {'3.3'}']';
symgain = [symgain1, symgain2];

asymgain1 = [{'1.0'}', {'2.1'}', {'3.2'}']'; % advantage for player 1 at left
asymgain2 = [{'0.1'}', {'1.2'}', {'2.3'}']'; % advantage for player 2 at right
asymgain = [asymgain1, asymgain2];

gains0 = [onegain1; symgain1;asymgain1];
gains0 = cell2mat(gains0);
gains02 = [onegain2; symgain2; asymgain2];
gains02 = cell2mat(gains02);
gains1 = [onegain1; symgain1; asymgain1];
gains1 = repmat(gains1, [4*NumberOfBloc, 1]);
gains2 = [onegain2; symgain2; asymgain2];
gains2 = repmat(gains2, [4*NumberOfBloc, 1]);
gains3 = [];
gains4 = [];

       
