function [condition,which,sub,gender,date] = subjectVariables
prompt = {'Condition','WhichSubject','Subject''s name','Subject''s gender','Date'};
dlgSubj_title = 'Enter participant variables: ';
num_lines = 1;
answerSubj = inputdlg(prompt, dlgSubj_title, num_lines);
switch isempty(answerSubj)
    case 1
        error(faill)
    case 0
        condition = (answerSubj{1});
        which = (answerSubj{2});
        sub = (answerSubj{3});
        gender = (answerSubj{4});
        date = (answerSubj{5});
end
end


 
  