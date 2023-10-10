function passKey(spaceKey)
[keyIsDown, secs, keyCode] = KbCheck;
while keyCode(spaceKey) == 0
    [keyIsDown, secs, keyCode] = KbCheck;
end
while not(keyCode(spaceKey)==0) 
    [keyIsDown, secs, keyCode] = KbCheck;
end
end