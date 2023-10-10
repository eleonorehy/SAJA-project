function answer = CheckTheScale(Key)
[keyIsDown, secs, keyScale] = KbCheck;
while keyScale == 0
    [keyIsDown, secs, keyScale] = KbCheck;
end

if keyScale(Key.escape)
    sca;
elseif keyScale(Key.one)
    answer = 0;
elseif keyScale(Key.two)
    answer = 100;
elseif keyScale(Key.three)
    answer = 200;
elseif keyScale(Key.four)
    answer = 300;
elseif keyScale(Key.five)
    answer = 400;
elseif keyScale(Key.six)
    answer = 500;
elseif keyScale(Key.seven)
    answer = 600;
elseif keyScale(Key.eight)
    answer = 700;
elseif keyScale(Key.nine)
    answer = 800;
elseif keyScale(Key.ten)
    answer = 900;
end

while not(keyScale(Key.one) == 0 && keyScale(Key.two) == 0 && keyScale(Key.three) == 0 && keyScale(Key.four) == 0 && keyScale(Key.five) == 0 && keyScale(Key.six) == 0 && keyScale(Key.seven) == 0 && keyScale(Key.eight) == 0 && keyScale(Key.nine) == 0)
    [keyIsDown, secs, keyScale] = KbCheck;
end

end