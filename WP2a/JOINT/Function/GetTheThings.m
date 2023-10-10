function [Info, expWindow]=GetTheThings(screenColor, screenSize)
screens = Screen('Screens');
whichscreen = max(screens);
[expWindow, rectWindow] = Screen('OpenWindow', whichscreen, screenColor, screenSize);
Info.rect = Screen('Rect', expWindow);
[Info.screenXpixels,Info.screenYpixels] = Screen('WindowSize', expWindow);
[Info.xC,Info.yC] = RectCenter(rectWindow);
Info.ifi = Screen('GetFlipInterval', expWindow);
Info.hertz = FrameRate(expWindow);
Info.nominalHertz = Screen('NominalFrameRate', expWindow);
Info.pixelSize = Screen('PixelSize', expWindow);
[Info.width, Info.height] = Screen('DisplaySize', whichscreen);
Info.maxLum = Screen('ColorRange', expWindow);
end