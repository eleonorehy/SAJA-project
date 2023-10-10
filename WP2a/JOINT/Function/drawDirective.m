function drawDirective(expWindow, grey, text)
Screen('FillRect', expWindow, grey);
Screen('TextSize', expWindow, 20);
DrawFormattedText(expWindow, text, 'center', 'center');
end