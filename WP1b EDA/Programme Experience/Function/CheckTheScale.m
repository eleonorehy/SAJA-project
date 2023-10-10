function answer = CheckTheScale(Key)
[keyIsDown, secs, keyScale] = KbCheck;
while keyScale == 0
    [keyIsDown, secs, keyScale] = KbCheck;
end

if keyScale(Key.escape)
    sca;
elseif keyScale(Key.one)
    answer = 1;
elseif keyScale(Key.two)
    answer = 2;
elseif keyScale(Key.three)
    answer = 3;
elseif keyScale(Key.four)
    answer = 4;
elseif keyScale(Key.five)
    answer = 5;
elseif keyScale(Key.six)
    answer = 6;
elseif keyScale(Key.seven)
    answer = 7;
elseif keyScale(Key.eight)
    answer = 8;
elseif keyScale(Key.nine)
    answer = 9;
end

while not(keyScale(Key.one) == 0 && keyScale(Key.two) == 0 && keyScale(Key.three) == 0 && keyScale(Key.four) == 0 && keyScale(Key.five) == 0 && keyScale(Key.six) == 0 && keyScale(Key.seven) == 0 && keyScale(Key.eight) == 0 && keyScale(Key.nine) == 0)
    [keyIsDown, secs, keyScale] = KbCheck;
end

end